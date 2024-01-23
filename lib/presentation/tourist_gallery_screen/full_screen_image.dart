import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../core/utils/image_constant.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';

class FullScreenImageOverlay extends StatefulWidget {
  final List<String> imageUrls;
  final int initialIndex;
  final Map<String, String> imageDescriptions;

  FullScreenImageOverlay({
    required this.imageUrls,
    required this.initialIndex,
    required this.imageDescriptions,
  });

  @override
  _FullScreenImageOverlayState createState() => _FullScreenImageOverlayState();
}

class _FullScreenImageOverlayState extends State<FullScreenImageOverlay> {
  late PageController pageController;
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Stack(
        children: [
          PageView.builder(
            itemCount: widget.imageUrls.length,
            controller: pageController,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return FullScreenImagePage(
                imageUrl: widget.imageUrls[index],
                description: widget.imageDescriptions[widget.imageUrls[index]] ?? '',
                onPageChanged: (pageIndex) {
                  // Update the current index when the PhotoViewGallery page changes
                  setState(() {
                    currentIndex = pageIndex;
                  });
                },
              );
            },
          ),
          // Display description
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Text(
                    widget.imageDescriptions[widget.imageUrls[currentIndex]] ?? '',
                    style: const TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 10),  // Add some space for clarity
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    // Customize this method based on your custom AppBar structure
    return CustomAppBar(
      leadingWidth: 52,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(left: 24, top: 11, bottom: 16),
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
      title: AppbarTitle(text: "Full Screen", margin: EdgeInsets.only(left: 16)),
    );
  }
}

class FullScreenImagePage extends StatelessWidget {
  final String imageUrl;
  final String description;
  final ValueChanged<int> onPageChanged;

  FullScreenImagePage({
    required this.imageUrl,
    required this.description,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PhotoViewGallery.builder(
      itemCount: 1,
      pageController: PageController(),
      onPageChanged: (index) {
        // Notify the parent about the page change
        onPageChanged(index);
      },
      builder: (context, index) {
        return PhotoViewGalleryPageOptions(
          imageProvider: AssetImage(imageUrl),
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 2,
        );
      },
    );
  }
}