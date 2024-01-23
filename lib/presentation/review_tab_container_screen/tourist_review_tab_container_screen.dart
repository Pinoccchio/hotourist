import 'package:flutter/material.dart';
import 'package:hotel_app/core/app_export.dart';
import 'package:hotel_app/presentation/home_screen_page/hotel_class/touristSpot_list_model.dart';
import 'package:hotel_app/presentation/rate_hotel_bottomsheet/rate_hotel_bottomsheet.dart';
import 'package:hotel_app/presentation/rate_hotel_bottomsheet/rate_tourist_bottomsheet.dart';
import 'package:hotel_app/review_page/tourist_review_page.dart';
import 'package:hotel_app/widgets/app_bar/appbar_leading_image.dart';
import 'package:hotel_app/widgets/app_bar/appbar_title.dart';
import 'package:hotel_app/widgets/app_bar/custom_app_bar.dart';
import '../../core/utils/image_constant.dart';
import '../../review_page/review_page.dart';
import '../../theme/app_decoration.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/custom_image_view.dart';

class TouristReviewTabContainerScreen extends StatefulWidget {
  final TouristListData touristData;
  const TouristReviewTabContainerScreen({Key? key, required this.touristData})
      : super(
    key: key,
  );

  @override
  ReviewTabContainerScreenState createState() =>
      ReviewTabContainerScreenState();
}

class ReviewTabContainerScreenState extends State<TouristReviewTabContainerScreen>
    with TickerProviderStateMixin {
  late TabController tabviewController;

  @override
  void initState() {
    super.initState();
    tabviewController = TabController(length: 6, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              SizedBox(height: 30.v),
              _buildTabview(context),
              Expanded(
                child: SizedBox(
                  height: 763.v,
                  child: TabBarView(
                    controller: tabviewController,
                    children: [
                      TouristReviewPage(touristData: widget.touristData),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: _buildFloatingActionButton(context),
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        _showModalBottomSheet(context);
      },
      backgroundColor: Color(0xFF1AADB6), // Background color
      child: Icon(
        Icons.add,
        color: Colors.white, // Font color
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 50.v,
      leadingWidth: 52.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeftWhiteA700,
        margin: EdgeInsets.only(left: 24.h, top: 11.v, bottom: 11.v),
        onTap: () {
          onTapArrowLeft(context);
        },
      ),
      title: AppbarTitle(
        text: "Review",
        margin: EdgeInsets.only(left: 16.h),
      ),
    );
  }
  // Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }


  // Call this function to show the bottom sheet
  _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Set this property to true
      builder: (BuildContext context) => RateTouristBottomsheet(touristData: widget.touristData),
    );
  }

  /// Section Widget
  Widget _buildTabview(BuildContext context) {
    return Container(
      height: 38.v,
      width: 404.h,
      child: TabBar(
        controller: tabviewController,
        isScrollable: true,
        labelColor: appTheme.whiteA700,
        labelStyle: TextStyle(
          fontSize: 16.fSize,
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelColor: appTheme.cyan600,
        unselectedLabelStyle: TextStyle(
          fontSize: 16.fSize,
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w600,
        ),
        indicator: BoxDecoration(
          color: appTheme.cyan600,
          borderRadius: BorderRadius.circular(
            19.h,
          ),
        ),
        tabs: [
          Tab(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20.h,
                vertical: 9.v,
              ),
              decoration: AppDecoration.fillCyan.copyWith(
                borderRadius: BorderRadiusStyle.circleBorder19,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomImageView(
                    imagePath: 'lib/images/img_signal_white_a700.svg',
                    height: 16.adaptSize,
                    width: 16.adaptSize,
                    margin: EdgeInsets.symmetric(vertical: 2.v),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.h),
                    child: Text(
                      "All",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildSizeMediumTypeBorder1(
      BuildContext context, {
        required String chipsText,
      }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 18.h,
        vertical: 6.v,
      ),
      decoration: AppDecoration.outlineCyan.copyWith(
        borderRadius: BorderRadiusStyle.circleBorder19,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgSignalCyan600,
            height: 16.adaptSize,
            width: 16.adaptSize,
            margin: EdgeInsets.symmetric(vertical: 2.v),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.h),
            child: Text(
              chipsText,
              style: theme.textTheme.titleMedium!.copyWith(
                color: appTheme.cyan600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildSizeMediumTypeBorder2(
      BuildContext context, {
        required String chipsText,
      }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 18.h,
        vertical: 6.v,
      ),
      decoration: AppDecoration.outlineCyan.copyWith(
        borderRadius: BorderRadiusStyle.circleBorder19,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgSignalCyan600,
            height: 16.adaptSize,
            width: 16.adaptSize,
            margin: EdgeInsets.symmetric(vertical: 2.v),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.h),
            child: Text(
              chipsText,
              style: theme.textTheme.titleMedium!.copyWith(
                color: appTheme.cyan600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}