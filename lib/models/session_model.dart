import 'package:flutter/material.dart';


class SessionModel with ChangeNotifier {
  bool _isSessionActive = true;
  bool get isSessionActive => _isSessionActive;
  set isSessionActive(bool val) {
    _isSessionActive = val;
    notifyListeners();
  }
}