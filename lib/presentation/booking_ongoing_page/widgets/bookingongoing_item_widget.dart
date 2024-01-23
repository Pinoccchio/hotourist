import 'package:flutter/material.dart';
import 'package:hotel_app/core/app_export.dart';
import 'package:hotel_app/widgets/custom_elevated_button.dart';
import 'package:hotel_app/widgets/custom_outlined_button.dart';

class BookingongoingItemWidget extends StatelessWidget {
  final String title;
  final String image; // New property
  final String location; // New property
  final VoidCallback? onTapBookingActionCancelBooking;
  final VoidCallback? onTapBookingActionViewTicket;

  BookingongoingItemWidget({
    Key? key,
    required this.title,
    required this.image,
    required this.location,
    this.onTapBookingActionCancelBooking,
    this.onTapBookingActionViewTicket,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.h),
      decoration: AppDecoration.outlineBlackC.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomImageView(
                  imagePath: image, // Use the provided hotelImage
                  height: 100.adaptSize,
                  width: 100.adaptSize,
                  radius: BorderRadius.circular(16.h),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.v, bottom: 6.v),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: CustomTextStyles.titleLargeSemiBold,
                      ),
                      SizedBox(height: 9.v),
                      Text(
                        location, // Use the provided hotelLocation
                        style: theme.textTheme.bodyMedium,
                      ),
                      SizedBox(height: 11.v),
                      CustomElevatedButton(
                        height: 24.v,
                        width: 60.h,
                        text: "Paid",
                        buttonStyle: CustomButtonStyles.fillTeal,
                        buttonTextStyle: CustomTextStyles.labelMediumCyan300,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.v),
          Divider(),
          SizedBox(height: 19.v),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: CustomOutlinedButton(
                  text: "Cancel Booking",
                  margin: EdgeInsets.only(right: 6.h),
                  onPressed: () {
                    onTapBookingActionCancelBooking?.call();
                  },
                ),
              ),
              Expanded(
                child: CustomElevatedButton(
                  height: 38.v,
                  text: "View Ticket",
                  margin: EdgeInsets.only(left: 6.h),
                  buttonStyle: CustomButtonStyles.fillPrimaryTL19,
                  buttonTextStyle: CustomTextStyles.titleMediumSemiBold,
                  onPressed: () {
                    onTapBookingActionViewTicket?.call();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
