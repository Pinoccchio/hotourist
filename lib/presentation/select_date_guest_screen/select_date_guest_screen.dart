import 'package:flutter/material.dart';
import 'package:hotel_app/core/app_export.dart';
import 'package:hotel_app/presentation/home_screen_page/hotel_class/hotel_list_model.dart';
import 'package:hotel_app/widgets/app_bar/appbar_leading_image.dart';
import 'package:hotel_app/widgets/app_bar/appbar_title.dart';
import 'package:hotel_app/widgets/app_bar/custom_app_bar.dart';
import 'package:hotel_app/widgets/custom_elevated_button.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../booking_name_page/booking_name_page.dart';

class SelectDateGuestScreen extends StatefulWidget {
  final int hotelPrice;
  final HotelListData hotelData;
  const SelectDateGuestScreen({Key? key, required this.hotelPrice, required this.hotelData}) : super(key: key);

  @override
  _SelectDateGuestScreenState createState() => _SelectDateGuestScreenState();
}

class _SelectDateGuestScreenState extends State<SelectDateGuestScreen> {
  DateTime checkInDate = DateTime.now();
  DateTime checkOutDate = DateTime.now().add(Duration(days: 4));
  late CalendarFormat _calendarFormat;
  int selectedQuantity = 1; // Default value
  int total = 0;

  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.month;
  }

  @override
  Widget build(BuildContext context) {
    int total = selectedQuantity * widget.hotelPrice; // Calculate total

    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(
              horizontal: 24.h,
              vertical: 20.v,
            ),
            child: Column(
              children: [
                SizedBox(height: 11.v),
                Container(
                  height: 396.v,
                  width: 380.h,
                  decoration: BoxDecoration(
                    color: appTheme.blueGray900,
                    borderRadius: BorderRadius.circular(16.h),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: _buildCalendar(context),
                      ),
                      SizedBox(height: 19), // Adjust the height as needed
                    ],
                  ),
                ), // Added comma here
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(right: 78.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Check in",
                          style: CustomTextStyles.titleMedium18,
                        ),
                        Text(
                          "Check out",
                          style: CustomTextStyles.titleMedium18,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12.v),
                _buildDecCounter(context),
                SizedBox(height: 29.v),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Guest",
                    style: CustomTextStyles.titleMedium18,
                  ),
                ),
                SizedBox(height: 16.v),
                _buildAutoLayoutHorizontal(context),
                SizedBox(height: 21.v),
                Text(
                  "Total: $total", // Display total dynamically
                  style: theme.textTheme.titleLarge,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: _buildContinue(context),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 48.v,
      leadingWidth: 52.h,
      leading: AppbarLeadingImage(
        imagePath: 'lib/images/img_arrow_down.svg',
        margin: EdgeInsets.only(
          left: 24.h,
          top: 10.v,
          bottom: 10.v,
        ),
        onTap: () {
          onTapArrowLeft(context);
        },
      ),
      title: AppbarTitle(
        text: "Select Date",
        margin: EdgeInsets.only(left: 16.h),
      ),
    );
  }

  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }

  Widget _buildDecCounter(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatusFillTypeNormal(
          context,
          dynamicText: _formatDate(checkInDate),
          onTap: () => _selectDate(context, true),
        ),
        CustomImageView(
          imagePath: 'lib/images/img_user_onprimarycontainer.svg',
          height: 20.adaptSize,
          width: 20.adaptSize,
          margin: EdgeInsets.symmetric(vertical: 18.v),
        ),
        _buildStatusFillTypeNormal(
          context,
          dynamicText: _formatDate(checkOutDate),
          onTap: () => _selectDate(context, false),
        ),
      ],
    );
  }

  Widget _buildAutoLayoutHorizontal(BuildContext context) {
    total = selectedQuantity * widget.hotelPrice; // Calculate total

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 82.h,
        vertical: 11.v,
      ),
      decoration: AppDecoration.outlineGray800.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                // Decrement the quantity
                if (selectedQuantity > 1) {
                  selectedQuantity--;
                }
              });
            },
            child: Material(
              color: Colors.transparent,
              child: Container(
                height: 52.adaptSize,
                width: 52.adaptSize,
                padding: EdgeInsets.all(16.h),
                decoration: AppDecoration.outlineIndigoA.copyWith(
                  borderRadius: BorderRadiusStyle.roundedBorder16,
                ),
                child: CustomImageView(
                  imagePath: 'lib/images/img_frame_white_a700.svg',
                  height: 20.adaptSize,
                  width: 20.adaptSize,
                  alignment: Alignment.center,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 11.v),
            child: Text(
              "$selectedQuantity",
              style: theme.textTheme.headlineSmall,
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                // Increment the quantity
                selectedQuantity++;
              });
            },
            child: Material(
              color: Colors.transparent,
              child: Container(
                height: 52.adaptSize,
                width: 52.adaptSize,
                padding: EdgeInsets.all(16.h),
                decoration: AppDecoration.outlineIndigoA.copyWith(
                  borderRadius: BorderRadiusStyle.roundedBorder16,
                ),
                child: CustomImageView(
                  imagePath: 'lib/images/img_frame_white_a700_20x20.svg',
                  height: 20.adaptSize,
                  width: 20.adaptSize,
                  alignment: Alignment.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinue(BuildContext context) {
    return CustomElevatedButton(
      text: "Continue",
      margin: EdgeInsets.only(
        left: 24.h,
        right: 24.h,
        bottom: 32.v,
      ),
      onPressed: () {
        print(checkInDate);
        print(checkOutDate);
        print(total);
        print(selectedQuantity);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookingNamePage(
              hotelData: widget.hotelData,
              checkInDate: checkInDate,
              checkOutDate: checkOutDate,
              totalPrice: total,
              guessCount: selectedQuantity,
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatusFillTypeNormal(BuildContext context, {required String dynamicText, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160.h,
        padding: EdgeInsets.symmetric(
          horizontal: 20.h,
          vertical: 18.v,
        ),
        decoration: AppDecoration.fillBlueGray.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder12,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.v),
              child: Text(
                dynamicText,
                style: theme.textTheme.titleSmall!.copyWith(
                  color: appTheme.whiteA700,
                ),
              ),
            ),
            CustomImageView(
              imagePath: 'lib/images/img_iconly_curved_calendar_cyan_600.svg',
              height: 20.adaptSize,
              width: 20.adaptSize,
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('MMM d').format(date);
  }

  Future<void> _selectDate(BuildContext context, bool isCheckIn) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: isCheckIn ? checkInDate : checkOutDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != (isCheckIn ? checkInDate : checkOutDate)) {
      setState(() {
        if (isCheckIn) {
          checkInDate = pickedDate;
        } else {
          checkOutDate = pickedDate;
        }
      });
    }
  }
  Widget _buildCalendar(BuildContext context) {
    DateTime now = DateTime.now();

    return Container(
      height: 100,
      child: ListView(
        physics: NeverScrollableScrollPhysics(), // Make it non-scrollable
        shrinkWrap: true,
        children: [
          TableCalendar(
            firstDay: checkInDate ?? DateTime.utc(now.year - 1, now.month, now.day),
            lastDay: checkOutDate ?? DateTime.utc(now.year + 1, now.month, now.day),
            focusedDay: now,
            calendarFormat: _calendarFormat,
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
            ),
            startingDayOfWeek: StartingDayOfWeek.sunday,
            onDaySelected: (date, focusedDay) {
              setState(() {
                if (_calendarFormat == CalendarFormat.week) {
                  checkInDate = date;
                  _calendarFormat = CalendarFormat.month;
                } else {
                  if (date.isBefore(checkInDate)) {
                    checkOutDate = checkInDate.add(Duration(days: 1));
                    checkInDate = date;
                  } else {
                    checkOutDate = date.add(Duration(days: 1));
                  }
                  _calendarFormat = CalendarFormat.week;
                }
              });
            },
            selectedDayPredicate: (day) {
              // Highlight check-in and check-out dates
              return (checkInDate != null && checkOutDate != null) &&
                  day.isAfter(checkInDate!.subtract(Duration(days: 1))) &&
                  day.isBefore(checkOutDate!.add(Duration(days: 1)));
            },
            holidayPredicate: (day) {
              // Customize the condition for today's date styling
              return isSameDay(day, DateTime.now());
            },
          ),
        ],
      ),
    );
  }
}
