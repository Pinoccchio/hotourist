import 'package:flutter/material.dart';
import 'package:hotel_app/core/app_export.dart';

// ignore: must_be_immutable
class TouristRectangleItemWidget extends StatelessWidget {
  final String touristImages;

  const TouristRectangleItemWidget({Key? key, required this.touristImages})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140.h,
      child: CustomImageView(
        imagePath: touristImages,
        height: 100.v,
        width: 140.h,
        radius: BorderRadius.circular(
          16.h,
        ),
      ),
    );
  }
}
