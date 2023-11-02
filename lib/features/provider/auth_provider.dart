import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  String countryCode = "+91";
  bool isOTP = false;
  bool isValidNumber = false;

  void setOptScreen(bool val) {
    isOTP = val;
    notifyListeners();
  }

  void setValidNumber(bool val) {
    isValidNumber = val;
    notifyListeners();
  }

  void setCountryCode(String code) {
    countryCode = code;
    notifyListeners();
  }
}
