import 'package:flutter/material.dart';
import 'package:learn_blockchain/pages/quizzes/DoQuizPage.dart';

class TakeQuizButton extends StatelessWidget {
  final String quizPath;

  TakeQuizButton({@required this.quizPath});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.note),
      tooltip: "Take Quiz",
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => DoQuizPage(quizPath: quizPath),
          ),
        );
      },
    );
  }
}
