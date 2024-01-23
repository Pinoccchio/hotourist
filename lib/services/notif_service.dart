import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

class NotificationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FlutterLocalNotificationsPlugin notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('ic_launcher');

    final DarwinInitializationSettings initializationIos =
    DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) {},
    );

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationIos,
    );

    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {},
    );
  }

  Future<void> sendNotification(String title, String body) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      await _firestore.collection('notifications').add({
        'userId': currentUser.uid,
        'title': title,
        'body': body,
        'timestamp': FieldValue.serverTimestamp(),
        'read': false, // Mark the notification as unread by default
      });
    }
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
  getNotificationsForUser(String userId) async {
    final snapshot = await _firestore
        .collection('notifications')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .get();
    return snapshot.docs;
  }

  Future<void> simpleNotificationShow({
    required String title,
    required String body,
    String androidIcon = 'ic_launcher',
    bool channelShowBadge = true,
    int? notificationId,
  }) async {
    notificationId ??= _generateUniqueId();

    final String uniqueId = _generateUniqueId().toString();

    final AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      uniqueId,
      uniqueId,
      priority: Priority.high,
      importance: Importance.max,
      icon: androidIcon,
      channelShowBadge: channelShowBadge,
      largeIcon: DrawableResourceAndroidBitmap(androidIcon),
    );

    final NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);

    await notificationsPlugin.show(
      notificationId!,
      title,
      body,
      notificationDetails,
    );

    // Store the notification in Firestore
    await sendNotification(title, body);
  }

  Stream<List<Map<String, dynamic>>> streamNotifications() {
    return _firestore
        .collection('notifications')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> snapshot) {
      return snapshot.docs.map((doc) {
        DateTime notificationDate =
        (doc['timestamp'] as Timestamp).toDate(); // Extract timestamp
        DateTime now = DateTime.now();
        String groupBy = _calculateGrouping(notificationDate, now);
        return {
          'id': doc.id,
          'groupBy': groupBy,
          'title': doc['title'],
          'body': doc['body'],
        };
      }).toList();
    });
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

  int _generateUniqueId() {
    return DateTime.now().millisecondsSinceEpoch.remainder(1 << 31);
  }
}