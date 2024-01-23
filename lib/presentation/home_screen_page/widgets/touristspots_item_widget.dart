import 'package:flutter/material.dart';
import 'package:hotel_app/core/app_export.dart';
import 'package:hotel_app/presentation/home_screen_page/hotel_class/touristSpot_list_model.dart';
import 'package:hotel_app/presentation/tourist_details_screen/tourist_details_screen.dart';
import 'package:hotel_app/widgets/custom_elevated_button.dart';

class TouristSpotsItemWidget extends StatelessWidget {
  final TouristListData touristData;

  const TouristSpotsItemWidget({Key? key, required this.touristData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateToTouristDetails(context, touristData);
      },
      child: SizedBox(
        height: 400.v,
        width: 300.h,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CustomImageView(
              imagePath: touristData.imagePath, // Use the image path from hotelData
              height: 400.v,
              width: 300.h,
              radius: BorderRadius.circular(
                36.h,
              ),
              alignment: Alignment.center,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomElevatedButton(
                    height: 32.v,
                    width: 71.h,
                    text: touristData.rating.toStringAsFixed(1), // Limit to 1 decimal place
                    margin: EdgeInsets.only(right: 23.h),
                    leftIcon: Container(
                      margin: EdgeInsets.only(right: 8.h),
                      child: CustomImageView(
                        imagePath: ImageConstant.imgStar,
                        height: 12.adaptSize,
                        width: 12.adaptSize,
                      ),
                    ),
                    buttonStyle: CustomButtonStyles.fillPrimaryTL16,
                    buttonTextStyle: CustomTextStyles.titleSmallWhiteA700,
                  ),
                  SizedBox(height: 172.v),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 32.h,
                      vertical: 21.v,
                    ),
                    decoration: AppDecoration.gradient.copyWith(
                      borderRadius: BorderRadiusStyle.customBorderBL36,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(height: 16.v),
                        Text(
                          touristData.titleTxt,
                          style: theme.textTheme.headlineSmall,
                        ),
                        SizedBox(height: 15.v),
                        Text(
                          touristData.subTxt,
                          style: theme.textTheme.bodyLarge,
                        ),
                        SizedBox(height: 10.v),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 2.v),
                              child: Text(
                                touristData.perNight.toString(),
                                style: theme.textTheme.headlineSmall,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 4.h,
                                top: 9.v,
                                bottom: 5.v,
                              ),
                              child: Text(
                                "/ per night",
                                style: CustomTextStyles.bodyMediumWhiteA700,
                              ),
                            ),
                            Spacer(),
                            CustomImageView(
                              imagePath: ImageConstant.imgBookmark,
                              height: 28.adaptSize,
                              width: 28.adaptSize,
                              margin: EdgeInsets.only(bottom: 3.v),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  void navigateToTouristDetails(BuildContext context, TouristListData touristData) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TouristDetailsScreen(
          touristData: touristData,
        ),
      ),
    );
  }
}