import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:learn_blockchain/pages/playgrounds/difficulty/DifficultyHashCalculator%20copy.dart';
import 'package:learn_blockchain/pages/playgrounds/difficulty/DifficultyHashCalculator.dart';
import 'package:learn_blockchain/pages/playgrounds/difficulty/DifficultyHashCalculator3.dart';
import 'package:learn_blockchain/pages/playgrounds/hash/HashPlayground.dart';

class DifficultyPlayground extends StatefulWidget {
  final style = MarkdownStyleSheet(p: TextStyle(height: 2));
  final List<String> descriptions;

  DifficultyPlayground({Key? key, required this.descriptions})
      : super(key: key);
  @override
  _DifficultyPlaygroundState createState() => _DifficultyPlaygroundState();
}

class _DifficultyPlaygroundState extends State<DifficultyPlayground> {
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      MarkdownBody(
        data: widget.descriptions[0],
        styleSheet: widget.style,
      ),
      ExampleCard(
        child: DifficultyHashCalculator1(),
        title: "Simple Difficulty calculator",
      ),
      MarkdownBody(
        data: widget.descriptions[1],
        styleSheet: widget.style,
      ),
      ExampleCard(
        child: DifficultyHashCalculator2(),
        title: "Adavance Difficulty calculator",
      ),
      MarkdownBody(
        data: widget.descriptions[2],
        styleSheet: widget.style,
      ),
      ExampleCard(
        child: DifficultyHashCalculator3(),
        title: "Dynamic Difficulty calculator",
      ),
    ]);
  }
}
