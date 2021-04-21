import 'package:flutter/material.dart';
import 'package:learn_blockchain/model/StoryProvider.dart';
import 'package:learn_blockchain/model/utils.dart';
import 'package:provider/provider.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:quiz_system/quiz/pages/QuizPage.dart';

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
              onEnd: (n, t) async {
                if ((n / t) > 0.7) {
                  StoryProvider userProvider =
                      Provider.of(context, listen: false);
                  var account = await userProvider.getAccount();
                  if (account.privateKey != null) {
                    userProvider.mint(account.privateKey!, 20);
                  }

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
