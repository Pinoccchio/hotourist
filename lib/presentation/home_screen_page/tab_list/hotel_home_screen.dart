import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hotel_app/core/app_export.dart';
import '../hotel_class/hotel_list_model.dart';
import '../widgets/hotel_list_item_widget.dart';
import '../widgets/hotelslist_item_widget.dart';

class HotelHomeScreenPage extends StatefulWidget {
  const HotelHomeScreenPage({Key? key}) : super(key: key);


  @override
  HotelHomeScreenState createState() => HotelHomeScreenState();
}

class HotelHomeScreenState extends State<HotelHomeScreenPage>
    with AutomaticKeepAliveClientMixin<HotelHomeScreenPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    // Call the method to update hotel data from Firestore
    updateHotelDataFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    List<HotelListData> sortedHotelList = HotelListData.hotelList;
    sortedHotelList.sort((a, b) => b.rating.compareTo(a.rating)); // Sort by rating

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
                        _buildHotelsList(context, sortedHotelList),
                        SizedBox(height: 34.v),
                        _buildListOfHotels(context, HotelListData.hotelList),
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

  Widget _buildHotelsList(BuildContext context, List<HotelListData> hotelList) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 400.v,
        viewportFraction: 0.8, // Display one item at a time
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3), // Set the auto-scroll interval
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
      ),
      items: hotelList.map((hotelData) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.h),
          child: HotelslistItemWidget(hotelData: hotelData),
        );
      }).toList(),
    );
  }

  Widget _buildListOfHotels(BuildContext context, List<HotelListData> hotelList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 24.h),
          child: Text("Hotels", style: theme.textTheme.titleMedium),
        ),
        SizedBox(height: 16.v),
        Padding(
          padding: EdgeInsets.only(right: 24.h),
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: hotelList.length,
            itemBuilder: (context, index) {
              return HotelListItemWidget(
                hotelData: hotelList[index],
              );
            },
          ),
        ),
      ],
    );
  }

  onTapTxtSeeAll(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.recentlyBookedScreen);
  }

  void updateHotelDataFromFirestore() async {
    await HotelListData.updateHotelDataFromFirestore();
  }
}