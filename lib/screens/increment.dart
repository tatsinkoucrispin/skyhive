import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IncrementModel extends ChangeNotifier {
  int count = 0;

  void increment() {
    count++;
    notifyListeners();
  }
}