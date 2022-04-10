import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled/config.dart';
import 'package:untitled/screen/favorite.dart';
import 'package:untitled/services/base_auth.dart';

class FavoriteProvider with ChangeNotifier {
  BaseAuth? baseAuth;
  List<dynamic> favoritesId = [];
  List<dynamic> get getFavoritesId => favoritesId;

  Future<List<dynamic>> getFavoriteList() async {
    try {
      baseAuth = Auth();
      final userData = await baseAuth!.getCurrentUser();
      var ds = await FirebaseFirestore.instance
          .collection(Config.favorites)
          .doc(userData!.uid)
          .get();
      if (ds.exists) {
        favoritesId = ds.data()!['symbol'];
        notifyListeners();
      } else {}
      return favoritesId;
    } catch (e) {
      return [];
    }
  }

  void addFavoriteId(id) {
    favoritesId.add(id);
    notifyListeners();
  }

  void removeFavoriteId(id) {
    favoritesId.remove(id);
    notifyListeners();
  }

  void addFavorite(List favorite) {
    baseAuth!.getCurrentUser().then((user) {
      FirebaseFirestore.instance
          .collection('favorites')
          .doc(user!.uid)
          .set({'symbol': favorite});
      notifyListeners();
    });
  }
}
