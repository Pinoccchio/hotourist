// booking_cancelled_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class CanceledBooking {
  final String title;
  final String location;
  final String image;

  CanceledBooking({
    required this.title,
    required this.location,
    required this.image,
  });

  factory CanceledBooking.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return CanceledBooking(
      title: data['title'] ?? '',
      location: data['location'] ?? '',
      image: data['image'] ?? '',
    );
  }
}
