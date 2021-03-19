import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:learn_blockchain/model/utils.dart';
import 'package:learn_blockchain/pages/playgrounds/TakeQuizButton.dart';
import 'package:learn_blockchain/pages/playgrounds/hash/HashCalculator.dart';
import 'package:learn_blockchain/pages/playgrounds/hash/HashCalculator2.dart';

class HashPlayground extends StatefulWidget {
  final String quizPath;

  HashPlayground({@required this.quizPath});

  @override
  _HashPlaygroundState createState() => _HashPlaygroundState();
}

class _HashPlaygroundState extends State<HashPlayground> {
  final style = MarkdownStyleSheet(p: TextStyle(height: 2));
  final numberOfMarkdowns = 2;
  List<String> descriptions = [];

  @override
  void initState() {
    super.initState();
    PlaygroundUtils.loadMarkdowns(numberOfMarkdowns, "assets/playground/hash")
        .then((value) {
      setState(() {
        descriptions = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hash playground"),
        actions: [
          TakeQuizButton(quizPath: widget.quizPath),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: descriptions.length > 0
            ? ListView(
                children: [
                  Container(
                    height: 200,
                    child: RotateAnimatedTextKit(
                      repeatForever: true,
                      text: ["It's", "all about", "hashing!"],
                      textStyle:
                          TextStyle(fontSize: 40.0, fontFamily: "Horizon"),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  MarkdownBody(
                    data: descriptions[0],
                    styleSheet: style,
                  ),
                  ExampleCard(
                    child: HashCalculator(),
                    title: "Simple Hash Calculator",
                  ),
                  MarkdownBody(
                    data: descriptions[1],
                    styleSheet: style,
                  ),
                  ExampleCard(
                    child: HashCalculator2(),
                    title: "Advance Hash Calculator",
                  )
                ],
              )
            : null,
      ),
    );
  }
}

class ExampleCard extends StatelessWidget {
  final Widget child;
  final String title;

  ExampleCard({@required this.child, this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: this.child,
            ),
          ),
          Text("Example: $title")
        ],
      ),
    );
  }
}
