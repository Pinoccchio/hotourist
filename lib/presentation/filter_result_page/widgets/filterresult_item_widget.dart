import 'package:flutter/material.dart';
import 'package:hotel_app/core/app_export.dart';

// ignore: must_be_immutable
class FilterresultItemWidget extends StatelessWidget {
  const FilterresultItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20.h,
        vertical: 18.v,
      ),
      decoration: AppDecoration.outlineBlackC.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgRectangle4100x100,
            height: 100.adaptSize,
            width: 100.adaptSize,
            radius: BorderRadius.circular(
              16.h,
            ),
            margin: EdgeInsets.only(bottom: 1.v),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 16.h,
              bottom: 11.v,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "President Hotel",
                  style: theme.textTheme.titleLarge,
                ),
                SizedBox(height: 18.v),
                Text(
                  "Paris, France",
                  style: theme.textTheme.bodyMedium,
                ),
                SizedBox(height: 12.v),
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
                        "4.8",
                        style: theme.textTheme.titleSmall,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 8.h,
                        top: 1.v,
                      ),
                      child: Text(
                        "(4,378 reviews)",
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(
              top: 10.v,
              bottom: 8.v,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "35",
                  style: CustomTextStyles.headlineSmallPrimary,
                ),
                SizedBox(height: 2.v),
                Text(
                  "/ night",
                  style: theme.textTheme.labelMedium,
                ),
                SizedBox(height: 16.v),
                CustomImageView(
                  imagePath: ImageConstant.imgBookmarkPrimary,
                  height: 24.adaptSize,
                  width: 24.adaptSize,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
