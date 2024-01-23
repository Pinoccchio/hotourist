import 'package:flutter/material.dart';
import 'package:hotel_app/core/app_export.dart';
import '../widgets/martinezcannes_item_widget.dart';
import '../widgets/trending_item_widget.dart';

class TrendingHomeScreenPage extends StatefulWidget {
 const TrendingHomeScreenPage({Key? key}) : super(key: key);

 @override
 TrendingHomeScreenPageState createState() => TrendingHomeScreenPageState();
}

class TrendingHomeScreenPageState extends State<TrendingHomeScreenPage>
    with AutomaticKeepAliveClientMixin<TrendingHomeScreenPage> {
 @override
 bool get wantKeepAlive => true;

 @override
 Widget build(BuildContext context) {
  mediaQueryData = MediaQuery.of(context);
  return SafeArea(
   child: Scaffold(
    body: SizedBox(
     width: mediaQueryData.size.width,
     child: SingleChildScrollView(
      child: Column(
       children: [
        SizedBox(height: 30.v),
        Align(
         alignment: Alignment.centerRight,
         child: Padding(
          padding: EdgeInsets.only(left: 24.h),
          child: Column(
           children: [
            _buildHotelsList(context),
            SizedBox(height: 34.v),
            _buildRecentlyBookedList(context),
           ],
          ),
         ),
        ),
       ],
      ),
     ),
    ),
   ),
  );
 }

 /// Section Widget
 Widget _buildHotelsList(BuildContext context) {
  return SizedBox(
   height: 400.v,
   child: ListView.separated(
    scrollDirection: Axis.horizontal,
    separatorBuilder: (context, index) {
     return SizedBox(width: 24.h);
    },
    itemCount: 2,
    itemBuilder: (context, index) {
     return TrendingListItemWidget();
    },
   ),
  );
 }

 /// Section Widget
 Widget _buildRecentlyBookedList(BuildContext context) {
  return Column(
   crossAxisAlignment: CrossAxisAlignment.start,
   children: [
    Padding(
     padding: EdgeInsets.only(right: 24.h),
     child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
       Text("Recently Booked", style: theme.textTheme.titleMedium),
       GestureDetector(
        onTap: () {
         onTapTxtSeeAll(context);
        },
        child: Text("See All", style: CustomTextStyles.titleMediumPrimary16),
       ),
      ],
     ),
    ),
    SizedBox(height: 16.v),
    Padding(
     padding: EdgeInsets.only(right: 24.h),
     child: ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (context, index) {
       return SizedBox(height: 24.v);
      },
      itemCount: 5,
      itemBuilder: (context, index) {
       return MartinezcannesItemWidget();
      },
     ),
    ),
   ],
  );
 }

 /// Navigates to the recentlyBookedScreen when the action is triggered.
 onTapTxtSeeAll(BuildContext context) {
  Navigator.pushNamed(context, AppRoutes.recentlyBookedScreen);
 }
}