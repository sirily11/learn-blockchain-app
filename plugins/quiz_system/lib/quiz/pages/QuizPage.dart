import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_system/quiz/model/QuizObject.dart';
import 'package:quiz_system/quiz/model/QuizProvider.dart';
import 'package:quiz_system/quiz/pages/QuizView.dart';

typedef OnEnd(int numCorrect, int total);

class QuizPage extends StatefulWidget {
  final List<dynamic> json;
  final OnEnd onEnd;

  QuizPage({@required this.json, this.onEnd});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Quiz> quizzes = [];

  @override
  void initState() {
    super.initState();
    parseJSON();
  }

  @override
  void didUpdateWidget(covariant QuizPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.json != widget.json) {
      parseJSON();
    }
  }

  void parseJSON() {
    quizzes = widget.json.map((e) => Quiz.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => QuizProvider(),
        )
      ],
      child: QuizView(
        quizzes: quizzes,
        onEnd: widget.onEnd,
      ),
    );
  }
}
