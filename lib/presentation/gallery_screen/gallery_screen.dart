import 'package:flutter/material.dart';
import 'package:hotel_app/core/app_export.dart';
import 'package:hotel_app/presentation/gallery_screen/widgets/gallery_item_widget.dart';
import 'package:hotel_app/widgets/app_bar/appbar_leading_image.dart';
import 'package:hotel_app/widgets/app_bar/appbar_title.dart';
import 'package:hotel_app/widgets/app_bar/appbar_trailing_image.dart';
import 'package:hotel_app/widgets/app_bar/custom_app_bar.dart';
import '../home_screen_page/hotel_class/hotel_list_model.dart';

class GalleryScreen extends StatelessWidget {
 final HotelListData hotelData;

 const GalleryScreen({Key? key, required this.hotelData}) : super(key: key);

 @override
 Widget build(BuildContext context) {
  return Scaffold(
   appBar: _buildAppBar(context),
   body: Padding(
    padding: EdgeInsets.only(left: 24.h, top: 24.v, right: 24.h),
    child: GridView.builder(
     shrinkWrap: true,
     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      mainAxisExtent: 141.v,
      crossAxisCount: 2,
      mainAxisSpacing: 16.h,
      crossAxisSpacing: 16.h,
     ),
     physics: BouncingScrollPhysics(),
     itemCount: hotelData.hotelImages.length,
     itemBuilder: (context, index) {
      return GalleryItemWidget(
       hotelImages: hotelData.hotelImages,
       index: index,
       description: hotelData.imageDescriptions[hotelData.hotelImages[index]],
      );
     },
    ),
   ),
  );
 }

 PreferredSizeWidget _buildAppBar(BuildContext context) {
  return CustomAppBar(
   leadingWidth: 52.h,
   leading: AppbarLeadingImage(
    imagePath: ImageConstant.imgArrowLeft,
    margin: EdgeInsets.only(left: 24.h, top: 11.v, bottom: 16.v),
    onTap: () {
     onTapArrowLeft(context);
    },
   ),
   title: AppbarTitle(text: "Gallery Hotel Photos", margin: EdgeInsets.only(left: 16.h)),
  );
 }

 void onTapArrowLeft(BuildContext context) {
  Navigator.pop(context);
 }
}