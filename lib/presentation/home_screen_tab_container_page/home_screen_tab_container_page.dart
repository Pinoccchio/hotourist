import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotel_app/core/app_export.dart';
import 'package:hotel_app/presentation/home_screen_page/tab_list/hotel_home_screen.dart';
import 'package:hotel_app/presentation/home_screen_page/tab_list/tourist_spot_home_screen.dart';
import 'package:hotel_app/presentation/notifications_screen/notifications_screen.dart';
import 'package:hotel_app/widgets/app_bar/appbar_leading_image.dart';
import 'package:hotel_app/widgets/app_bar/appbar_title.dart';
import 'package:hotel_app/widgets/app_bar/appbar_trailing_image.dart';
import 'package:hotel_app/widgets/app_bar/custom_app_bar.dart';
import '../../services/notif_service.dart';
import '../chat_screen/chat_screen.dart';
import '../home_screen_page/hotel_class/hotel_list_model.dart';
import '../home_screen_page/tab_list/trending_home_screen.dart';
import '../my_bookmarks_screen/my_bookmarks_screen.dart';

class HomeScreenTabContainerPage extends StatefulWidget {
  const HomeScreenTabContainerPage({Key? key}) : super(key: key);

  @override
  HomeScreenTabContainerPageState createState() => HomeScreenTabContainerPageState();
}

class HomeScreenTabContainerPageState extends State<HomeScreenTabContainerPage> with TickerProviderStateMixin {
  late TabController tabviewController;
  String? userName;
  String _greetingMessage = '';
  List<HotelListData> filteredHotelList = [];
  int unreadNotificationsCount = 0;


  @override
  void initState() {
    super.initState();
    tabviewController = TabController(length: 2, vsync: this);
    _loadUserName();
    _updateGreetingMessage();
    // Fetch unread notifications count
    _fetchUnreadNotificationsCount();
  }

  _fetchUnreadNotificationsCount() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final notifications = await NotificationService().getNotificationsForUser(currentUser.uid);
      setState(() {
        unreadNotificationsCount = notifications.where((doc) => !doc['read']).length;
      });
    }
  }

  _loadUserName() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String email = user.email ?? "";
      String providerId = user.providerData.first.providerId;

      if (providerId == "password") {
        DocumentReference userDoc = FirebaseFirestore.instance
            .collection('HotelApp')
            .doc('Users')
            .collection('User_Profile')
            .doc(email);

        try {
          DocumentSnapshot<Object?> snapshot = await userDoc.get();

          if (snapshot.exists) {
            setState(() {
              userName = snapshot['nickname'];
            });
          } else {
            userName = "Stranger";
          }
        } catch (e) {
          print("Error loading user data: $e");
          userName = "Stranger"; // Provide a default value
        }
      } else if (providerId == "google.com") {
        if (user.displayName != null) {
          setState(() {
            List<String> names = user.displayName!.split(" ");
            if (names.length >= 2) {
              userName = "${names.first} ${names.last[0].toUpperCase()}${names.last.substring(1)}!";
            } else {
              userName = user.displayName!;
            }
          });
        } else {
          userName = "Stranger";
        }
      }
    }
  }

  void _updateGreetingMessage() {
    DateTime now = DateTime.now().toUtc().add(const Duration(hours: 8));

    int hour = now.hour;

    if (hour >= 5 && hour < 12) {
      _greetingMessage = 'Magandang umaga';
    } else if (hour >= 12 && hour < 17) {
      _greetingMessage = 'Magandang hapon';
    } else if (hour >= 17 && hour < 21) {
      _greetingMessage = 'Magandang gabi';
    } else {
      _greetingMessage = 'Magandang gabi';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              SizedBox(height: 25.v),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 24.h),
                  child: Text("$_greetingMessage${userName != null ? ', $userName' : ''} 👋", style: theme.textTheme.headlineLarge),
                ),
              ),
              SizedBox(height: 31.v),
              _buildTabview(context),
              Expanded(
                child: SizedBox(
                  height: 1313.v,
                  child: TabBarView(
                    controller: tabviewController,
                    children: [
                      HotelHomeScreenPage(),
                      TouristSpotHomeScreenPage(),
                      //TrendingHomeScreenPage(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 50.v,
      leadingWidth: 56.h,
      leading: GestureDetector(
        onTap: () {},
        child: AppbarLeadingImage(
          imagePath: 'lib/images/logo.png',
          margin: EdgeInsets.only(left: 24.h, top: 9.v, bottom: 9.v),
        ),
      ),
      title: AppbarTitle(
        text: "Hotourist",
        margin: EdgeInsets.only(left: 16.h),
      ),
      actions: [
        // Badge for notifications
        badges.Badge(
          position: badges.BadgePosition.topEnd(top: 0, end: 3),
          badgeContent: Text(
            '$unreadNotificationsCount',
            style: TextStyle(color: Colors.white),
          ),
          child: AppbarTrailingImage(
            imagePath: ImageConstant.imgIcons,
            margin: EdgeInsets.only(left: 24.h, top: 11.v, right: 11.h),
            onTap: () {
              onTapIcons(context);
            },
          ),
        ),
        // Bookmark icon for MyBookmarksScreen
        AppbarTrailingImage(
          imagePath: ImageConstant.imgBookmark,  // Add the appropriate bookmark icon
          margin: EdgeInsets.only(left: 24.h, top: 11.v, right: 11.h),
          onTap: () {
            onTapBookmarks(context);
          },
        ),
      ],
    );
  }

  void onTapBookmarks(BuildContext context) {
    print("Clicked!");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyBookmarksScreen(),
      ),
    );
  }



  Widget _buildTabview(BuildContext context) {
    return Container(
      height: 38.v,
      width: 376.h,
      child: TabBar(
        controller: tabviewController,
        labelPadding: EdgeInsets.zero,
        labelColor: appTheme.whiteA700,
        labelStyle: TextStyle(fontSize: 16.fSize, fontFamily: 'Urbanist', fontWeight: FontWeight.w600),
        unselectedLabelColor: theme.colorScheme.primary,
        unselectedLabelStyle: TextStyle(fontSize: 16.fSize, fontFamily: 'Urbanist', fontWeight: FontWeight.w600),
        indicator: BoxDecoration(
          color: theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(19.h),
        ),
        tabs: [
          Tab(child: Text("Hotel")),
          Tab(child: Text("Tourist Spot")),
          //Tab(child: Text("Trending")),
        ],
      ),
    );
  }

  onTapIcons(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NotificationsScreen(
          updateUnreadCount: _fetchUnreadNotificationsCount,
        ),
      ),
    );
  }
}