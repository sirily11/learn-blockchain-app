import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:beamer/beamer.dart';

class FinishFailPage extends StatelessWidget {
  static const pathBlueprint = "/fail";
  static const valueKey = ValueKey("finishFailPage");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: CircleAvatar(
                backgroundColor: Colors.red,
                radius: 50,
                child: Icon(
                  Icons.clear,
                  color: Colors.white,
                  size: 50,
                ),
              ),
            ),
          ),
          Center(
            child: SizedBox(
              child: ColorizeAnimatedTextKit(
                repeatForever: true,
                onTap: () {
                  Navigator.pop(context);
                },
                text: [
                  "You failed the quiz!",
                ],
                textStyle: TextStyle(fontSize: 50.0, fontFamily: "Horizon"),
                colors: [
                  Colors.purple,
                  Colors.blue,
                  Colors.yellow,
                  Colors.red,
                ],
                textAlign: TextAlign.start,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Retry"),
          )
        ],
      ),
    );
  }
}
