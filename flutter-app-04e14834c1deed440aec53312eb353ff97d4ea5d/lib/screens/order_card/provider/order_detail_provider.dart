import 'package:europharm_flutter/network/models/order_dto.dart';
import 'package:europharm_flutter/network/models/point_dto.dart';
import 'package:flutter/material.dart';

class OrderDetailProvider extends ChangeNotifier {
  int _selected = -1;

  int get selected => _selected;
  set selected(int value) {
    _selected = value;
    notifyListeners();
  }

  PointDTO? _point;
  OrderDTO? _orderId;

  PointDTO? get point => _point;
  set point(PointDTO? p) {
    _point = p;
    notifyListeners();
  }

  OrderDTO? get orderId => _orderId;
  set orderId(OrderDTO? o) {
    _orderId = o;
    notifyListeners();
  }

  bool _isScan = false;

  bool get isScan => _isScan;
  set isScan(bool isScan) {
    _isScan = isScan;
    notifyListeners();
  }

  void init() {
    _orderId = orderId;
    _point = null;
    _isScan = false;
    _selected = -1;
  }
}
