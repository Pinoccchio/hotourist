import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotel_app/core/app_export.dart';
import 'package:hotel_app/widgets/custom_elevated_button.dart';

import '../../home_screen_page/hotel_class/hotel_list_model.dart';

class FramenineteenItemWidget extends StatefulWidget {
  final HotelListData hotelData;
  final Map<String, dynamic> comment;

  const FramenineteenItemWidget({Key? key, required this.hotelData, required this.comment})
      : super(key: key);

  @override
  FramenineteenItemWidgetState createState() => FramenineteenItemWidgetState();
}

class FramenineteenItemWidgetState extends State<FramenineteenItemWidget> {
  User? currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24.h,
        vertical: 22.v,
      ),
      decoration: AppDecoration.outlineBlackC.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder16,
      ),
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('HotelApp')
            .doc('User_Comments_Ratings')
            .collection(widget.hotelData.titleTxt)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          var comments = snapshot.data?.docs ?? [];

          // Check if there are no comments
          if (comments.isEmpty) {
            return Center(
              child: Text(
                'No comments yet. Be the first one to comment!',
                style: TextStyle(color: Colors.grey),
              ),
            );
          }

          return Column(

          );
        },
      ),
    );
  }
}

class CommentItemWidget extends StatelessWidget {
  final Map<String, dynamic> comment;

  const CommentItemWidget({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.h),
      decoration: AppDecoration.outlineBlackC.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomImageView(
                imagePath: comment['userProfile'] ?? ImageConstant.imgEllipse1,
                height: 48.adaptSize,
                width: 48.adaptSize,
                radius: BorderRadius.circular(
                  24.h,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 16.h,
                  top: 7.v,
                  bottom: 4.v,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comment['userEmail'] ?? '',
                      style: CustomTextStyles.titleMedium16,
                    ),
                    SizedBox(height: 2.v),
                    Text(
                      comment['timestamp']?.toDate().toString() ?? '',
                      style: CustomTextStyles.labelLargeGray400,
                    ),
                  ],
                ),
              ),
              Spacer(),
              CustomElevatedButton(
                height: 32.v,
                width: 60.h,
                text: (comment['userRate'] as double?)?.toInt().toString() ?? '0',
                margin: EdgeInsets.symmetric(vertical: 8.v),
                leftIcon: Container(
                  margin: EdgeInsets.only(right: 8.h),
                  child: CustomImageView(
                    imagePath: 'lib/images/img_signal_white_a700.svg',
                    height: 12.adaptSize,
                    width: 12.adaptSize,
                  ),
                ),
                buttonStyle: CustomButtonStyles.fillPrimaryTL16,
                buttonTextStyle: theme.textTheme.titleSmall!.copyWith(color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 12.v),
          Container(
            width: 293.h,
            margin: EdgeInsets.only(right: 39.h),
            child: Text(
              comment['userComment'] ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: CustomTextStyles.bodyMediumWhiteA700.copyWith(
                height: 1.40,
              ),
            ),
          ),
        ],
      ),
    );
  }
}