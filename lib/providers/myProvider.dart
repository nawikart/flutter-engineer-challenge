import 'package:flutter/foundation.dart';

class MyProvider extends ChangeNotifier {

  String mode = 'dark';
  void setMode(String newVal) {
    mode = newVal;
    notifyListeners();
  }

  String theme = 'dark';
  void setTheme(String newVal) {
    theme = newVal;
    notifyListeners();
  }
}