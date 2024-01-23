import '../filter_result_page/widgets/filterresult_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:hotel_app/core/app_export.dart';

// ignore_for_file: must_be_immutable
class FilterResultPage extends StatefulWidget {
  const FilterResultPage({Key? key})
      : super(
          key: key,
        );

  @override
  FilterResultPageState createState() => FilterResultPageState();
}

class FilterResultPageState extends State<FilterResultPage>
    with AutomaticKeepAliveClientMixin<FilterResultPage> {
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
              _buildRecommendedSection(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildRecommendedSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 2.v,
                  bottom: 3.v,
                ),
                child: Text(
                  "Recommended (586,379)",
                  style: theme.textTheme.titleMedium,
                ),
              ),
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
          ),
          SizedBox(height: 22.v),
          ListView.separated(
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
              return FilterresultItemWidget();
            },
          ),
        ],
      ),
    );
  }
}
