import 'package:flutter/material.dart';


enum OrderStatus {
  notViewed,
  viewed,
  processing,
  finished
}


class OrderPositionData {
  OrderPositionData({
    required this.name,
    required this.count,
    this.children,
  });

  String name;
  int count;
  List<OrderPositionData>? children;
}

class OrderData {
  OrderData({
    required this.id,
    required this.markName,
    required this.time,
    required this.orderNumber,
    required this.orderPositions,
  });

  int id;
  String markName;
  DateTime time;
  int orderNumber;
  List<OrderPositionData> orderPositions;

  OrderStatus status = OrderStatus.notViewed;
}


class OrdersModel with ChangeNotifier {
  List<OrderData> _ordersData = [];
  List<OrderData> get ordersData => _ordersData;
  set ordersData(List<OrderData> val) {
    _ordersData = val;
    notifyListeners();
  }

  void updateOrder(OrderData val) {
    int index = _ordersData.indexWhere((element) => element.id == val.id);
    _ordersData[index] = val;
    notifyListeners();
  }

  void addOrders(List<OrderData> arr) {
    _ordersData += arr;
    notifyListeners();
  }
}
