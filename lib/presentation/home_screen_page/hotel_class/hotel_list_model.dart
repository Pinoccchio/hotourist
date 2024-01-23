import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HotelListData {
  String imagePath;
  String titleTxt;
  String subTxt;
  String hotelDesc;
  double dist;
  double rating;
  int reviews;
  int perNight;
  final List<String> coverImages;
  final List<String> hotelImages;
  final Map<String, String> imageDescriptions;
  final LatLng location;

  HotelListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.subTxt = '',
    this.hotelDesc = '',
    this.dist = 1.8,
    this.rating = 4.5,
    this.reviews = 80,
    this.perNight = 180,
    required this.hotelImages,
    required this.imageDescriptions,
    required this.location,
    required this.coverImages,
  });

  static List<HotelListData> hotelList = <HotelListData>[
    HotelListData(
      coverImages: [
        'lib/assets/pompeo/pompeo_1.jpg',
        'lib/assets/pompeo/2.jpg',
        'lib/assets/pompeo/3.jpg',
      ],
      imagePath: 'lib/assets/pompeo/pompeo_1.jpg',
      titleTxt: 'Pompeo and Luming\'s Inn',
      subTxt: '119 Morato St., Brgy. Sta. Cecilia',
      location: LatLng(13.967131919737728, 122.53395714451771),
      hotelImages: [
        'lib/assets/pompeo/introPic/6.jpg',
        'lib/assets/pompeo/introPic/7.jpg',
        'lib/assets/pompeo/pompeo_room_suites.png',
        //MASTER SUITE IMAGES
        'lib/assets/pompeo/master_suite_img/master_suite_img.png',
        'lib/assets/pompeo/master_suite_img/1.jpg',
        'lib/assets/pompeo/master_suite_img/2.jpg',
        'lib/assets/pompeo/master_suite_img/3.jpg',
        'lib/assets/pompeo/master_suite_img/4.jpg',
        'lib/assets/pompeo/master_suite_img/5.jpg',
        'lib/assets/pompeo/master_suite_img/6.jpg',
        'lib/assets/pompeo/master_suite_img/7.jpg',
        'lib/assets/pompeo/master_suite_img/8.jpg',
        'lib/assets/pompeo/master_suite_img/9.jpg',
        'lib/assets/pompeo/master_suite_img/10.jpg',
        //JUNIOR SUITE IMAGES
        'lib/assets/pompeo/junior_suite_img/junior_site_img.png',
        'lib/assets/pompeo/junior_suite_img/1.jpg',
        'lib/assets/pompeo/junior_suite_img/2.jpg',
        'lib/assets/pompeo/junior_suite_img/3.jpg',
        'lib/assets/pompeo/junior_suite_img/4.jpg',
        'lib/assets/pompeo/junior_suite_img/5.jpg',
        'lib/assets/pompeo/junior_suite_img/6.jpg',
        'lib/assets/pompeo/junior_suite_img/7.jpg',
        'lib/assets/pompeo/junior_suite_img/8.jpg',
        'lib/assets/pompeo/junior_suite_img/9.jpg',
        //QUAD ROOM
        'lib/assets/pompeo/quad_room_img/quad_room_img.png',
        'lib/assets/pompeo/quad_room_img/1.jpg',
        'lib/assets/pompeo/quad_room_img/2.jpg',
        'lib/assets/pompeo/quad_room_img/3.jpg',
        'lib/assets/pompeo/quad_room_img/4.jpg',
        'lib/assets/pompeo/quad_room_img/5.jpg',
        'lib/assets/pompeo/quad_room_img/6.jpg',
        'lib/assets/pompeo/quad_room_img/7.jpg',
        'lib/assets/pompeo/quad_room_img/8.jpg',
        'lib/assets/pompeo/quad_room_img/9.jpg',
        'lib/assets/pompeo/quad_room_img/10.jpg',
        // Add more image URLs as needed
      ],
      imageDescriptions: {
        'lib/assets/pompeo/master_suite_img/master_suite_img.png':
        'MASTER SUITE: 8 GUESTS / 2 DOUBLE SIZE BEDS, 1 DAYBED, 1 PULLOUT BED & 1 BUNKBED',
        'lib/assets/pompeo/junior_suite_img/junior_site_img.png':
        'JUNIOR SUITE: 6 GUESTS / 1 DOUBLE SIZE BEDS, 1 DAYBED, 1 PULLOUT BED & 1 BUNKBED',
        'lib/assets/pompeo/quad_room_img/quad_room_img.png':
        'QUAD ROOM: 4 GUESTS / 2 DOUBLE SIZE BEDS',
      },
      hotelDesc: '''  
Pompeo and Luming's Inn: Unforgettable Hospitality in Quezon Province, Philippines

Discover life's most exciting choices at Pompeo and Luming's Inn, a highly-rated hotel nestled in the heart of Tagkawayan, Quezon, Philippines. Ranked #1 of 132 hotels and #1 of 62 B&B Inns in Quezon Province by TripAdvisor, this inn is a popular destination for tourists and locals alike.

Accommodation Highlights:
• Clean and scented rooms
• Private comfort room
• Hot and cold shower
• Flat screen television with local cable channels
• Complimentary breakfast
• Free parking
• Unlimited brewed coffee & drinking water
• Gazebo and garden
• On-call massage
• 24/7 CCTV
• WiFi available in the lobby and gazebo
• No brownouts
• Hair dryer, clothes iron, and ironing board available upon request
• 5-story service

Additional Information:
• Pompeo and Luming's Inn is not just a place to stay; it's an experience. With its signature Tagkawayanin hospitality, the inn consistently aims to deliver great stories through genuinely premium experiences and exemplary service.

Location:
• Situated in the vibrant heart of Tagkawayan, Quezon, Pompeo and Luming's Inn provides a central hub for exploring the beauty of Quezon Province.

Whether you are a traveler seeking comfort or a local looking for a retreat, Pompeo and Luming's Inn is your home away from home, offering unforgettable hospitality and luxurious accommodation.

Experience life's finest moments at Pompeo and Luming's Inn.
''',
      dist: 2.0,
      reviews: 0,
      rating: 0.0,
      perNight: 2700,
    ),
    HotelListData(
      coverImages: [
        'lib/assets/j_and_b/intro_pic/cover_pic.jpg',
        'lib/assets/j_and_b/intro_pic/2.jpg',
      ],
      imagePath: 'lib/assets/j_and_b/intro_pic/cover_pic.jpg',
      titleTxt: 'J&B Hotel',
      subTxt: 'Lagdameo St., Sta. Cecilia, Tagkawayan',
      location: LatLng(13.967821027750194, 122.53598474378533),
      hotelImages: [
        'lib/assets/j_and_b/montage/393818680_2741771445971683_8955348890979213143_n.jpg',
        'lib/assets/j_and_b/montage/410504478_1503846920471257_8885242424471513568_n.jpg',
        // STANDARD DOUBLE ROOM FAN
        'lib/assets/j_and_b/standard_double_room_fan/description.png',
        'lib/assets/j_and_b/standard_double_room_fan/a.jpg',
        'lib/assets/j_and_b/standard_double_room_fan/b.jpg',
        'lib/assets/j_and_b/standard_double_room_fan/c.jpg',
        'lib/assets/j_and_b/standard_double_room_fan/d.jpg',
        //STANDARD FAMILY ROOM
        'lib/assets/j_and_b/standard_family_room/description.png',
        'lib/assets/j_and_b/standard_family_room/a.jpg',
        'lib/assets/j_and_b/standard_family_room/b.jpg',
        'lib/assets/j_and_b/standard_family_room/c.jpg',
        'lib/assets/j_and_b/standard_family_room/d.jpg',
        //STANDARD DOUBLE ROOM
        'lib/assets/j_and_b/standard_double_room/desc.png',
        'lib/assets/j_and_b/standard_double_room/a.jpg',
        'lib/assets/j_and_b/standard_double_room/b.jpg',
        //Montage
        'lib/assets/j_and_b/montage/410504478_1503846920471257_8885242424471513568_n.jpg',
        'lib/assets/j_and_b/montage/370212378_884061463160204_7444462299652543259_n.jpg',
        'lib/assets/j_and_b/montage/385533506_377214311487667_5329603375893264989_n.jpg',
        'lib/assets/j_and_b/montage/387489963_378420011257433_1564989836949408961_n.jpg',
        'lib/assets/j_and_b/montage/387493855_320078230905769_1040993190078295026_n.jpg',
        'lib/assets/j_and_b/montage/387499468_3299151647044849_2563491930642681020_n.jpg',
        'lib/assets/j_and_b/montage/387499538_1675093182981003_7685116159115778658_n.jpg',
        'lib/assets/j_and_b/montage/387547874_261181593354948_1633078349846936607_n.jpg',
        'lib/assets/j_and_b/montage/393818680_2741771445971683_8955348890979213143_n.jpg',
        'lib/assets/j_and_b/montage/410443859_1836639513436716_7285342571508038319_n.jpg',
        'lib/assets/j_and_b/montage/410461647_329723683243761_2248343793288094575_n.jpg',
        'lib/assets/j_and_b/montage/410695675_2963430043787867_4851173127935462350_n.jpg',
        'lib/assets/j_and_b/montage/411561023_315938798073225_5050571777480480094_n.jpg',
        'lib/assets/j_and_b/montage/412278258_664486999214819_4693037761099133069_n.jpg',
      ],
      imageDescriptions: {
        'lib/assets/j_and_b/standard_double_room/description.png':
        'Max: 2 persons, Bed options: 1 Double bed',
        'lib/assets/j_and_b/standard_family_room/description.png':
        'Max: 5 persons, Bed options: 1 Double bed',
        'lib/assets/j_and_b/standard_double_room/desc.png':
        'Max: 2 persons, Bed options: 1 Double bed',
      },
      hotelDesc: "J&B Hotel is a 1-star property set in Tagkawayan. The property features a 24-hour front desk.The nearest airport is Naga Airport, 90 km from the property."
          "Get the best deals without needing a promo code! Save on your reservation by booking with our discount rates at J&B Hotel in Philippines.",
      dist: 4.0,
      reviews: 0,
      rating: 0.0,
      perNight: 200,
    ),
  ];

  HotelListData.fromMap(Map<String, dynamic> map, this.coverImages)
      : imagePath = map['imagePath'] ?? '',
        titleTxt = map['titleTxt'] ?? '',
        subTxt = map['subTxt'] ?? '',
        hotelDesc = map['hotelDesc'] ?? '',
        dist = (map['dist'] ?? 1.8).toDouble(),
        rating = (map['rating'] ?? 4.5).toDouble(),
        reviews = map['reviews'] ?? 80,
        perNight = map['perNight'] ?? 180,
        hotelImages = List<String>.from(map['hotelImages'] ?? []),
        imageDescriptions = Map<String, String>.from(map['imageDescriptions'] ?? {}),
        location = LatLng(map['location']['latitude'], map['location']['longitude']);

  static Future<void> updateHotelDataFromFirestore() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    for (var hotelData in hotelList) {
      await firestore
          .collection('HotelApp')
          .doc('HotelRatings')
          .collection('RatingsData')
          .doc(hotelData.titleTxt)
          .get()
          .then((snapshot) {
        if (snapshot.exists) {
          Map<String, dynamic>? data = snapshot.data();

          // Update rating and reviews in hotelList
          hotelData.rating = data?['averageRating'] ?? 0.0;
          hotelData.reviews = data?['totalReviews'] ?? 0;
        }
      });
    }
  }
  Map<String, dynamic> toJson() {
    return {
      'imagePath': imagePath,
      'titleTxt': titleTxt,
      'subTxt': subTxt,
      'hotelDesc': hotelDesc,
      'dist': dist,
      'rating': rating,
      'reviews': reviews,
      'perNight': perNight,
      'coverImages': coverImages, // Include coverImages field
      'hotelImages': hotelImages,
      'imageDescriptions': imageDescriptions,
      'location': {
        'latitude': location.latitude,
        'longitude': location.longitude,
      },
    };
  }
  factory HotelListData.fromJson(Map<String, dynamic> json) {
    return HotelListData(
      imagePath: json['imagePath'] ?? '',
      titleTxt: json['titleTxt'] ?? '',
      subTxt: json['subTxt'] ?? '',
      hotelDesc: json['hotelDesc'] ?? '',
      dist: (json['dist'] ?? 1.8).toDouble(),
      rating: (json['rating'] ?? 4.5).toDouble(),
      reviews: json['reviews'] ?? 80,
      perNight: json['perNight'] ?? 180,
      coverImages: List<String>.from(json['coverImages'] ?? []), // Include coverImages field
      hotelImages: List<String>.from(json['hotelImages'] ?? []),
      imageDescriptions: Map<String, String>.from(json['imageDescriptions'] ?? {}),
      location: LatLng(json['location']['latitude'], json['location']['longitude']),
    );
  }

}