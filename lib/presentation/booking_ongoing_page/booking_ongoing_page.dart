import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hotel_app/core/app_export.dart';
import 'package:hotel_app/presentation/booking_ongoing_tab_container_page/booking_ongoing_tab_container_page.dart';
import 'package:hotel_app/presentation/home_screen_container_screen/home_screen_container_screen.dart';
import '../../services/notif_service.dart';
import '../booking_cancelled_page/booking_cancelled_page.dart';
import '../booking_ongoing_page/widgets/bookingongoing_item_widget.dart';
import '../home_screen_page/hotel_class/hotel_list_model.dart';
import '../view_ticket_screen/view_ticket_screen.dart';
import 'booking_info_model.dart';

class BookingOngoingPage extends StatefulWidget {
 const BookingOngoingPage({Key? key}) : super(key: key);

 @override
 BookingOngoingPageState createState() => BookingOngoingPageState();
}

class BookingOngoingPageState extends State<BookingOngoingPage> with AutomaticKeepAliveClientMixin<BookingOngoingPage> {
 late List<BookingInfo> bookings;
 late User? user;
 late Timer _timer; // Add a timer variable

 @override
 void initState() {
  super.initState();
  bookings = [];
  user = FirebaseAuth.instance.currentUser; // Obtain the current user
  loadBookings();

  // Set up a timer to check for completed bookings every minute
  _timer = Timer.periodic(Duration(minutes: 1), (Timer timer) {
   checkAndMoveCompletedBookings();
  });
 }

 void checkAndMoveCompletedBookings() {
  DateTime currentDateTime = DateTime.now();

  List<BookingInfo> completedBookings = bookings
      .where((booking) => booking.isCompleted())
      .toList();

  if (completedBookings.isNotEmpty) {
   moveCompletedBookingsToCompletedPage(completedBookings);
  }
 }

 void moveCompletedBookingsToCompletedPage(List<BookingInfo> completedBookings) async {
  // Access the Firestore instance
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Check if the user is signed in and has a valid UID
  if (user != null && user!.uid != null) {
   // Access the user ID
   String userUid = user!.uid;

   // Collection reference for the specific user's 'OngoingBookings' collection
   CollectionReference ongoingBookingsCollection = firestore.collection('users').doc(userUid).collection('OngoingBookings');

   // Collection reference for the specific user's 'CompletedBookings' collection
   CollectionReference completedBookingsCollection = firestore.collection('users').doc(userUid).collection('CompletedBookings');

   for (BookingInfo booking in completedBookings) {
    try {
     // Booking is completed, delete it from the 'OngoingBookings' collection
     await ongoingBookingsCollection.doc(booking.id).delete();
     print("Booking deleted from 'OngoingBookings' collection");
    } catch (e) {
     print("Error deleting booking from 'OngoingBookings' collection: $e");
     // Handle the error as needed
    }

    // Add the booking to the 'CompletedBookings' collection
    await completedBookingsCollection.add({
     'title': booking.title,
     'location': booking.location,
     'image': booking.image,
     'checkInDate': booking.checkInDate,
     'checkOutDate': booking.checkOutDate,
     // Include other fields based on your BookingInfo model
    });
   }

   // Update the UI accordingly
   setState(() {
    bookings.removeWhere((booking) => completedBookings.contains(booking));
   });

   // Show a SnackBar to indicate successful completion
   ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
     content: Text('Bookings completed and moved successfully!'),
     backgroundColor: Color(0xFF1AADB6), // Set background color to green
    ),
   );
  } else {
   print("User is not signed in or user UID is null");
  }
 }

 void loadBookings() async {
  if (user != null && user!.uid != null) {
   String userUid = user!.uid;
   FirebaseFirestore firestore = FirebaseFirestore.instance;
   CollectionReference ongoingBookingsCollection = firestore.collection('users').doc(userUid).collection('OngoingBookings');

   QuerySnapshot querySnapshot = await ongoingBookingsCollection.get();

   setState(() {
    bookings = querySnapshot.docs.map((doc) => BookingInfo.fromFirestore(doc)).toList();
   });
  }
 }

 @override
 bool get wantKeepAlive => true;

 @override
 Widget build(BuildContext context) {
  mediaQueryData = MediaQuery.of(context);
  return SafeArea(
   child: Scaffold(
    body: Container(
     width: double.maxFinite,
     decoration: AppDecoration.fillOnPrimary,
     child: Column(
      children: [
       SizedBox(height: 30.v),
       _buildBookingOngoing(context),
      ],
     ),
    ),
   ),
  );
 }

 Widget _buildBookingOngoing(BuildContext context) {
  return Expanded(
   child: Padding(
    padding: EdgeInsets.symmetric(horizontal: 24.h),
    child: bookings.isEmpty
        ? Center(
     child: Text(
      'No bookings.',
      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
     ),
    )
        : ListView.separated(
     physics: BouncingScrollPhysics(),
     shrinkWrap: true,
     separatorBuilder: (context, index) {
      return SizedBox(height: 20.v);
     },
     itemCount: bookings.length,
     itemBuilder: (context, index) {
      return BookingongoingItemWidget(
       title: bookings[index].title,
       image: bookings[index].image,
       location: bookings[index].location,
       onTapBookingActionCancelBooking: () {
        onTapBookingActionCancelBooking(context, bookings[index]);
       },
       onTapBookingActionViewTicket: () {
        onTapBookingActionViewTicket(context, bookings[index]);
       },
      );
     },
    ),
   ),
  );
 }

 void onTapBookingActionCancelBooking(BuildContext context, BookingInfo booking) {
  showDialog(
   context: context,
   builder: (context) => AlertDialog(
    backgroundColor: Color(0xFF24272F),
    title: Text(
     'Are you sure you want to cancel the booking?',
     style: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
     ),
    ),
    actions: <Widget>[
     TextButton(
      onPressed: () => Navigator.of(context).pop(false),
      style: ButtonStyle(
       backgroundColor: MaterialStateProperty.all(Color(0xFF24272F)),
      ),
      child: Text(
       'No',
       style: TextStyle(color: Colors.white),
      ),
     ),
     TextButton(
      onPressed: () {
       // Perform cancellation logic here
       // For example, you can delete the booking from Firestore
       // and update the UI accordingly
       cancelBooking(booking);
       Navigator.of(context).pop(true);
      },
      style: ButtonStyle(
       backgroundColor: MaterialStateProperty.all(Color(0xFF1AADB6)),
      ),
      child: Text(
       'Yes',
       style: TextStyle(color: Colors.white),
      ),
     ),
    ],
   ),
  );
 }

 void cancelBooking(BookingInfo booking) async {
  // Access the Firestore instance
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Check if the user is signed in and has a valid UID
  if (user != null && user!.uid != null) {
   // Access the user ID
   String userUid = user!.uid;

   // Collection reference for the specific user's 'OngoingBookings' collection
   CollectionReference ongoingBookingsCollection = firestore.collection('users').doc(userUid).collection('OngoingBookings');

   try {
    // Delete the ongoing booking from Firestore using the correct bookingId
    await ongoingBookingsCollection.doc(booking.id).delete();

    NotificationService().simpleNotificationShow(
     title: 'Booking Canceled',
     body: 'Your booking for ${booking.title} has been canceled.',
    );

    print("Booking deleted from 'OngoingBookings' collection");
   } catch (e) {
    print("Error deleting booking from 'OngoingBookings' collection: $e");
    // Handle the error as needed
   }

   // Collection reference for the specific user's 'onCancelledBooking' collection
   CollectionReference cancelledBookingsCollection = firestore.collection('users').doc(userUid).collection('onCancelledBooking');

   // Add a new document with a generated ID
   DocumentReference bookingDocRef = await cancelledBookingsCollection.add({
    'title': booking.title,
    'location': booking.location,
    'image': booking.image,
    // Include other fields based on your BookingInfo model
   });

   print("Data added to 'onCancelledBooking' collection with ID: ${bookingDocRef.id}");

   // Update the UI accordingly
   setState(() {
    bookings.remove(booking);
   });

   // Show a SnackBar to indicate successful cancellation
   ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
     content: Text('Booking cancelled successfully!'),
     backgroundColor: Color(0xFF1AADB6), // Set background color to green
    ),
   );

   // Push the canceled booking to the BookingOngoingTabContainerPage
   Navigator.push(
    context,
    MaterialPageRoute(
     builder: (context) => BookingOngoingTabContainerPage(),
    ),
   );
  } else {
   print("User is not signed in or user UID is null");
  }
 }

 /// Navigates to the viewTicketScreen when the action is triggered.
 void onTapBookingActionViewTicket(BuildContext context, BookingInfo booking) {
  Fluttertoast.showToast(
   msg: 'QR Code Generated! Make sure to take a screenshot of it.',
   toastLength: Toast.LENGTH_LONG,
   gravity: ToastGravity.BOTTOM,
   timeInSecForIosWeb: 1,
   backgroundColor: Color(0xFF1AADB6), // Set background color to #1AADB6
   textColor: Colors.white, // Set text color to white
   fontSize: 16.0,
  );

  Navigator.push(
   context,
   MaterialPageRoute(builder: (context) => ViewTicketScreen(booking: booking)),
  );
 }

 @override
 void dispose() {
  // Cancel the timer when the widget is disposed
  _timer.cancel();
  super.dispose();
 }
}