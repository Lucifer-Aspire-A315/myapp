import 'package:flutter/material.dart';

class PageStatusProvider with ChangeNotifier {
  int currentStep = 1;

  void updateStep(int step) {
    currentStep = step;
    notifyListeners();
  }
}
