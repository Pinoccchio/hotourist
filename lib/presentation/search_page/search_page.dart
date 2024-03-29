import '../search_page/widgets/searchpagelist_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:hotel_app/core/app_export.dart';

// ignore_for_file: must_be_immutable
class SearchPage extends StatefulWidget {
  const SearchPage({Key? key})
      : super(
          key: key,
        );

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage>
    with AutomaticKeepAliveClientMixin<SearchPage> {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          decoration: AppDecoration.fillOnPrimary,
          child: Column(
            children: [
              SizedBox(height: 24.v),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.h),
                child: Column(
                  children: [
                    _buildSeventyTwoRow(context),
                    SizedBox(height: 22.v),
                    _buildSearchPageList(context),
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
  Widget _buildRecommendedText(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 2.v,
        bottom: 3.v,
      ),
      child: Text(
        "Recommended (586,379)",
        style: theme.textTheme.titleMedium,
      ),
    );
  }

  /// Section Widget
  Widget _buildSeventyTwoRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildRecommendedText(context),
        Spacer(),
        CustomImageView(
          imagePath: ImageConstant.imgMenuPrimary,
          height: 28.adaptSize,
          width: 28.adaptSize,
        ),
        CustomImageView(
          imagePath: ImageConstant.imgVideoCamera,
          height: 28.adaptSize,
          width: 28.adaptSize,
          margin: EdgeInsets.only(left: 12.h),
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildSearchPageList(BuildContext context) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (
        context,
        index,
      ) {
        return SizedBox(
          height: 24.v,
        );
      },
      itemCount: 5,
      itemBuilder: (context, index) {
        return SearchpagelistItemWidget();
      },
    );
  }
}
