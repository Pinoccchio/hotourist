import 'package:flutter/material.dart';
import 'package:hotel_app/core/app_export.dart';
import '../full_screen_image.dart';

class GalleryItemWidget extends StatelessWidget {
  final List<String> hotelImages;
  final int index;
  final String? description;

  const GalleryItemWidget({Key? key, required this.hotelImages, required this.index, this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FullScreenImageOverlay(
              imageUrls: hotelImages,
              initialIndex: index,
              imageDescriptions: description != null ? {hotelImages[index]: description!} : {},
            ),
          ),
        );
      },
      child: Image.asset(
        hotelImages[index],
        height: 140.v,
        width: 182.h,
        fit: BoxFit.cover,
      ),
    );
  }
}