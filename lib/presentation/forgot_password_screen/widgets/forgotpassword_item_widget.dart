import 'package:flutter/material.dart';
import 'package:hotel_app/core/app_export.dart';

// ignore: must_be_immutable
class ForgotpasswordItemWidget extends StatelessWidget {
  const ForgotpasswordItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(21.h),
      decoration: AppDecoration.outlinePrimary.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder20,
      ),
      child: Row(
        children: [
          Container(
            height: 80.adaptSize,
            width: 80.adaptSize,
            padding: EdgeInsets.all(26.h),
            decoration: AppDecoration.fillGray.copyWith(
              borderRadius: BorderRadiusStyle.circleBorder40,
            ),
            child: CustomImageView(
              imagePath: ImageConstant.imgVolume,
              height: 26.adaptSize,
              width: 26.adaptSize,
              alignment: Alignment.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 20.h,
              top: 15.v,
              bottom: 15.v,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "via SMS:",
                  style: CustomTextStyles.titleSmallGray400,
                ),
                SizedBox(height: 11.v),
                Text(
                  "+1 111 ******99",
                  style: CustomTextStyles.titleMedium16,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
