import 'package:flutter/foundation.dart';
import '../model/tvMaze/show.dart';

class MyProvider extends ChangeNotifier {

  Show selectedShow;
  void setSelectedShow(Show newVal) {
    selectedShow = newVal;
    notifyListeners();
  }
}