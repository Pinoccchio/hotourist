import 'package:flutter/material.dart';
import 'package:hotel_app/core/app_export.dart';

// ignore: must_be_immutable
class RectangleItemWidget extends StatelessWidget {
  final String hotelImages;

  const RectangleItemWidget({Key? key, required this.hotelImages})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140.h,
      child: CustomImageView(
        imagePath: hotelImages,
        height: 100.v,
        width: 140.h,
        radius: BorderRadius.circular(
          16.h,
        ),
      ),
    );
  }
}
