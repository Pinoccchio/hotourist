import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_app/core/app_export.dart';
import 'package:hotel_app/presentation/booking_completed_page/widgets/bookingcompletedlist_item_widget.dart';

class BookingCompletedPage extends StatefulWidget {
  const BookingCompletedPage({Key? key}) : super(key: key);

  @override
  BookingCompletedPageState createState() => BookingCompletedPageState();
}

class BookingCompletedPageState extends State<BookingCompletedPage>
    with AutomaticKeepAliveClientMixin<BookingCompletedPage> {
  @override
  bool get wantKeepAlive => true;

  String userUid = FirebaseAuth.instance.currentUser!.uid;

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
              _buildBookingCompletedList(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookingCompletedList(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.h),
        child: FutureBuilder<List<DocumentSnapshot>>(
          future: getCompletedBookings(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text('No completed bookings.'),
              );
            } else {
              List<DocumentSnapshot> completedBookings = snapshot.data!;

              return ListView.separated(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 20.v,
                  );
                },
                itemCount: completedBookings.length,
                itemBuilder: (context, index) {
                  var hotelName = completedBookings[index]['hotelName'];
                  var hotelLocation = completedBookings[index]['hotelLocation'];
                  return BookingcompletedlistItemWidget(
                    hotelName: hotelName,
                    hotelLocation: hotelLocation,
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Future<List<DocumentSnapshot>> getCompletedBookings() async {
    CollectionReference ongoingBookingsCollection =
    FirebaseFirestore.instance.collection('users').doc(userUid).collection('OngoingBookings');

    DateTime currentDateTime = DateTime.now();

    QuerySnapshot querySnapshot = await ongoingBookingsCollection
        .where('completedTimestamp', isNotEqualTo: null)
        .orderBy('completedTimestamp', descending: true)
        .get();

    List<DocumentSnapshot> completedBookings = querySnapshot.docs
        .where((booking) {
      DateTime checkOutDateTime = (booking['checkOutDate'] as Timestamp).toDate();

      // Check if the check-out date is equal to the current date
      return checkOutDateTime.isAtSameMomentAs(currentDateTime);
    })
        .toList();

    return completedBookings;
  }
}