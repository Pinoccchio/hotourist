import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TouristListData {
  String imagePath;
  String titleTxt;
  String subTxt;
  String hotelDesc;
  double dist;
  double rating;
  int reviews;
  int perNight;
  final List<String> coverImages;
  final List<String> touristImages;
  final Map<String, String> imageDescriptions;
  final LatLng location;

  TouristListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.subTxt = '',
    this.hotelDesc = '',
    this.dist = 1.8,
    this.rating = 4.5,
    this.reviews = 80,
    this.perNight = 180,
    required this.touristImages,
    required this.imageDescriptions,
    required this.location,
    required this.coverImages,
  });

  static List<TouristListData> touristList = <TouristListData>[
    TouristListData(
      coverImages: [],
      imagePath: 'lib/assets/tourist_spot/casa_jose/cover_pic.jpg',
      titleTxt: 'Casa Jose',
      subTxt: 'Brgy. Candalapdap, Tagkawayan, Quezon, Philippines, 4321',
      location: LatLng(13.928344046703778, 122.48706794208965),
      touristImages: [
        'lib/assets/tourist_spot/casa_jose/montage/cover_pic2.jpg',
        'lib/assets/tourist_spot/casa_jose/montage/rv1.jpg',
        'lib/assets/tourist_spot/casa_jose/montage/rv2.jpg',
        'lib/assets/tourist_spot/casa_jose/montage/rv3.jpg',
        'lib/assets/tourist_spot/casa_jose/montage/rv4.jpg',
        'lib/assets/tourist_spot/casa_jose/montage/rv5.jpg',
        'lib/assets/tourist_spot/casa_jose/montage/rv6.jpg',
        'lib/assets/tourist_spot/casa_jose/montage/people.jpg',
        'lib/assets/tourist_spot/casa_jose/montage/people2.jpg',
        'lib/assets/tourist_spot/casa_jose/montage/people3.jpg',
        'lib/assets/tourist_spot/casa_jose/montage/gwapa.jpg',
        'lib/assets/tourist_spot/casa_jose/montage/family.jpg',
        'lib/assets/tourist_spot/casa_jose/montage/a.jpg',
        'lib/assets/tourist_spot/casa_jose/montage/b.jpg',
        'lib/assets/tourist_spot/casa_jose/montage/c.jpg',
        'lib/assets/tourist_spot/casa_jose/montage/d.jpg',
        'lib/assets/tourist_spot/casa_jose/montage/e.jpg',
        'lib/assets/tourist_spot/casa_jose/montage/f.jpg',
        'lib/assets/tourist_spot/casa_jose/montage/g.jpg',
        'lib/assets/tourist_spot/casa_jose/montage/shes.jpg',
        'lib/assets/tourist_spot/casa_jose/montage/wtf.jpg',

      ],
      imageDescriptions: {

      },
      hotelDesc: '''  
Casa Jose in Tagkawayan, Quezon, is a peaceful retreat located in Brgy. Candalapdap, just a 20-minute drive from the town center. Surrounded by lush greenery, the charming blend of rustic elegance and modern comfort makes it an ideal escape. Guests can enjoy well-appointed accommodations, serene gardens, and proximity to local attractions. Casa Jose offers a perfect balance of nature and relaxation for solo travelers, couples, and families alike.
''',
      dist: 2.0,
      reviews: 0,
      rating: 0.0,
      perNight: 275,
    ),
    TouristListData(
      coverImages: [],
      imagePath: 'lib/assets/tourist_spot/maniknik_falls/cover_pic.jpg',
      titleTxt: 'Maniknik Falls',
      subTxt: 'Barangay Maguibuay, Tagkawayan, Quezon',
      location: LatLng(14.019112034897091, 122.68418542244943),
      touristImages: [
        'lib/assets/tourist_spot/maniknik_falls/montage/a.jpg',
        'lib/assets/tourist_spot/maniknik_falls/montage/b.jpg',
        'lib/assets/tourist_spot/maniknik_falls/montage/c.jpg',
        'lib/assets/tourist_spot/maniknik_falls/montage/d.jpg',
        'lib/assets/tourist_spot/maniknik_falls/montage/e.jpg',
        'lib/assets/tourist_spot/maniknik_falls/montage/f.jpg',
        'lib/assets/tourist_spot/maniknik_falls/montage/g.jpg',
        'lib/assets/tourist_spot/maniknik_falls/montage/h.jpg',
        'lib/assets/tourist_spot/maniknik_falls/montage/i.jpg',
        'lib/assets/tourist_spot/maniknik_falls/montage/j.jpg',
        'lib/assets/tourist_spot/maniknik_falls/montage/k.jpg',
        'lib/assets/tourist_spot/maniknik_falls/montage/l.jpg',
        'lib/assets/tourist_spot/maniknik_falls/montage/m.jpg',
        'lib/assets/tourist_spot/maniknik_falls/montage/n.jpg',
        'lib/assets/tourist_spot/maniknik_falls/montage/o.jpg',
        'lib/assets/tourist_spot/maniknik_falls/montage/p.jpg',
        'lib/assets/tourist_spot/maniknik_falls/montage/q.jpg',
        'lib/assets/tourist_spot/maniknik_falls/montage/r.jpg',
        'lib/assets/tourist_spot/maniknik_falls/montage/s.jpg',
      ],
      imageDescriptions: {

      },
      hotelDesc: '''  
It is approximately 6-7 kilometers from the barangay proper and it is 1–1 ½ hours of trek depending on the pace with one trail leading to the waterfalls. It has a total of seven waterfalls from top to bottom. The main waterfall of Maniknik is approximately 60-80 feet in height with a depth of 10-12 feet.
How to get there
From the town proper, it is 17 kilometers and will take you 45 minutes-1 hour ride through any means of land transportation (tricycle, motorcycle or any four-wheel vehicles) to reach the barangay proper of Maguibuay. Then ride straight to the DENR Station or the rice fields through farm-to-market road. There you can leave you vehicles and start the trek.

ABOUT TAGKAWAYAN
Tagkawayan is the last town in Quezon Province going south to the Bicol Region. Its residents are known as Tagkawayanin and speak the native dialect of Tagalog. Tagkawayan gained its status of being a first-class municipality in 2010. Surrounded by rich agricultural greeneries and fishing areas and accessible by all kinds of transportation, Tagkawayan has always been an ideal place for trade and commerce!

CONTACT US
MUNICIPALITY OF TAGKAWAYAN
Municipal Bldg. Maxi Drive, Brgy. Poblacion
Tagkawayan, Quezon 4321 Philippines
Mobile: 0917-830-2903
Email: omm_lgutagkawayan@yahoo.com
Email: omm@tagkawayan.gov.ph  
''',
      dist: 2.0,
      reviews: 0,
      rating: 0.0,
      perNight: 350,
    ),
    TouristListData(
      coverImages: [],
      imagePath: 'lib/assets/tourist_spot/sunchine_beach/montage/386445509_2531650283674933_5721579118751760469_n.jpg',
      titleTxt: 'Sunchine Beach',
      subTxt: 'Barangay Laurel, Tagkawayan, Quezon',
      location: LatLng(13.948891975933334, 122.50163854100975),
      touristImages: [
        'lib/assets/tourist_spot/sunchine_beach/montage/369398287_1481458455777520_4063639658606351786_n.jpg',
        'lib/assets/tourist_spot/sunchine_beach/montage/370099389_897190711962257_3477632578246766520_n.jpg',
        'lib/assets/tourist_spot/sunchine_beach/montage/370200865_763815815583221_8254545877999662251_n.jpg',
        'lib/assets/tourist_spot/sunchine_beach/montage/370259617_1178050780247638_2961241689035926525_n.jpg',
        'lib/assets/tourist_spot/sunchine_beach/montage/385561587_3529945023959783_3783274505764424739_n.jpg',
        'lib/assets/tourist_spot/sunchine_beach/montage/387459133_271089849270507_5487038007579700441_n.jpg',
        'lib/assets/tourist_spot/sunchine_beach/montage/387459682_274572211865084_6458028305473806282_n.jpg',
        'lib/assets/tourist_spot/sunchine_beach/montage/387463038_1501523880695026_5660577317938781450_n.jpg',
        'lib/assets/tourist_spot/sunchine_beach/montage/387467282_1062315931635120_7716841755627335586_n.jpg',
        'lib/assets/tourist_spot/sunchine_beach/montage/387499951_701614581943146_7241733104372446759_n.jpg',
        'lib/assets/tourist_spot/sunchine_beach/montage/405480608_2014727852223360_381331809956384892_n.jpg',
      ],
      imageDescriptions: {

      },
      hotelDesc: '''  
Sunshine Beach, nestled in the heart of Barangay Laurel, Tagkawayan, Quezon, is a tropical haven that beckons travelers with its pristine beauty. This idyllic stretch of coastline features golden sands that invite leisurely walks and sun-soaked relaxation. The crystal-clear waters offer a refreshing escape, perfect for swimming or engaging in water activities. As the day draws to a close, visitors are treated to a breathtaking spectacle – a vibrant sunset that paints the sky in hues of orange and pink. The beach is adorned with lush greenery and swaying coconut palms, creating a serene backdrop. Adventure enthusiasts can partake in water activities like snorkeling and kayaking, exploring the vibrant marine life beneath the surface. Additionally, Sunshine Beach provides a taste of local culture with its delicious seafood and traditional Filipino cuisine served by welcoming locals. The warmth and hospitality of the community enhance the overall experience, making Sunshine Beach a must-visit destination for those seeking a tranquil escape and a touch of tropical paradise in Quezon province.
''',
      dist: 2.0,
      reviews: 0,
      rating: 0.0,
      perNight: 270,
    ),
    TouristListData(
      coverImages: [],
      imagePath: 'lib/assets/tourist_spot/mataas_na_bato/cover_pic.jpg',
      titleTxt: 'Mataas na Bato Beach Resort',
      subTxt: 'Barangay Rizal, Tagkawayan, Quezon',
      location: LatLng(13.946800068752081, 122.54922596054327),
      touristImages: [
        'lib/assets/tourist_spot/mataas_na_bato/montage/400787027_1121831318804728_6896979919252455373_n.jpg',
        'lib/assets/tourist_spot/mataas_na_bato/montage/395186760_1067306074595269_7301272494776926737_n.jpg',
        'lib/assets/tourist_spot/mataas_na_bato/montage/387627665_711925844373806_800952489351507628_n.jpg',
        'lib/assets/tourist_spot/mataas_na_bato/montage/387508264_2611169462376073_8322247072183549742_n.jpg',
        'lib/assets/tourist_spot/mataas_na_bato/montage/387501263_1296966507645408_6292653519675999128_n.jpg',
        'lib/assets/tourist_spot/mataas_na_bato/montage/387501130_1650631765343967_2530449757632264303_n.jpg',
        'lib/assets/tourist_spot/mataas_na_bato/montage/387501103_1345960649371500_6084631882446890487_n.jpg',
        'lib/assets/tourist_spot/mataas_na_bato/montage/387501066_1093379689458247_3314180107716718273_n.jpg',
        'lib/assets/tourist_spot/mataas_na_bato/montage/387501020_289389623597177_1004009487214329035_n.jpg',
        'lib/assets/tourist_spot/mataas_na_bato/montage/387499567_380600667861087_8335378062051222618_n.jpg',
        'lib/assets/tourist_spot/mataas_na_bato/montage/387494118_1092305761803727_3535317658893188334_n.jpg',
        'lib/assets/tourist_spot/mataas_na_bato/montage/386889113_229255786869901_8459442506148970291_n.jpg',
        'lib/assets/tourist_spot/mataas_na_bato/montage/385559816_1428376947755716_8052144305248988774_n.jpg',
      ],
      imageDescriptions: {

      },
      hotelDesc: '''  
Mataas na Bato Beach Resort, nestled along the pristine shores of Barangay Rizal in Tagkawayan, Quezon, is a coastal haven that promises an enchanting retreat. This idyllic resort embodies the perfect blend of natural beauty and modern comfort. Guests are welcomed by the soft, golden sands of Mataas na Bato Beach, where they can bask in the sun or take a refreshing dip in the azure waters of the Pacific. The resort's lush surroundings, adorned with swaying palm trees, create a tranquil atmosphere for relaxation. Mataas na Bato Beach Resort offers well-appointed accommodations, ensuring a comfortable stay for visitors seeking a peaceful escape. With a range of amenities, including beachfront cottages, water activities, and delectable local cuisine, this resort is an ideal destination for those looking to unwind and rejuvenate amidst the scenic beauty of Quezon province. Whether you're seeking adventure or tranquility, Mataas na Bato Beach Resort invites you to indulge in a memorable seaside experience in the heart of Barangay Rizal.
''',
      dist: 2.0,
      reviews: 0,
      rating: 0.0,
      perNight: 500,
    ),
    TouristListData(
      coverImages: [],
      imagePath: 'lib/assets/tourist_spot/gastadores_mountain_resort/cover_pic.jpg',
      titleTxt: 'Gastadores Mountain Resort ',
      subTxt: 'Sitio Vitom, Tagkawayan, Quezon',
      location: LatLng(14.008542215047433, 122.54891439286259),
      touristImages: [
        'lib/assets/tourist_spot/gastadores_mountain_resort/montage/395855008_674852934775728_3787794948386022257_n.jpg',
        'lib/assets/tourist_spot/gastadores_mountain_resort/montage/395221177_379402691309723_6646644879836564248_n.jpg',
        'lib/assets/tourist_spot/gastadores_mountain_resort/montage/393088670_357825940311178_8136198962961076971_n.jpg',
        'lib/assets/tourist_spot/gastadores_mountain_resort/montage/393081999_320410260821899_5075039561912160965_n.jpg',
        'lib/assets/tourist_spot/gastadores_mountain_resort/montage/393081998_372401748615035_7775833993475139224_n.jpg',
        'lib/assets/tourist_spot/gastadores_mountain_resort/montage/387518218_907308354177888_3457074541182316606_n.jpg',
        'lib/assets/tourist_spot/gastadores_mountain_resort/montage/387508191_332058646288762_7249582856149923723_n.jpg',
        'lib/assets/tourist_spot/gastadores_mountain_resort/montage/387507905_927402585645751_4169278952850666232_n.jpg',
        'lib/assets/tourist_spot/gastadores_mountain_resort/montage/387506865_1111541876672551_3940097003273790858_n.jpg',
        'lib/assets/tourist_spot/gastadores_mountain_resort/montage/387505369_684048303710627_507560296906767828_n.jpg',
        'lib/assets/tourist_spot/gastadores_mountain_resort/montage/387499960_364170539525687_5072668025498240871_n.jpg',
        'lib/assets/tourist_spot/gastadores_mountain_resort/montage/387499538_2010486409324884_524303322938050861_n.jpg',
      ],
      imageDescriptions: {

      },
      hotelDesc: '''  
Nestled in the heart of nature, Gastadores Mountain Resort, situated in Sitio Vitom, Tagkawayan, 4321 Quezon, stands as a serene haven for those seeking a tranquil escape. Surrounded by lush greenery and set against the backdrop of majestic mountains, the resort offers a perfect blend of relaxation and adventure. Guests are greeted by well-appointed accommodations designed to provide comfort and immerse them in the beauty of the natural surroundings. Whether you're looking to unwind by the pool, embark on nature trails, or simply enjoy the breathtaking views, Gastadores Mountain Resort caters to every traveler's desire. The resort's commitment to hospitality is evident in its warm and welcoming ambiance. With a range of amenities and activities, from cozy cabins to outdoor adventures, Gastadores Mountain Resort invites visitors to experience a harmonious blend of comfort and nature in the enchanting landscapes of Quezon.
''',
      dist: 2.0,
      reviews: 0,
      rating: 0.0,
      perNight: 450,
    ),
    TouristListData(
      coverImages: [],
      imagePath: 'lib/assets/tourist_spot/maguibuay_falls/montage/350361339_171251862298115_3482834782758839448_n.jpg',
      titleTxt: 'Maguibuay Falls',
      subTxt: 'Barangay, Tagkawayan, Quezon',
      location: LatLng(14.019545338590149, 122.68410249440454),
      touristImages: [
        'lib/assets/tourist_spot/maguibuay_falls/montage/341789091_256965513357576_2476424527614760386_n.jpg',
        'lib/assets/tourist_spot/maguibuay_falls/montage/343719530_1282550672657824_1010671542483426987_n.jpg',
        'lib/assets/tourist_spot/maguibuay_falls/montage/350361339_171251862298115_3482834782758839448_n.jpg',
        'lib/assets/tourist_spot/maguibuay_falls/montage/350364242_1438594376883881_3998178258788744050_n.jpg',
        'lib/assets/tourist_spot/maguibuay_falls/montage/387514039_1052025072594925_7513958642797002020_n.jpg',
        'lib/assets/tourist_spot/mataas_na_bato/montage/1.jpg',
        'lib/assets/tourist_spot/mataas_na_bato/montage/ha.jpg',
        'lib/assets/tourist_spot/mataas_na_bato/montage/he.jpg',
        'lib/assets/tourist_spot/mataas_na_bato/montage/a.jpg',
        'lib/assets/tourist_spot/mataas_na_bato/montage/b.jpg',
        'lib/assets/tourist_spot/mataas_na_bato/montage/c.jpg',
        'lib/assets/tourist_spot/mataas_na_bato/montage/d.jpg',
        'lib/assets/tourist_spot/mataas_na_bato/montage/e.jpg',
        'lib/assets/tourist_spot/mataas_na_bato/montage/f.jpg',
        'lib/assets/tourist_spot/mataas_na_bato/montage/g.jpg',
        'lib/assets/tourist_spot/mataas_na_bato/montage/2.jpg'
      ],
      imageDescriptions: {

      },
      hotelDesc: '''  
The most popular and well known waterfall in Tagkawayan. It has three waterfalls that are in close proximity with one another. A favorite destination for locals and outsiders looking for a quick getaway. Located in Brgy. Maguibuay, Tagkawayan, Quezon. It is only a 30- minute trek (or less depending on the pace) from the Brgy. Proper.
''',
      dist: 2.0,
      reviews: 0,
      rating: 0.0,
      perNight: 430,
    ),
  ];

  TouristListData.fromMap(Map<String, dynamic> map, this.coverImages)
      : imagePath = map['imagePath'] ?? '',
        titleTxt = map['titleTxt'] ?? '',
        subTxt = map['subTxt'] ?? '',
        hotelDesc = map['hotelDesc'] ?? '',
        dist = (map['dist'] ?? 1.8).toDouble(),
        rating = (map['rating'] ?? 4.5).toDouble(),
        reviews = map['reviews'] ?? 80,
        perNight = map['perNight'] ?? 180,
        touristImages = List<String>.from(map['touristImages'] ?? []),
        imageDescriptions = Map<String, String>.from(map['imageDescriptions'] ?? {}),
        location = LatLng(map['location']['latitude'], map['location']['longitude']);

  static Future<void> updateTouristDataFromFirestore() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    for (var touristData in touristList) {
      await firestore
          .collection('HotelApp')
          .doc('TouristRatings')
          .collection('RatingsData')
          .doc(touristData.titleTxt)
          .get()
          .then((snapshot) {
        if (snapshot.exists) {
          Map<String, dynamic>? data = snapshot.data();

          // Update rating and reviews in hotelList
          touristData.rating = data?['averageRating'] ?? 0.0;
          touristData.reviews = data?['totalReviews'] ?? 0;
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
      'touristImages': touristImages,
      'imageDescriptions': imageDescriptions,
      'location': {
        'latitude': location.latitude,
        'longitude': location.longitude,
      },
    };
  }

  factory TouristListData.fromJson(Map<String, dynamic> json) {
    return TouristListData(
      imagePath: json['imagePath'] ?? '',
      titleTxt: json['titleTxt'] ?? '',
      subTxt: json['subTxt'] ?? '',
      hotelDesc: json['hotelDesc'] ?? '',
      dist: (json['dist'] ?? 1.8).toDouble(),
      rating: (json['rating'] ?? 4.5).toDouble(),
      reviews: json['reviews'] ?? 80,
      perNight: json['perNight'] ?? 180,
      coverImages: List<String>.from(json['coverImages'] ?? []),
      touristImages: List<String>.from(json['touristImages'] ?? []),
      imageDescriptions: Map<String, String>.from(json['imageDescriptions'] ?? {}),
      location: LatLng(json['location']['latitude'], json['location']['longitude']),
    );
  }
}