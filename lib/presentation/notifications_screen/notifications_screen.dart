import 'package:badges/badges.dart' as badges;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:hotel_app/core/app_export.dart';
import 'package:hotel_app/presentation/notifications_screen/widgets/sectionlist_item_widget.dart';
import 'package:hotel_app/widgets/app_bar/appbar_leading_image.dart';
import 'package:hotel_app/widgets/app_bar/appbar_title.dart';
import 'package:hotel_app/widgets/app_bar/appbar_trailing_image.dart';
import 'package:hotel_app/widgets/app_bar/custom_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../../services/notif_service.dart';

class NotificationsScreen extends StatefulWidget {
 final VoidCallback updateUnreadCount;

 NotificationsScreen({required this.updateUnreadCount});

 @override
 _NotificationsScreenState createState() => _NotificationsScreenState();
}


class _NotificationsScreenState extends State<NotificationsScreen> {
 int unreadNotificationsCount = 0;
 List<Map<String, dynamic>> sectionListItemList = [];
 final FirebaseFirestore _firestore = FirebaseFirestore.instance;
 bool showNotificationCount = true;

 @override
 void initState() {
  super.initState();
  // Fetch notifications from Firestore when the screen is initialized
  _loadNotifications();
 }

 Future<void> _loadNotifications() async {
  final currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser != null) {
   final notifications =
   await NotificationService().getNotificationsForUser(currentUser.uid);
   setState(() {
    sectionListItemList = notifications.map((doc) {
     // Check if the notification is unread
     bool isUnread = !doc['read'] ?? false;
     if (isUnread) {
      // Increment the unread count
      unreadNotificationsCount++;
     }

     Timestamp timestamp = doc['timestamp'] as Timestamp;
     DateTime notificationDate = timestamp.toDate(); // Use toDate() method
     DateTime now = DateTime.now();
     String groupBy = _calculateGrouping(notificationDate, now);
     return {
      'id': doc.id,
      'groupBy': groupBy,
      'title': doc['title'],
      'body': doc['body'],
      'isUnread': isUnread,
     };
    }).toList();
   });
  }
 }

 // Helper method to calculate the grouping dynamically
 String _calculateGrouping(DateTime notificationDate, DateTime now) {
  if (notificationDate.year == now.year &&
      notificationDate.month == now.month &&
      notificationDate.day == now.day) {
   return 'Today';
  } else if (notificationDate.year == now.year &&
      notificationDate.month == now.month &&
      notificationDate.day == now.day - 1) {
   return 'Yesterday';
  } else {
   return DateFormat('MMMM d, y').format(notificationDate);
  }
 }

 @override
 Widget build(BuildContext context) {
  showNotificationCount = false;
  return SafeArea(
   child: Scaffold(
    appBar: _buildAppBar(context),
    body: _buildBody(),
   ),
  );
 }

 Widget _buildBody() {
  return Padding(
   padding: EdgeInsets.fromLTRB(24.h, 31.v, 24.h, 5.v),
   child: Stack(
    children: [
     sectionListItemList.isEmpty
         ? Center(
      child: Text(
       'No notification',
       style: TextStyle(
        fontSize: 18,
        color: Colors.grey,
       ),
      ),
     )
         : GroupedListView<dynamic, String>(
      elements: sectionListItemList,
      groupBy: (element) => element['groupBy'],
      groupSeparatorBuilder: (String value) {
       return Padding(
        padding: EdgeInsets.only(top: 25.v, bottom: 22.v),
        child: Text(
         value,
         style: CustomTextStyles.titleMediumSemiBold_1.copyWith(
          color: appTheme.whiteA700,
         ),
        ),
       );
      },
      itemBuilder: (context, model) {
       return SectionlistItemWidget(
        title: model['title'],
        body: model['body'],
       );
      },
      order: GroupedListOrder.DESC,
      separator: SizedBox(height: 24.v),
     ),
     Positioned(
      bottom: 16.0,
      right: 16.0,
      child: FloatingActionButton(
       onPressed: () {
        // Call a method to delete all notifications
        _deleteAllNotifications(context);
       },
       child: Icon(Icons.delete),
      ),
     ),
    ],
   ),
  );
 }

 PreferredSizeWidget _buildAppBar(BuildContext context) {
  return CustomAppBar(
   height: 52.v,
   leadingWidth: 52.h,
   leading: AppbarLeadingImage(
    imagePath: ImageConstant.imgArrowLeft,
    margin: EdgeInsets.only(left: 24.h, top: 11.v, bottom: 13.v),
    onTap: () => onTapArrowLeft(context),
   ),
   title: AppbarTitle(
    text: "Notifications",
    margin: EdgeInsets.only(left: 16.h),
   ),
  );
 }

 Future<void> _deleteAllNotifications(BuildContext context) async {
  print("Clicked!");
  final currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser != null) {
   // Show a confirmation dialog
   bool confirmed = await showDialog(
    context: context,
    builder: (BuildContext context) {
     return AlertDialog(
      backgroundColor: Color(0xFF24272F),
      title: Text(
       'Are you sure you want to delete all notifications?',
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
        onPressed: () => Navigator.of(context).pop(true),
        style: ButtonStyle(
         backgroundColor: MaterialStateProperty.all(Color(0xFF1AADB6)),
        ),
        child: Text(
         'Yes',
         style: TextStyle(color: Colors.white),
        ),
       ),
      ],
     );
    },
   );

   // If user confirms, delete the notifications
   if (confirmed == true) {
    await _firestore
        .collection('notifications')
        .where('userId', isEqualTo: currentUser.uid)
        .get()
        .then((querySnapshot) {
     querySnapshot.docs.forEach((doc) {
      doc.reference.delete();
     });
    });

    // Reset the unread count and reload notifications
    setState(() {
     unreadNotificationsCount = 0;
     sectionListItemList = [];
    });
    widget.updateUnreadCount();

    _loadNotifications();
   }
  }
 }

 void onTapArrowLeft(BuildContext context) {
  Navigator.pop(context);
 }
}
