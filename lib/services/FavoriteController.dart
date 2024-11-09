import 'package:flutter/cupertino.dart';

class FavoriteController extends ChangeNotifier {
  bool _isFavorite = false;

  bool get isFavorite => _isFavorite;

  void setFavorite(bool value) {
    _isFavorite = value;
    notifyListeners();
  }
}