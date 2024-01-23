import '../search_type_page/widgets/searchtype_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:hotel_app/core/app_export.dart';

// ignore_for_file: must_be_immutable
class SearchTypePage extends StatefulWidget {
  const SearchTypePage({Key? key})
      : super(
          key: key,
        );

  @override
  SearchTypePageState createState() => SearchTypePageState();
}

class SearchTypePageState extends State<SearchTypePage>
    with AutomaticKeepAliveClientMixin<SearchTypePage> {
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
              SizedBox(height: 32.v),
              _buildRecentSearches(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildRecentSearches(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent",
            style: theme.textTheme.titleMedium,
          ),
          SizedBox(height: 21.v),
          ListView.separated(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (
              context,
              index,
            ) {
              return SizedBox(
                height: 10.v,
              );
            },
            itemCount: 6,
            itemBuilder: (context, index) {
              return SearchtypeItemWidget();
            },
          ),
        ],
      ),
    );
  }
}
