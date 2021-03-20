import 'package:flutter/material.dart';
import 'package:learn_blockchain/locations/DocumentLocation.dart';
import 'package:learn_blockchain/pages/documents/DocumentPage.dart';
import 'package:learn_blockchain/pages/playgrounds/PlaygroundPage.dart';
import 'package:learn_blockchain/pages/quizzes/DoQuizPage.dart';
import 'package:beamer/beamer.dart';
import 'package:path/path.dart' as p;

class TakeQuizButton extends StatelessWidget {
  final String quizPath;

  TakeQuizButton({required this.quizPath});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.note),
      tooltip: "Take Quiz",
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (c) => DoQuizPage(
              quizPath: quizPath,
            ),
          ),
        );
      },
    );
  }
}
