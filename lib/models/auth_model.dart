import 'package:flutter/material.dart';


class AuthModel with ChangeNotifier {
  bool _isUserAuth = true;
  bool get isUserAuth => _isUserAuth;
  set isUserAuth(bool val) {
    _isUserAuth = val;
    notifyListeners();
  }
}