import 'package:flutter/material.dart';
import 'package:hotel_app/core/app_export.dart';

// ignore: must_be_immutable
class SearchtypeItemWidget extends StatelessWidget {
  const SearchtypeItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 4.v,
              bottom: 2.v,
            ),
            child: Text(
              "Amsterdam, Netherlands",
              style: CustomTextStyles.titleMediumGray40001,
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgAutoLayoutHorizontal,
            height: 28.adaptSize,
            width: 28.adaptSize,
            margin: EdgeInsets.only(left: 152.h),
          ),
        ],
      ),
    );
  }
}
