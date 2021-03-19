import 'package:flutter/material.dart';

class PageProvider with ChangeNotifier {
  PageController pageController = PageController();
  String _title = "";

  set title(String t) {
    _title = t;
    notifyListeners();
  }

  String get title => _title;

  void nextPage() {
    pageController.nextPage(
        duration: Duration(milliseconds: 200), curve: Curves.bounceInOut);
  }

  void prevPage() {
    pageController.previousPage(
        duration: Duration(milliseconds: 200), curve: Curves.bounceInOut);
  }

  void clearPage() {
    pageController.dispose();
    pageController = PageController();
  }
}
