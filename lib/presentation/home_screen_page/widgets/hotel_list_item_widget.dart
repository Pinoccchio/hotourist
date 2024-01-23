import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotel_app/core/app_export.dart';
import '../../hotel_details_screen/hotel_details_screen.dart';
import '../hotel_class/hotel_list_model.dart';

class HotelListItemWidget extends StatelessWidget {
  final HotelListData hotelData;
  const HotelListItemWidget({
    Key? key,
    required this.hotelData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('HotelApp')
          .doc('HotelRatings')
          .collection('RatingsData')
          .doc(hotelData.titleTxt)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }

        var data = snapshot.data!.data();
        double avgRating =
            (data as Map<String, dynamic>?)?['averageRating'] as double? ?? 0;
        int totalReviews = (data)?['totalReviews'] as int? ?? 0;

        return GestureDetector(
          onTap: () {
            // Navigate to hotel details screen with necessary info
            navigateToHotelDetails(context, hotelData);
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 12.v),
            padding: EdgeInsets.symmetric(vertical: 18.v),
            decoration: AppDecoration.outlineBlackC.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder16,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomImageView(
                  imagePath: getValidImagePath(hotelData.imagePath),
                  height: 100.adaptSize,
                  width: 100.adaptSize,
                  radius: BorderRadius.circular(16.h),
                  margin: EdgeInsets.only(left: 20, right: 5.h),
                ),
                SizedBox(width: 16.h),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hotelData.titleTxt,
                        style: theme.textTheme.titleLarge,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8.v),
                      Text(
                        hotelData.subTxt,
                        style: theme.textTheme.bodyMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8.v),
                      Row(
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.imgStarYellowA700,
                            height: 12.adaptSize,
                            width: 12.adaptSize,
                            margin: EdgeInsets.symmetric(vertical: 2.v),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 4.h),
                            child: Text(
                              avgRating.toStringAsFixed(1),
                              style: theme.textTheme.titleSmall,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 8.h,
                              top: 1.v,
                            ),
                            child: Text(
                              "($totalReviews reviews)",
                              style: theme.textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${hotelData.perNight}",
                      style: CustomTextStyles.headlineSmallPrimary,
                    ),
                    SizedBox(height: 2.v),
                    Text(
                      "/ night",
                      style: theme.textTheme.labelMedium,
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      softWrap: true,
                    ),
                    SizedBox(height: 16.v),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String getValidImagePath(String imagePath) {
    return imagePath.isNotEmpty
        ? imagePath
        : 'lib/presentation/home_screen_page/hotel_images/hotel_default_img.jpg';
  }

  void navigateToHotelDetails(BuildContext context, HotelListData hotelData) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HotelDetailsScreen(
          hotelData: hotelData,
        ),
      ),
    );
  }
}