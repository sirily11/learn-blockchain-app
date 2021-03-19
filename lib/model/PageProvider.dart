import 'package:flutter/material.dart';

class PageProvider with ChangeNotifier {
  PageController pageController = PageController();

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
