import 'package:example/demoData.dart';
import 'package:flutter/material.dart';
import 'package:quiz_system/quiz_system.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Home());
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: QuizPage(
        json: demoData,
        onEnd: (n, t) {
          showDialog(
            context: context,
            builder: (c) => AlertDialog(
              title: Text("Final result"),
              content: Text("Correct: ${n}"),
            ),
          );
        },
      ),
    );
  }
}
