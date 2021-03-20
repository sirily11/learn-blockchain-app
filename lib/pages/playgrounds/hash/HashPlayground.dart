import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:learn_blockchain/model/utils.dart';
import 'package:learn_blockchain/pages/playgrounds/TakeQuizButton.dart';
import 'package:learn_blockchain/pages/playgrounds/hash/HashCalculator.dart';
import 'package:learn_blockchain/pages/playgrounds/hash/HashCalculator2.dart';

class HashPlayground extends StatelessWidget {
  final style = MarkdownStyleSheet(p: TextStyle(height: 2));
  final List<String> descriptions;

  HashPlayground({Key? key, required this.descriptions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          height: 200,
          child: RotateAnimatedTextKit(
            repeatForever: true,
            text: ["It's", "all about", "hashing!"],
            textStyle: TextStyle(fontSize: 40.0, fontFamily: "Horizon"),
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
    );
  }
}

class ExampleCard extends StatelessWidget {
  final Widget child;
  final String? title;

  ExampleCard({required this.child, this.title});

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
