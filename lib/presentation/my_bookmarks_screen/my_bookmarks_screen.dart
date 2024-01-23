import 'package:flutter/material.dart';
import 'package:hotel_app/core/app_export.dart';
import 'package:hotel_app/presentation/my_bookmarks_screen/widgets/bookmark_provider.dart';
import 'package:provider/provider.dart' as provider;
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../home_screen_page/hotel_class/hotel_list_model.dart';
import '../home_screen_page/hotel_class/touristSpot_list_model.dart';
import '../hotel_details_screen/hotel_details_screen.dart';
import '../tourist_details_screen/tourist_details_screen.dart';
import 'widgets/mybookmarks_item_widget.dart';

class MyBookmarksScreen extends StatelessWidget {
 const MyBookmarksScreen({Key? key}) : super(key: key);

 @override
 Widget build(BuildContext context) {
  BookmarkProvider bookmarkProvider = provider.Provider.of<BookmarkProvider>(context);
  mediaQueryData = MediaQuery.of(context);

  return SafeArea(
   child: Scaffold(
    appBar: _buildAppBar(context),
    body: Padding(
     padding: EdgeInsets.only(left: 24.h, top: 24.v, right: 24.h),
     child: (bookmarkProvider.bookmarkedHotels.isEmpty && bookmarkProvider.bookmarkedTourists.isEmpty)
         ? Center(
      child: Text(
       'No saved bookmarks yet.',
       style: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
       ),
      ),
     )
         : GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
       mainAxisExtent: 281.v,
       crossAxisCount: 2,
       mainAxisSpacing: 24.h,
       crossAxisSpacing: 24.h,
      ),
      physics: BouncingScrollPhysics(),
      itemCount: bookmarkProvider.bookmarkedHotels.length + bookmarkProvider.bookmarkedTourists.length,
      itemBuilder: (context, index) {
       if (index < bookmarkProvider.bookmarkedHotels.length) {
        HotelListData bookmarkedHotel = bookmarkProvider.bookmarkedHotels[index];
        return MybookmarksItemWidget(
         bookmarkedData: bookmarkedHotel,
         onTapItem: () {
          onTapItem(context, bookmarkedHotel);
         },
        );
       } else {
        TouristListData bookmarkedTourist = bookmarkProvider.bookmarkedTourists[index - bookmarkProvider.bookmarkedHotels.length];
        return MybookmarksItemWidget(
         bookmarkedData: bookmarkedTourist,
         onTapItem: () {
          onTapItem(context, bookmarkedTourist);
         },
        );
       }
      },
     ),
    ),
   ),
  );
 }

 PreferredSizeWidget _buildAppBar(BuildContext context) {
  BookmarkProvider bookmarkProvider = provider.Provider.of<BookmarkProvider>(context, listen: false);

  return CustomAppBar(
   leadingWidth: 52.h,
   leading: AppbarLeadingImage(
    imagePath: ImageConstant.imgArrowLeft,
    margin: EdgeInsets.only(left: 24.h, top: 11.v, bottom: 16.v),
    onTap: () {
     onTapArrowLeft(context);
    },
   ),
   title: AppbarTitle(
    text: "My Bookmarks",
    margin: EdgeInsets.only(left: 16.h),
   ),
   actions: [
    AppbarTrailingImage(
     imagePath: 'assets/images/delete_icon.png',
     margin: EdgeInsets.only(left: 20.h, top: 11.v, right: 16.h),
     onTap: () {
      showDialog(
       context: context,
       builder: (context) {
        return AlertDialog(
         backgroundColor: Color(0xFF24272F),
         title: Text(
          'Are you sure you want to delete all bookmarks?',
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
            Navigator.of(context).pop(true);
            bookmarkProvider.clearBookmarks();
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
        );
       },
      );
     },
    ),
   ],
  );
 }

 void onTapItem(BuildContext context, dynamic bookmarkedItem) {
  if (bookmarkedItem is HotelListData) {
   Navigator.push(
    context,
    MaterialPageRoute(
     builder: (context) => HotelDetailsScreen(hotelData: bookmarkedItem),
    ),
   );
  } else if (bookmarkedItem is TouristListData) {
   Navigator.push(
    context,
    MaterialPageRoute(
     builder: (context) => TouristDetailsScreen(touristData: bookmarkedItem),
    ),
   );
  }
 }

 void onTapArrowLeft(BuildContext context) {
  Navigator.pop(context);
 }
}