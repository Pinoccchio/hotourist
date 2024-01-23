import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hotel_app/core/app_export.dart';
import '../../services/notif_service.dart';
import '../../theme/app_decoration.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../home_screen_page/hotel_class/hotel_list_model.dart';
import '../home_screen_tab_container_page/home_screen_tab_container_page.dart';

class RateHotelBottomsheet extends StatefulWidget {
  final HotelListData hotelData;

  RateHotelBottomsheet({required this.hotelData});

  @override
  _RateHotelBottomsheetState createState() => _RateHotelBottomsheetState();
}

class _RateHotelBottomsheetState extends State<RateHotelBottomsheet> {
  double rating = 0.0;
  TextEditingController commentController = TextEditingController();
  bool hasRated = false;
  bool hasCommented = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late User? user;

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  void fetchUser() {
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Container(
        width: screenWidth * 0.9,
        padding: EdgeInsets.symmetric(
          horizontal: 23.h,
          vertical: 14.v,
        ),
        decoration: AppDecoration.outlineGray.copyWith(
          borderRadius: BorderRadiusStyle.customBorderTL40,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildRateHotelStack(context, screenWidth),
            SizedBox(height: 18.v),
            _buildStatusFillTypeDefaultColumn(context, screenWidth),
            SizedBox(height: 12.v),
            CustomElevatedButton(
              text: "Rate now",
              buttonStyle: CustomButtonStyles.fillPrimary,
              onPressed: () {
                // Handle the rating submission and storing data to Firebase
                if (rating > 0 && commentController.text.isNotEmpty) {
                  _submitRating();
                  NotificationService().simpleNotificationShow(
                    title: 'Feedback Submitted',
                    body: 'Thank you for rating and commenting on ${widget.hotelData.titleTxt}!',
                  );
                } else {
                  // Show toast if rating or comment is missing
                  Fluttertoast.showToast(
                    msg: 'Please rate and comment before submitting.',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Color(0xFF1AADB6), // Set background color to #1AADB6
                    textColor: Colors.white, // Set text color to white
                    fontSize: 16.0,
                  );
                }
              },
            ),
            SizedBox(height: 8.v),
            CustomElevatedButton(
              text: "Later",
              buttonStyle: CustomButtonStyles.fillGray,
              onPressed: () {
                Navigator.of(context).pop(); // Close the bottom sheet
              },
            ),
            SizedBox(height: 22.v),
          ],
        ),
      ),
    );
  }

  Widget _buildRateHotelStack(BuildContext context, double screenWidth) {
    return SizedBox(
      height: 327.v,
      width: 380.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(
                top: 86.v,
                bottom: 100.v,
              ),
              padding: EdgeInsets.all(20.h),
              decoration: AppDecoration.outlineBlackC.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Display the hotel image
                  Image.asset(
                    widget.hotelData.imagePath,
                    height: 100.adaptSize,
                    width: 100.adaptSize,
                    fit: BoxFit.cover,
                    // You can add more styling if needed
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 16.h,
                      top: 9.v,
                      bottom: 9.v,
                    ),
                    child: Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _truncateWithEllipsis(
                                widget.hotelData.titleTxt, 10),
                            style: theme.textTheme.titleLarge,
                          ),
                          SizedBox(height: 9.v),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              _truncateWithEllipsis(
                                  widget.hotelData.subTxt, 10),
                              style: theme.textTheme.bodyMedium,
                            ),
                          ),
                          SizedBox(height: 12.v),
                          SizedBox(
                            width: 123.h,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 35.h,
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomImageView(
                                        imagePath:
                                        'lib/images/img_signal.svg',
                                        height: 12.adaptSize,
                                        width: 12.adaptSize,
                                        margin: EdgeInsets.symmetric(
                                            vertical: 2.v),
                                      ),
                                      Text(
                                        widget.hotelData.rating.toString(),
                                        style: CustomTextStyles
                                            .titleSmallPrimary,
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "(${widget.hotelData.reviews} reviews)",
                                  style: theme.textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 6.v,
                      bottom: 47.v,
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${widget.hotelData.perNight}",
                          style: CustomTextStyles.headlineSmallPrimary,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 5.v),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "/ night",
                            style: CustomTextStyles.bodySmall10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buildRateHotelColumn(context),
        ],
      ),
    );
  }


  Widget _buildRateHotelColumn(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 45.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgFrame,
                height: 3.v,
                width: 38.h,
              ),
              SizedBox(height: 23.v),
              Text(
                "Rate the Hotel",
                style: theme.textTheme.headlineSmall,
              ),
              SizedBox(height: 20.v),
              RatingBar.builder(
                initialRating: rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemSize: 25.0,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (value) {
                  setState(() {
                    rating = value;
                    hasRated = true; // Set hasRated to true when rating is given
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusFillTypeDefaultColumn(
      BuildContext context, double screenWidth) {
    return Container(
      width: screenWidth * 0.9,
      padding: EdgeInsets.symmetric(
        horizontal: 20.h,
        vertical: 19.v,
      ),
      decoration: AppDecoration.fillBlueGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder12,
      ),
      child: Container(
        width: screenWidth * 0.8,
        margin: EdgeInsets.only(right: 14.h),
        child: Tooltip(
          message: "User Comments",
          child: Column(
            children: [
              TextField(
                controller: commentController,
                decoration: InputDecoration(
                  hintText: "Type your comment here...",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    hasCommented = value.isNotEmpty; // Set hasCommented based on comment text input
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitRating() {
      saveRatingAndCommentToFirestore(rating, commentController.text);
    }


  void saveRatingAndCommentToFirestore(double userRating, String comment) {
    if (hasCommented) {
      _firestore
          .collection('HotelApp')
          .doc('User_Comments_Ratings')
          .collection(widget.hotelData.titleTxt)
          .add({
        'userEmail': user?.email,
        'userRate': userRating,
        'userComment': comment,
        'timestamp': FieldValue.serverTimestamp(),
        'userProfile': user?.photoURL,
      }).then((value) {
        print('User rating and comment data saved to Firestore');
        // After saving the user's rating and comment, fetch comments and update UI
        fetchCommentsAndUpdateUI();
        // Use Navigator.pop to close the bottom sheet
        Navigator.pop(context);

        // Show a toast indicating that the data is refreshed
        Fluttertoast.showToast(
          msg: 'Data refreshed! Click the Home Icon to see the changes.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xFF1AADB6), // Set background color to #1AADB6
          textColor: Colors.white, // Set text color to white
          fontSize: 16.0,
        );
        // If HomeScreenTabContainerPage is the parent widget, use the following:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreenTabContainerPage(),
          ),
        );
      }).catchError((error) {
        print('Failed to save user rating and comment data: $error');
      });
    }
  }

  Future<void> fetchCommentsAndUpdateUI() async {
    try {
      var snapshot = await _firestore
          .collection('HotelApp')
          .doc('User_Comments_Ratings')
          .collection(widget.hotelData.titleTxt)
          .get();

      Set<String> uniqueUserEmails = Set();
      List<Map<String, dynamic>> uniqueComments = [];

      snapshot.docs.forEach((doc) {
        String userEmail = doc.data()['userEmail'];
        if (!uniqueUserEmails.contains(userEmail)) {
          uniqueUserEmails.add(userEmail);
          uniqueComments.add({
            'userEmail': userEmail,
            'userRate': doc.data()['userRate'],
            'userComment': doc.data()['userComment'],
            'timestamp': doc['timestamp'],
            'userProfile': doc.data()['userProfile'],
            'commentId': doc.id,
          });
        }
      });

      double newAverageRating = calculateAverageRating(uniqueComments);
      int newTotalReviews = uniqueComments.length;

      saveRatingDataToFirestore(newAverageRating, newTotalReviews);
    } catch (e) {
      print('Error fetching comments: $e');
    }
  }

  void saveRatingDataToFirestore(double newAverageRating, int newTotalReviews) {
    _firestore
        .collection('HotelApp')
        .doc('HotelRatings')
        .collection('RatingsData')
        .doc(widget.hotelData.titleTxt)
        .set({
      'averageRating': newAverageRating,
      'totalReviews': newTotalReviews,
      'timestamp': FieldValue.serverTimestamp(),
    }).then((value) {
      print('Rating data saved to Firestore');
      Navigator.of(context).pop(); // Close the bottom sheet
    }).catchError((error) {
      print('Failed to save rating data: $error');
    });
  }

  double calculateAverageRating(List<Map<String, dynamic>> comments) {
    if (comments.isEmpty) {
      return 0.0;
    }

    double totalRating = 0.0;

    for (var comment in comments) {
      if (comment['userRate'] != null) {
        totalRating += (comment['userRate'] as num).toDouble();
      }
    }

    return totalRating / comments.length;
  }

  String _truncateWithEllipsis(String input, int maxLength) {
    if (input.length <= maxLength) {
      return input;
    } else {
      return input.substring(0, maxLength) + '...';
    }
  }
}