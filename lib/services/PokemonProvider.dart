import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TypeSelected with ChangeNotifier {

  Set<String> _selectedTypes = {};
  String _generacion = "";

  Set<String> get selectedTypes => _selectedTypes;

  void toggleType(String type) {
    if (_selectedTypes.contains(type)) {
      _selectedTypes.remove(type);
    } else if (_selectedTypes.length < 2) {
      _selectedTypes.add(type);
    }
    notifyListeners();
  }

  String get generacionSelected => _generacion;

  void setGeneracion (String select) {
    _generacion = select;
    notifyListeners();
  }

}