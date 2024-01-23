import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_app/presentation/home_screen_page/hotel_class/touristSpot_list_model.dart';
import 'package:hotel_app/review_page/widgets/tourist_reviewlistcomponent_item_widget.dart';
import '../../theme/custom_text_style.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/custom_image_view.dart';
import '../review_page/widgets/reviewlistcomponent_item_widget.dart';
import '../services/notif_service.dart';

class TouristReviewPage extends StatefulWidget {
  final TouristListData touristData;

  const TouristReviewPage({Key? key, required this.touristData}) : super(key: key);

  @override
  TouristReviewPageState createState() => TouristReviewPageState();
}

class TouristReviewPageState extends State<TouristReviewPage> with AutomaticKeepAliveClientMixin<TouristReviewPage> {
  User? currentUser;
  List<Map<String, dynamic>> comments = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int totalReviews = 0;
  double averageRating = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
    fetchComments();
  }

  Future<void> fetchComments() async {
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection('HotelApp')
          .doc('Tourist_User_Comments_Ratings')
          .collection(widget.touristData.titleTxt)
          .get();
      setState(() {
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

        // Check for new comments
        if (comments.isNotEmpty && comments.length < uniqueComments.length) {
          _notifyNewComment(); // Notify the user about new comments
        }

        comments = uniqueComments;

        // Calculate average rating
        averageRating = calculateAverageRating(comments);

        // Update total reviews
        totalReviews = comments.length;
        // Save rating data to Firestore
        saveRatingDataToFirestore();
      });
    } catch (e) {
      print('Error fetching comments: $e');
    }
  }

  void _notifyNewComment() {
    NotificationService().simpleNotificationShow(
      title: 'New Comment',
      body: 'There is a new comment on ${widget.touristData.titleTxt}!',
    );
  }

  void saveRatingDataToFirestore() {
    _firestore
        .collection('HotelApp')
        .doc('TouristRatings')
        .collection('RatingsData')
        .doc(widget.touristData.titleTxt)
        .set({
      'averageRating': averageRating,
      'totalReviews': totalReviews,
      'timestamp': FieldValue.serverTimestamp(),
    }).then((value) {
      print('Rating data saved to Firestore');
    }).catchError((error) {
      print('Failed to save rating data: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 37),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      _buildRatingRow(context),
                      SizedBox(height: 18),
                      _buildReviewListComponent(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRatingRow(BuildContext context) {
    return comments.isEmpty
        ? Text(
      "No reviews yet",
      style: CustomTextStyles.titleMediumWhiteA700_1,
    )
        : Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Rating",
                style: CustomTextStyles.titleMediumWhiteA700_1,
              ),
              Spacer(),
              CustomImageView(
                imagePath: 'lib/images/img_signal.svg',
                height: 16,
                width: 16,
                margin: EdgeInsets.only(bottom: 4),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text(
                  averageRating.toStringAsFixed(1), // Display one decimal place
                  style: theme.textTheme.titleMedium,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 9,
            bottom: 3,
          ),
          child: Text(
            "($totalReviews reviews)",
            style: theme.textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }

  Widget _buildReviewListComponent(BuildContext context) {
    return comments.isEmpty
        ? Text(
      "Be the first to write a review!",
      style: theme.textTheme.bodyMedium,
    )
        : ListView.separated(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 20,
        );
      },
      itemCount: comments.length,
      itemBuilder: (context, index) {
        print("${comments[index]['userRate']}");
        return TouristReviewListComponentItemWidget(
          touristData: widget.touristData,
          userEmail: currentUser!.email.toString(),
          userRate: comments[index]['userRate'],
          comment: comments[index],
          onCommentDeleted: () {
            // Implement logic to refresh the reviews after a comment is deleted
            fetchComments();
          },
        );
      },
    );
  }

  double calculateAverageRating(List<Map<String, dynamic>> comments) {
    if (comments.isEmpty) {
      return 0.0; // Return 0 if there are no comments
    }

    double totalRating = 0.0;

    for (var comment in comments) {
      // Ensure 'userRate' is not null before calculating
      if (comment['userRate'] != null) {
        totalRating += (comment['userRate'] as num).toDouble();
      }
    }

    return totalRating / comments.length;
  }
}
