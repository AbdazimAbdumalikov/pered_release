import 'package:flutter/material.dart';
import 'package:europharm_flutter/network/models/dto_models/response/container_accept.dart';

class ContainerAcceptProvider extends ChangeNotifier {
  int _selected = -1;

  int get selected => _selected;
  set selected(int value) {
    _selected = value;
    notifyListeners();
  }
}