import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:learn_blockchain/model/PageProvider.dart';
import 'package:provider/provider.dart';

class FinishSuccessfulPage extends StatelessWidget {
  static const pathBlueprint = "/success";
  static const valueKey = ValueKey("finishSuccessfulPage");

  @override
  Widget build(BuildContext context) {
    PageProvider pageProvider = Provider.of(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: CircleAvatar(
                backgroundColor: Colors.green,
                radius: 50,
                child: Icon(
                  Icons.done,
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
                  print("Tap Event");
                },
                text: ["You passed the quiz!", "20 LBCC rewared"],
                textStyle: TextStyle(fontSize: 20.0, fontFamily: "Horizon"),
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
              Navigator.pushReplacementNamed(context, "/");
            },
            child: Text("Back Home"),
          )
        ],
      ),
    );
  }
}
