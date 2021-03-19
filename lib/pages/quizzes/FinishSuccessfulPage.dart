import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:learn_blockchain/model/PageProvider.dart';
import 'package:provider/provider.dart';

class FinishSuccessfulPage extends StatelessWidget {
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
                text: [
                  "You passed the quiz!",
                ],
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
              Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
            },
            child: Text("Back Home"),
          )
        ],
      ),
    );
  }
}
