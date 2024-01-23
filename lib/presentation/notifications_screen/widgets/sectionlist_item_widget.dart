// sectionlist_item_widget.dart
import 'package:flutter/material.dart';
import 'package:hotel_app/core/app_export.dart';

class SectionlistItemWidget extends StatelessWidget {
  final String title;
  final String body;

  const SectionlistItemWidget({
    Key? key,
    required this.title,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.v),
      decoration: AppDecoration.outlineBlackC.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgClockPrimary,
            height: 80.v,
            width: 83.h,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 18.v,
              bottom: 16.v,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium,
                ),
                SizedBox(height: 6.v),
                Text(
                  body, // Get the first 3 words
                  overflow: TextOverflow.ellipsis, // Add this line to handle overflow
                  style: CustomTextStyles.titleSmallGray40001,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}