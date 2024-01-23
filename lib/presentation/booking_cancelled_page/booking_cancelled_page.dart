import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_app/core/app_export.dart';
import 'package:hotel_app/presentation/booking_cancelled_page/widgets/bookingcancelledlist_item_widget.dart';

import 'cancelled_booking_model.dart';

class BookingCancelledPage extends StatefulWidget {
  const BookingCancelledPage({Key? key}) : super(key: key);

  @override
  BookingCancelledPageState createState() => BookingCancelledPageState();
}

class BookingCancelledPageState extends State<BookingCancelledPage>
    with AutomaticKeepAliveClientMixin<BookingCancelledPage> {
  List<CanceledBooking> canceledBookings = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    loadCanceledBookings();
  }

  Future<void> loadCanceledBookings() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null && user.uid != null) {
      String userUid = user.uid;
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference cancelledBookingsCollection =
      firestore.collection('users').doc(userUid).collection('onCancelledBooking');

      QuerySnapshot querySnapshot = await cancelledBookingsCollection.get();

      setState(() {
        canceledBookings = querySnapshot.docs
            .map((doc) => CanceledBooking.fromFirestore(doc))
            .toList();
      });
    }
  }

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
              _buildBookingCancelledList(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookingCancelledList(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.h),
        child: canceledBookings.isEmpty
            ? Center(
          child: Text(
            'No cancelled bookings.',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        )
            : ListView.separated(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) {
            return SizedBox(height: 20.v);
          },
          itemCount: canceledBookings.length,
          itemBuilder: (context, index) {
            return BookingCancelledListItemWidget(
              canceledBooking: canceledBookings[index],
            );
          },
        ),
      ),
    );
  }
}
