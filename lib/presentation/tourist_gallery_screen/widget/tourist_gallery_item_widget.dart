import 'package:flutter/material.dart';
import 'package:hotel_app/core/app_export.dart';
import '../full_screen_image.dart';

class TouristGalleryItemWidget extends StatelessWidget {
  final List<String> touristImages;
  final int index;
  final String? description;

  const TouristGalleryItemWidget({Key? key, required this.touristImages, required this.index, this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FullScreenImageOverlay(
              imageUrls: touristImages,
              initialIndex: index,
              imageDescriptions: description != null ? {touristImages[index]: description!} : {},
            ),
          ),
        );
      },
      child: Image.asset(
        touristImages[index],
        height: 140.v,
        width: 182.h,
        fit: BoxFit.cover,
      ),
    );
  }
}