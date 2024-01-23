import 'package:cloud_firestore/cloud_firestore.dart';

class BookingInfo {
  String id; // Add this field for the booking ID
  String title;
  String location; // New field
  String image; // New field
  String fullName;
  String nickName;
  DateTime checkInDate;
  DateTime checkOutDate;
  int guestCount;
  int totalPrice;
  String email;
  String phone;
  // Remove completedTimestamp field

  BookingInfo({
    required this.id, // Update the constructor to include the booking ID
    required this.title,
    required this.location,
    required this.image,
    required this.fullName,
    required this.nickName,
    required this.checkInDate,
    required this.checkOutDate,
    required this.guestCount,
    required this.totalPrice,
    required this.email,
    required this.phone,
    // Remove completedTimestamp from the constructor
  });

  bool isCompleted() {
    DateTime currentDateTime = DateTime.now();
    return currentDateTime.isAfter(checkOutDate);
  }

  // Constructor to create BookingInfo from Firestore document
  BookingInfo.fromFirestore(DocumentSnapshot document)
      : id = document.id, // Assign the document ID to the 'id' field
        title = document['title'],
        location = document['location'],
        image = document['image'],
        fullName = document['fullName'],
        nickName = document['nickName'],
        checkInDate = (document['checkInDate'] as Timestamp).toDate(),
        checkOutDate = (document['checkOutDate'] as Timestamp).toDate(),
        guestCount = document['guestCount'],
        totalPrice = document['totalPrice'],
        email = document['email'],
        phone = document['phone'];
// Map other fields from Firestore

// Add other helper methods or fields as needed
}