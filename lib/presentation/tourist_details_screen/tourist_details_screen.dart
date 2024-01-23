import 'dart:async';
import 'dart:math';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hotel_app/core/app_export.dart';
import 'package:hotel_app/presentation/home_screen_page/hotel_class/touristSpot_list_model.dart';
import 'package:hotel_app/presentation/hotel_details_screen/widgets/framenineteen_item_widget.dart';
import 'package:hotel_app/presentation/hotel_details_screen/widgets/rectangle_item_widget.dart';
import 'package:hotel_app/presentation/review_tab_container_screen/tourist_review_tab_container_screen.dart';
import 'package:hotel_app/presentation/tourist_gallery_screen/gallery_screen.dart';
import 'package:hotel_app/widgets/app_bar/appbar_leading_image.dart';
import 'package:hotel_app/widgets/app_bar/appbar_trailing_image.dart';
import 'package:hotel_app/widgets/app_bar/custom_app_bar.dart';
import 'package:hotel_app/widgets/custom_elevated_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:provider/provider.dart' as provider;
import '../my_bookmarks_screen/widgets/bookmark_provider.dart';
import '../select_date_guest_screen/tourist_select_date_guest_screen.dart';

class TouristDetailsScreen extends StatefulWidget {
 final TouristListData touristData;
 TouristDetailsScreen({Key? key, required this.touristData}) : super(key: key);

 @override
 _TouristDetailsScreenState createState() => _TouristDetailsScreenState();
}

class _TouristDetailsScreenState extends State<TouristDetailsScreen> {
 Completer<GoogleMapController> googleMapController = Completer();
 List<Map<String, dynamic>> comments = [];
 late MediaQueryData mediaQueryData;
 late TouristListData touristData;

 @override
 void initState() {
  super.initState();
  touristData = widget.touristData;
  fetchComments();
 }

 // Function to check if the current hotel is bookmarked
 bool isBookmarked(BuildContext context) {
  BookmarkProvider bookmarkProvider = provider.Provider.of<BookmarkProvider>(context, listen: false);
  return bookmarkProvider.isBookmarked(touristData);
 }

 // Replace your existing fetchComments method with the modified version
 Future<void> fetchComments() async {
  try {
   var snapshot = await FirebaseFirestore.instance
       .collection('HotelApp')
       .doc('Tourist_User_Comments_Ratings')
       .collection(widget.touristData.titleTxt)
       .get();
   setState(() {
    Set<String> uniqueUserEmails = Set();
    List<Map<String, dynamic>> uniqueComments = [];

    snapshot.docs.forEach((doc) {
     String userEmail = doc.data()['userEmail'];
     if (!uniqueUserEmails.contains(userEmail)) {
      uniqueUserEmails.add(userEmail);
      uniqueComments.add({
       'userEmail': userEmail,
       'userRate': doc.data()['userRate'],
       'userComment': doc.data()['userComment'],
       'timestamp': doc['timestamp'],
       'userProfile': doc.data()['userProfile'],
       'commentId': doc.id,
      });
     }
    });

    comments = uniqueComments;
   });
  } catch (e) {
   print('Error fetching comments: $e');
  }
 }

 @override
 Widget build(BuildContext context) {
  mediaQueryData = MediaQuery.of(context);

  return WillPopScope(
   onWillPop: () async {
    onTapArrowLeft(context);
    return false;
   },
   child: SafeArea(
    child: Scaffold(
     appBar: _buildAppBar(context),
     body: SizedBox(
      width: mediaQueryData.size.width,
      child: SingleChildScrollView(
       child: Padding(
        padding: EdgeInsets.only(bottom: 5.v),
        child: Column(
         children: [
          _buildEightySeven(context, widget.touristData),
          SizedBox(height: 24.v),
          _buildHotelDetails(context),
          SizedBox(height: 35.v),
          _buildGalleryPhotos(context),
          //SizedBox(height: 32.v),
          //_buildDetails(context),
          SizedBox(height: 33.v),
          _buildDescription(context),
          //SizedBox(height: 31.v),
          //_buildFacilities(context),
          SizedBox(height: 31.v),
          _buildLocation(context, widget.touristData.location),
          SizedBox(height: 32.v),
          _buildReview(context),
          SizedBox(height: 35.v),
          _buildPrice(context),
         ],
        ),
       ),
      ),
     ),
    ),
   ),
  );
 }

 Widget _buildHotelDetails(BuildContext context) {
  return Container(
   padding: EdgeInsets.symmetric(horizontal: 24.h),
   child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
     Text(touristData.titleTxt, style: theme.textTheme.headlineLarge),
     SizedBox(height: 15.v),
     Row(
      children: [
       CustomImageView(
        imagePath: ImageConstant.imgLocation,
        height: 20.adaptSize,
        width: 20.adaptSize,
       ),
       Padding(
        padding: EdgeInsets.only(left: 8.h),
        child: Text(touristData.subTxt, style: CustomTextStyles.bodyMediumGray50_1),
       ),
      ],
     ),
    ],
   ),
  );
 }


 Widget _buildDetails(BuildContext context) {
  return Container(
   padding: EdgeInsets.symmetric(horizontal: 24.h),
   child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
     Text("Details", style: theme.textTheme.titleMedium),
     SizedBox(height: 18.v),
     Align(
      alignment: Alignment.center,
      child: Padding(
       padding: EdgeInsets.symmetric(horizontal: 28.h, vertical: 8.v),
       child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         _buildDetailColumn(
          ImageConstant.imgFramePrimary,
          "Hotels",
         ),
         _buildDetailColumn(
          ImageConstant.imgFramePrimary32x32,
          "4 Bedrooms",
         ),
         _buildDetailColumn(
          ImageConstant.imgFrame32x32,
          "2 Bathrooms",
         ),
         _buildDetailColumn(
          ImageConstant.imgFrame1,
          "4000 sqft",
         ),
        ],
       ),
      ),
     ),
    ],
   ),
  );
 }

 Widget _buildDetailColumn(String imagePath, String label) {
  return Column(
   children: [
    CustomImageView(
     imagePath: imagePath,
     height: 32.adaptSize,
     width: 32.adaptSize,
    ),
    SizedBox(height: 7.v),
    Text(
     label,
     style: theme.textTheme.labelLarge,
    ),
   ],
  );
 }

 Widget _buildDescription(BuildContext context) {
  return Container(
   padding: EdgeInsets.symmetric(horizontal: 24.h),
   child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
     Text("Description", style: theme.textTheme.titleMedium),
     SizedBox(height: 17.v),
     Text(
      touristData.hotelDesc,
      style: CustomTextStyles.bodyMediumGray50,
     ),
    ],
   ),
  );
 }

 /// Section Widget
 Widget _buildFacilities(BuildContext context) {
  return Container(
   padding: EdgeInsets.symmetric(horizontal: 24.h),
   child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
     Text("Facilities", style: theme.textTheme.titleMedium),
     SizedBox(height: 22.v),
     Row(
      children: [
       _buildFacilityColumn(
        ImageConstant.imgCut,
        "Swimming Pool",
       ),
       _buildFacilityColumn(
        ImageConstant.imgSignal,
        "WiFi",
       ),
       _buildFacilityColumn(
        ImageConstant.imgCutPrimary,
        "Restaurant",
       ),
       _buildFacilityColumn(
        ImageConstant.imgTwitter,
        "Parking",
       ),
      ],
     ),
     SizedBox(height: 21.v),
     Row(
      children: [
       _buildFacilityColumn(
        ImageConstant.imgOffer,
        "Meeting Room",
       ),
       _buildFacilityColumn(
        ImageConstant.imgVectorPrimary24x24,
        "Elevator",
       ),
       _buildFacilityColumn(
        ImageConstant.imgVector,
        "Fitness Center",
       ),
       _buildFacilityColumn(
        ImageConstant.imgVectorPrimary,
        "24-hours Open",
       ),
      ],
     ),
    ],
   ),
  );
 }

 Widget _buildFacilityColumn(String imagePath, String label) {
  return Column(
   children: [
    CustomImageView(
     imagePath: imagePath,
     height: 24.v,
     width: 26.h,
    ),
    SizedBox(height: 12.v),
    Text(
     label,
     style: theme.textTheme.labelLarge,
    ),
   ],
  );
 }

 /// Section Widget
 Widget _buildLocation(BuildContext context, LatLng hotelLocation) {
  return Container(
   padding: EdgeInsets.symmetric(horizontal: 24.h),
   child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
     Text("Location", style: theme.textTheme.titleMedium),
     SizedBox(height: 18.v),
     SizedBox(
      height: 180.v,
      width: 380.h,
      child: Stack(
       alignment: Alignment.center,
       children: [
        SizedBox(
         height: 180.v,
         width: 380.h,
         child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
           target: hotelLocation, // Use the provided hotel location
           zoom: 15,
          ),
          onMapCreated: (GoogleMapController controller) {
           googleMapController.complete(controller);
          },
          zoomControlsEnabled: false,
          zoomGesturesEnabled: false,
          myLocationButtonEnabled: false,
          myLocationEnabled: false,
         ),
        ),
        CustomImageView(
         imagePath: ImageConstant.imgLocation,
         height: 40.adaptSize,
         width: 40.adaptSize,
         alignment: Alignment.center,
        ),
       ],
      ),
     ),
    ],
   ),
  );
 }

 /// Section Widget
 Widget _buildReview(BuildContext context) {
  return Container(
   padding: EdgeInsets.symmetric(horizontal: 24.h),
   child: Column(
    children: [
     Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       Text("Review", style: theme.textTheme.titleMedium),
       CustomImageView(
        imagePath: ImageConstant.imgStarYellowA700,
        height: 16.adaptSize,
        width: 16.adaptSize,
        margin: EdgeInsets.only(left: 21.h, bottom: 4.v),
       ),
       Padding(
        padding: EdgeInsets.only(left: 4.h, bottom: 2.v),
        child: Text(
         "${touristData.rating.toStringAsFixed(1)}", // Limit to 1 decimal place
         style: CustomTextStyles.titleMediumPrimarySemiBold,
        ),
       ),
       Padding(
        padding: EdgeInsets.only(left: 8.h, top: 4.v, bottom: 3.v),
        child: Text(
         "(${touristData.reviews} reviews)", // Use the reviews count from hotelData
         style: theme.textTheme.bodySmall,
        ),
       ),
       Spacer(),
       GestureDetector(
        onTap: () {
         onTapTxtSeeAll1(context);
        },
        child: Text(
         "See All",
         style: CustomTextStyles.titleMediumPrimary16,
        ),
       ),
      ],
     ),
     SizedBox(height: 19.v),
     // Check if there are comments
     comments.isEmpty
         ? Text("No comments yet.") // Display a message when no comments
         : Column(
      children: [
       // Display only the first 3 comments initially
       for (int i = 0; i < min(2, comments.length); i++)
        CommentItemWidget(comment: comments[i]),
       if (comments.length > 3)
        TextButton(
         onPressed: () {
          onTapTxtSeeAll1(context);
         },
         child: Text('View All Comments'),
        ),
      ],
     ),
    ],
   ),
  );
 }

 /// Section Widget
 Widget _buildGalleryPhotos(BuildContext context) {
  return Container(
   padding: EdgeInsets.symmetric(horizontal: 24.h),
   child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
     Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
       Text("Gallery Photos", style: theme.textTheme.titleMedium),
       GestureDetector(
        onTap: () {
         onTapTxtSeeAll(context, touristData);
        },
        child: Padding(
         padding: EdgeInsets.only(bottom: 2.v),
         child: Text(
          "See All",
          style: CustomTextStyles.titleMediumPrimary16,
         ),
        ),
       ),
      ],
     ),
     SizedBox(height: 16.v),
     SizedBox(
      height: 100.v,
      child: ListView.separated(
       padding: EdgeInsets.only(right: 88.h),
       scrollDirection: Axis.horizontal,
       separatorBuilder: (context, index) {
        return SizedBox(width: 12.h);
       },
       itemCount: touristData.touristImages.length,
       itemBuilder: (context, index) {
        return RectangleItemWidget(
         hotelImages: touristData.touristImages[index],
        );
       },
      ),
     ),
    ],
   ),
  );
 }


 PreferredSizeWidget _buildAppBar(BuildContext context) {
  return CustomAppBar(
   height: 50.v,
   leadingWidth: 52.h,
   leading: AppbarLeadingImage(
    imagePath: ImageConstant.imgArrowLeftWhiteA700,
    margin: EdgeInsets.only(left: 24.h, top: 11.v, bottom: 11.v),
    onTap: () {
     onTapArrowLeft(context);
    },
   ),
   actions: [
    AppbarTrailingImage(
     imagePath: isBookmarked(context)
         ? 'assets/images/img_bookmark_primary.svg' // Use the filled bookmark icon if bookmarked
         : 'assets/images/img_bookmark.svg',
     margin: EdgeInsets.only(left: 24.h, top: 11.v, right: 11.h),
     onTap: () {
      onTapBookmark(context);
     },
    ),
   ],
  );
 }

 // Function to handle bookmark button tap
 void onTapBookmark(BuildContext context) {
  BookmarkProvider bookmarkProvider =
  provider.Provider.of<BookmarkProvider>(context, listen: false);

  if (bookmarkProvider.isBookmarked(touristData)) {
   bookmarkProvider.removeBookmark(touristData);
   ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Removed from bookmarks')),
   );
  } else {
   bookmarkProvider.addBookmark(touristData);
   ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Added to bookmarks')),
   );
  }
 }


 Widget _buildEightySeven(BuildContext context, TouristListData touristData) {
  CarouselController _carouselController = CarouselController();
  int _currentIndex = 0;

  return SizedBox(
   height: 206,
   width: double.maxFinite,
   child: Stack(
    alignment: Alignment.center,
    children: [
     CarouselSlider.builder(
      carouselController: _carouselController,
      itemCount: touristData.touristImages.length,
      itemBuilder: (context, index, realIndex) {
       return CustomImageView(
        imagePath: touristData.touristImages[index],
        height: 206,
        width: 428,
        alignment: Alignment.center,
       );
      },
      options: CarouselOptions(
       autoPlay: true,
       autoPlayInterval: Duration(seconds: 3),
       autoPlayAnimationDuration: Duration(milliseconds: 800),
       autoPlayCurve: Curves.fastOutSlowIn,
       enlargeCenterPage: true,
       onPageChanged: (index, reason) {
        setState(() {
         _currentIndex = index;
        });
       },
      ),
     ),
     Align(
      alignment: Alignment.bottomCenter,
      child: Container(
       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
       decoration: BoxDecoration(
        gradient: LinearGradient(
         colors: [Colors.transparent],
         begin: Alignment.topCenter,
         end: Alignment.bottomCenter,
        ),
       ),
       child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
       ),
      ),
     ),
    ],
   ),
  );
 }

 Widget _buildPrice(BuildContext context) {
  return Padding(
   padding: EdgeInsets.symmetric(horizontal: 24.h),
   child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
     Padding(
      padding: EdgeInsets.symmetric(vertical: 9.v),
      child: Text(
       "${touristData.perNight}", // Use the price from HotelListData
       style: CustomTextStyles.headlineLargePrimary,
      ),
     ),
     Padding(
      padding: EdgeInsets.only(left: 4.h, top: 20.v, bottom: 21.v),
      child: Text("/ night", style: CustomTextStyles.bodyMediumGray40001),
     ),
     CustomElevatedButton(
      height: 58.v,
      width: 263.h,
      text: "Book Now!",
      margin: EdgeInsets.only(left: 17.h),
      buttonStyle: CustomButtonStyles.outlineGreenAF,
      onPressed: () {
       onTapBookNow(context);
      },
     ),
    ],
   ),
  );
 }

 // Navigates back to the previous screen.
 onTapArrowLeft(BuildContext context) {
  Navigator.pop(context);
 }

 void onTapTxtSeeAll1(BuildContext context) {
  Navigator.push(
   context,
   MaterialPageRoute(
    builder: (context) => TouristReviewTabContainerScreen(touristData: touristData),
   ),
  );
 }

 // Navigates to the galleryScreen when the action is triggered.
 void onTapTxtSeeAll(BuildContext context, TouristListData touristData) {
  Navigator.push(
   context,
   MaterialPageRoute(
    builder: (context) => TouristGalleryScreen(touristData: touristData),
   ),
  );
 }


 onTapBookNow(BuildContext context) {
  print("Clicked");
  Navigator.push(
   context,
   MaterialPageRoute(
    builder: (context) => TouristSelectDateGuestScreen(
     touristData: touristData,
     touristPrice: touristData.perNight,
    ),
   ),
  );
 }
}