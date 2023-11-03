import 'package:flutter/material.dart';

class PlaylistProvider extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  bool isSearch = false;

  void setSearch(bool val) {
    isSearch = val;
    notifyListeners();
  }
}
