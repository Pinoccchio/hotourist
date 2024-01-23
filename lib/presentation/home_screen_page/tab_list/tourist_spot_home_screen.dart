import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hotel_app/core/app_export.dart';
import 'package:hotel_app/presentation/home_screen_page/widgets/touristspot_item_widget.dart';
import 'package:hotel_app/presentation/home_screen_page/widgets/touristspots_item_widget.dart';
import '../hotel_class/hotel_list_model.dart';
import '../hotel_class/touristSpot_list_model.dart';
import '../widgets/hotel_list_item_widget.dart';
import '../widgets/hotelslist_item_widget.dart';

class TouristSpotHomeScreenPage extends StatefulWidget {
  const TouristSpotHomeScreenPage({Key? key}) : super(key: key);

  @override
  _TouristSpotHomeScreenPageState createState() => _TouristSpotHomeScreenPageState();
}

class _TouristSpotHomeScreenPageState extends State<TouristSpotHomeScreenPage>
    with AutomaticKeepAliveClientMixin<TouristSpotHomeScreenPage> {
  @override
  bool get wantKeepAlive => true;

  MediaQueryData mediaQueryData = MediaQueryData();

  @override
  void initState() {
    super.initState();
    // Call the method to update tourist data from Firestore
    updateTouristDataFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    List<TouristListData> sortedTouristList = TouristListData.touristList;
    sortedTouristList.sort((a, b) => b.rating.compareTo(a.rating)); // Sort by rating

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
                        _buildHotelsList(context, sortedTouristList),
                        SizedBox(height: 34.v),
                        _buildListOfHotels(context, TouristListData.touristList),
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

  Widget _buildHotelsList(BuildContext context, List<TouristListData> touristList) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 400.v,
        viewportFraction: 0.8, // Display one item at a time
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3), // Set the auto-scroll interval
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
      ),
      items: touristList.map((touristData) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.h),
          child: TouristSpotsItemWidget(touristData: touristData),
        );
      }).toList(),
    );
  }

  Widget _buildListOfHotels(BuildContext context, List<TouristListData> touristList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 24.h),
          child: Text("Tourist Spots", style: theme.textTheme.titleMedium),
        ),
        SizedBox(height: 16.v),
        Padding(
          padding: EdgeInsets.only(right: 24.h),
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: touristList.length,
            itemBuilder: (context, index) {
              return TouristSpotItemWidget(
                touristData: touristList[index],
              );
            },
          ),
        ),
      ],
    );
  }

  void onTapTxtSeeAll(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.recentlyBookedScreen);
  }

  void updateTouristDataFromFirestore() async {
    await TouristListData.updateTouristDataFromFirestore();
    // This triggers a rebuild of the widget tree
    if (mounted) {
      setState(() {});
    }
  }
}
