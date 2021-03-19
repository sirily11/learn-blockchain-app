import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:quiz_system/quiz/model/QuizObject.dart';

class AnswerDisplay extends StatelessWidget {
  final bool isCorrect;
  final Answer answer;

  AnswerDisplay({@required this.isCorrect, @required this.answer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: isCorrect ? Colors.blue : Colors.red,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your answer is ${isCorrect ? "Correct" : "Wrong"}",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                MarkdownBody(
                  data: answer.description,
                  styleSheet: MarkdownStyleSheet(
                    p: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
