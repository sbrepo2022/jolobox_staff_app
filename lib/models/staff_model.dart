import 'package:flutter/material.dart';


class EmployeeData {
  EmployeeData({
    required this.id,
    required this.avatar,
    required this.firstname,
    required this.midname,
    required this.lastname,
    required this.position
  });

  int id;
  String avatar;
  String firstname;
  String midname;
  String lastname;
  String position;
}


class StaffModel with ChangeNotifier {
  List<EmployeeData> _employeeData = [];
  List<EmployeeData> get employeeData => _employeeData;
  set employeeData(List<EmployeeData> val) {
    _employeeData = val;
    notifyListeners();
  }
}