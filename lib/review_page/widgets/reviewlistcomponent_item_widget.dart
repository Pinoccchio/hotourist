import 'package:flutter/material.dart';
import 'package:hotel_app/core/app_export.dart';
import 'package:hotel_app/widgets/custom_elevated_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../../presentation/home_screen_page/hotel_class/hotel_list_model.dart';

class ReviewListComponentItemWidget extends StatelessWidget {
  final HotelListData hotelData;
  final String userEmail;
  final double userRate;
  final Map<String, dynamic> comment;
  final Function onCommentDeleted;

  const ReviewListComponentItemWidget({
    Key? key,
    required this.userEmail,
    required this.comment,
    required this.userRate,
    required this.onCommentDeleted,
    required this.hotelData,
  }) : super(key: key);

  String getFormattedCommentDate() {
    var commentDate = comment['timestamp'] != null
        ? (comment['timestamp'] as Timestamp).toDate()
        : DateTime.now();
    return DateFormat('dd, MMM y - h:mm:ss a').format(commentDate);
  }

  void _deleteComment(BuildContext context) async {
    bool? confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFF24272F),
          title: Text(
            'Are you sure you want to delete this comment?',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFF24272F)),
              ),
              child: Text(
                'No',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFF1AADB6)),
              ),
              child: Text(
                'Yes',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );

    if (confirmDelete != null && confirmDelete) {
      await FirebaseFirestore.instance
          .collection('HotelApp')
          .doc('User_Comments_Ratings')
          .collection(hotelData.titleTxt)
          .doc(comment['commentId'])
          .delete()
          .then((value) {
        print('Comment deleted successfully');
        onCommentDeleted(); // Notify the parent widget about the deletion
      }).catchError((error) {
        print('Failed to delete comment: $error');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var userProfile = comment['userProfile'] != null
        ? comment['userProfile']
        : 'https://static.vecteezy.com/system/resources/previews/020/765/399/non_2x/default-profile-account-unknown-icon-black-silhouette-free-vector.jpg';

    bool isUserComment = userEmail == comment['userEmail'];

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
              CircleAvatar(
                backgroundColor: theme.colorScheme.onPrimaryContainer,
                backgroundImage: NetworkImage(userProfile),
                radius: 24.h,
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
                      comment['userEmail'] ?? "Unknown User",
                      style: theme.textTheme.titleMedium,
                    ),
                    SizedBox(height: 2.v),
                    Text(
                      getFormattedCommentDate(),
                      style: CustomTextStyles.labelLargeGray400,
                    ),
                  ],
                ),
              ),
              Spacer(),
              CustomElevatedButton(
                height: 32.v,
                width: 60.h,
                text: (comment['userRate'] as num?)?.toInt().toString() ?? "N/A",
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
                buttonTextStyle: theme.textTheme.titleSmall!.copyWith(
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 16.h), // Add some spacing between user rate and delete button
            ],
          ),

          // Delete button aligned to the right if it's the user's comment
          if (isUserComment)
            Align(
              alignment: Alignment.centerRight,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 55.v,
                  maxHeight: 45.h,
                ),
                child: IconButton(
                  onPressed: () => _deleteComment(context),
                  icon: Image.asset(
                    'lib/images/delete_icon.png',
                    width: 150, // Adjust the width as needed
                    height: 150, // Adjust the height as needed
                  ),
                ),
              ),
            ),

          SizedBox(height: 12.v),
          Container(
            width: 293.h,
            margin: EdgeInsets.only(right: 39.h),
            child: Text(
              comment['userComment'] ?? "N/A",
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