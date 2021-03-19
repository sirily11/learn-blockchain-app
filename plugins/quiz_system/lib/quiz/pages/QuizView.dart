import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_system/quiz/model/QuizObject.dart';
import 'package:quiz_system/quiz/model/QuizProvider.dart';
import 'package:quiz_system/quiz/pages/QuizPage.dart';

import 'components/QuizDisplay.dart';

class QuizView extends StatefulWidget {
  final List<Quiz> quizzes;
  final OnEnd onEnd;

  QuizView({@required this.quizzes, this.onEnd});

  @override
  _QuizViewState createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  @override
  void initState() {
    QuizProvider quizProvider = Provider.of(context, listen: false);
    quizProvider.quizzes = widget.quizzes;

    super.initState();
  }

  @override
  void didUpdateWidget(covariant QuizView oldWidget) {
    super.didUpdateWidget(oldWidget);
    QuizProvider quizProvider = Provider.of(context);
    if (oldWidget.quizzes != widget.quizzes) {
      quizProvider.quizzes = widget.quizzes;
    }
  }

  @override
  Widget build(BuildContext context) {
    QuizProvider quizProvider = Provider.of(context);
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: quizProvider.controller,
      children: widget.quizzes
          .map(
            (e) => QuizDisplay(
              onEnd: widget.onEnd,
              quiz: e,
            ),
          )
          .toList(),
    );
  }
}
