import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';
import 'package:quiz_system/quiz/model/QuizObject.dart';
import 'package:quiz_system/quiz/model/QuizProvider.dart';
import 'package:quiz_system/quiz/pages/QuizPage.dart';
import 'package:quiz_system/quiz/pages/components/AnswerDisplay.dart';

class QuizDisplay extends StatefulWidget {
  final Quiz quiz;
  final OnEnd onEnd;

  QuizDisplay({@required this.quiz, this.onEnd});

  @override
  _QuizDisplayState createState() => _QuizDisplayState();
}

class _QuizDisplayState extends State<QuizDisplay> {
  int selected = -1;
  bool showAnswer = false;
  bool isCorrect = false;

  @override
  Widget build(BuildContext context) {
    QuizProvider quizProvider = Provider.of(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            widget.quiz.name,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: MarkdownBody(data: widget.quiz.description),
        ),
        for (var selection in widget.quiz.selections)
          RadioListTile(
            title: Text(selection.description),
            value: widget.quiz.selections.indexOf(selection),
            groupValue: selected,
            onChanged: showAnswer
                ? null
                : (v) {
                    setState(() {
                      selected = v;
                    });
                  },
          ),
        if (showAnswer)
          AnswerDisplay(isCorrect: isCorrect, answer: widget.quiz.answer.first),
        Row(
          children: [
            Spacer(),
            if (!showAnswer)
              ElevatedButton(
                onPressed: selected == -1
                    ? null
                    : () {
                        var correct =
                            quizProvider.checkAnswer(widget.quiz, selected);
                        setState(() {
                          isCorrect = correct;
                          showAnswer = true;
                        });
                      },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Submit"),
                ),
              ),
            if (showAnswer)
              ElevatedButton(
                onPressed: () {
                  var canGoNext = quizProvider.nextQuestion();
                  if (!canGoNext) {
                    if (widget.onEnd != null) {
                      widget.onEnd(
                          quizProvider.numCorrect, quizProvider.quizzes.length);
                    }
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Next"),
                ),
              )
          ],
        )
      ]),
    );
  }
}
