import 'package:flutter/material.dart';


class MarkData {
  MarkData({
    required this.id,
    required this.name,
    required this.value,
    required this.notListen,
  });

  int id;
  String name;
  bool value;
  bool notListen;
}


class MarksModel with ChangeNotifier {
  List<MarkData> _marksData = [];
  List<MarkData> get marksData => _marksData;
  set marksData(List<MarkData> val) {
    _marksData = val;
    notifyListeners();
  }

  void updateMark(MarkData val) {
    int index = _marksData.indexWhere((element) => element.id == val.id);
    _marksData[index] = val;
    notifyListeners();
  }
}
