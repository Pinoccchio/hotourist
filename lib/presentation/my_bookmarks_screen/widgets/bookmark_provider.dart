import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../home_screen_page/hotel_class/hotel_list_model.dart';
import '../../home_screen_page/hotel_class/touristSpot_list_model.dart';

class BookmarkProvider extends ChangeNotifier {
  List<HotelListData> _bookmarkedHotels = [];
  List<TouristListData> _bookmarkedTourists = [];
  late String _userId;

  List<HotelListData> get bookmarkedHotels => _bookmarkedHotels;
  List<TouristListData> get bookmarkedTourists => _bookmarkedTourists;

  BookmarkProvider() {
    _userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    loadBookmarks();
  }

  bool isBookmarked(dynamic data) {
    if (data is HotelListData) {
      return _bookmarkedHotels.contains(data);
    } else if (data is TouristListData) {
      return _bookmarkedTourists.contains(data);
    }
    return false;
  }

  void addBookmark(dynamic data) {
    if (data is HotelListData && !_bookmarkedHotels.contains(data)) {
      _bookmarkedHotels.add(data);
    } else if (data is TouristListData && !_bookmarkedTourists.contains(data)) {
      _bookmarkedTourists.add(data);
    }
    saveBookmarks();
    notifyListeners();
  }

  void removeBookmark(dynamic data) {
    if (data is HotelListData) {
      _bookmarkedHotels.remove(data);
    } else if (data is TouristListData) {
      _bookmarkedTourists.remove(data);
    }
    saveBookmarks();
    notifyListeners();
  }

  void clearBookmarks() {
    _bookmarkedHotels.clear();
    _bookmarkedTourists.clear();
    saveBookmarks();
    notifyListeners();
  }

  Future<void> saveBookmarks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> bookmarkedHotelsJson =
    _bookmarkedHotels.map((hotel) => json.encode(hotel.toJson())).toList();
    List<String> bookmarkedTouristsJson =
    _bookmarkedTourists.map((tourist) => json.encode(tourist.toJson())).toList();
    prefs.setStringList('bookmarkedHotels_$_userId', bookmarkedHotelsJson);
    prefs.setStringList('bookmarkedTourists_$_userId', bookmarkedTouristsJson);
  }

  Future<void> loadBookmarks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? bookmarkedHotelsJson =
    prefs.getStringList('bookmarkedHotels_$_userId');
    List<String>? bookmarkedTouristsJson =
    prefs.getStringList('bookmarkedTourists_$_userId');
    if (bookmarkedHotelsJson != null) {
      _bookmarkedHotels = bookmarkedHotelsJson
          .map((json) => HotelListData.fromJson(jsonDecode(json)))
          .toList();
    } else {
      _bookmarkedHotels = [];
    }
    if (bookmarkedTouristsJson != null) {
      _bookmarkedTourists = bookmarkedTouristsJson
          .map((json) => TouristListData.fromJson(jsonDecode(json)))
          .toList();
    } else {
      _bookmarkedTourists = [];
    }
    notifyListeners();
  }
}

final bookmarkProvider = BookmarkProvider();