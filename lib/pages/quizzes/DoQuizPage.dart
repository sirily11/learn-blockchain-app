import 'package:flutter/material.dart';
import 'package:learn_blockchain/model/utils.dart';
import 'package:quiz_system/quiz/pages/QuizPage.dart';

class DoQuizPage extends StatefulWidget {
  final String quizPath;

  DoQuizPage({@required this.quizPath});

  @override
  _DoQuizPageState createState() => _DoQuizPageState();
}

class _DoQuizPageState extends State<DoQuizPage> {
  List<dynamic> json;

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz!"),
      ),
      body: json != null
          ? QuizPage(
              json: json,
              onEnd: (n, t) {
                if ((n / t) > 0.7) {
                  Navigator.pushNamed(context, "/success");
                } else {
                  Navigator.pushNamed(context, "/fail");
                }
              },
            )
          : null,
    );
  }
}
