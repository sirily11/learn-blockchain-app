import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quiz_system/quiz/model/QuizObject.dart';

class QuizProvider with ChangeNotifier {
  final PageController controller = PageController();
  List<Quiz> _quizzes = [];
  int numCorrect = 0;
  int currentPage = 0;

  List<Quiz> get quizzes => _quizzes;

  set quizzes(List<Quiz> q) {
    numCorrect = 0;
    _quizzes = q;
  }

  bool checkAnswer(Quiz question, int selection) {
    var answer = question.answer.first;
    var isCorrect = answer.index == selection;
    if (isCorrect) {
      numCorrect += 1;
    }
    return isCorrect;
  }

  bool nextQuestion() {
    if (controller.page < quizzes.length - 1) {
      controller.nextPage(
          duration: Duration(milliseconds: 200), curve: Curves.easeIn);
      return true;
    }
    return false;
  }

  double submit() {
    return 0;
  }
}
