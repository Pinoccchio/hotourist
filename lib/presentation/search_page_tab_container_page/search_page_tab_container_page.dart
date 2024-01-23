import 'package:flutter/material.dart';
import 'package:hotel_app/core/app_export.dart';
import 'package:hotel_app/presentation/search_type_page/search_type_page.dart';
import 'package:hotel_app/widgets/custom_search_view.dart';

// ignore_for_file: must_be_immutable
class SearchPageTabContainerPage extends StatefulWidget {
  const SearchPageTabContainerPage({Key? key})
      : super(
          key: key,
        );

  @override
  SearchPageTabContainerPageState createState() =>
      SearchPageTabContainerPageState();
}

class SearchPageTabContainerPageState extends State<SearchPageTabContainerPage>
    with TickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();

  late TabController tabviewController;

  @override
  void initState() {
    super.initState();
    tabviewController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.maxFinite,
          decoration: AppDecoration.fillOnPrimary,
          child: Column(
            children: [
              SizedBox(height: 24.v),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.h),
                child: CustomSearchView(
                  controller: searchController,
                  hintText: "Search",
                ),
              ),
              SizedBox(height: 24.v),
              _buildSearchRecommendations(context),
              SizedBox(
                height: 650.v,
                child: TabBarView(
                  controller: tabviewController,
                  children: [
                    SearchTypePage(),
                    SearchTypePage(),
                    SearchTypePage(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildSearchRecommendations(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.only(left: 24.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 38.v,
              width: 372.h,
              child: TabBar(
                controller: tabviewController,
                labelPadding: EdgeInsets.zero,
                labelColor: appTheme.whiteA700,
                labelStyle: TextStyle(
                  fontSize: 16.fSize,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelColor: theme.colorScheme.primary,
                unselectedLabelStyle: TextStyle(
                  fontSize: 16.fSize,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w600,
                ),
                indicator: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(
                    19.h,
                  ),
                ),
                tabs: [
                  Tab(
                    child: Text(
                      "All Hotel",
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Recommended",
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Popular",
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 105.h,
              margin: EdgeInsets.only(left: 12.h),
              padding: EdgeInsets.symmetric(
                horizontal: 20.h,
                vertical: 8.v,
              ),
              decoration: AppDecoration.outlinePrimary1.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder20,
              ),
              child: Text(
                "Trending",
                style: CustomTextStyles.titleMediumPrimary,
              ),
            ),
            Container(
              width: 94.h,
              margin: EdgeInsets.only(left: 12.h),
              padding: EdgeInsets.symmetric(
                horizontal: 20.h,
                vertical: 8.v,
              ),
              decoration: AppDecoration.outlinePrimary1.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder20,
              ),
              child: Text(
                "Nearby",
                style: CustomTextStyles.titleMediumPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
