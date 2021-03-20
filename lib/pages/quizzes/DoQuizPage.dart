import 'package:flutter/material.dart';
import 'package:learn_blockchain/locations/DocumentLocation.dart';
import 'package:learn_blockchain/model/utils.dart';
import 'package:learn_blockchain/pages/documents/DocumentPage.dart';
import 'package:learn_blockchain/pages/home/HomePage.dart';
import 'package:learn_blockchain/pages/playgrounds/PlaygroundPage.dart';
import 'package:learn_blockchain/pages/quizzes/FinishFailPage.dart';
import 'package:learn_blockchain/pages/quizzes/FinishSuccessfulPage.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:quiz_system/quiz/pages/QuizPage.dart';
import 'package:beamer/beamer.dart';
import 'package:path/path.dart' as p;

class DoQuizPage extends StatefulWidget {
  static const pathBlueprint = "/quiz";
  static const valueKey = ValueKey("quiz");

  final String quizPath;

  DoQuizPage({required this.quizPath});

  @override
  _DoQuizPageState createState() => _DoQuizPageState();
}

class _DoQuizPageState extends State<DoQuizPage> {
  List<dynamic>? json;
  bool _showSuccess = false;
  bool _showFail = false;

  @override
  void initState() {
    loadJson();
    super.initState();
  }

  void loadJson() async {
    var result = await Utils.loadJSON(widget.quizPath);
    setState(() {
      json = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildPage();
  }

  Scaffold _buildPage() {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz!"),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: json != null
          ? QuizPage(
              json: json,
              onEnd: (n, t) {
                if ((n / t) > 0.7) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/success", (route) => false);
                } else {
                  Navigator.pushReplacementNamed(context, "/fail");
                }
              },
            )
          : null,
    );
  }
}