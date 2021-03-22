import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

class DifficultyHashCalculator1 extends StatefulWidget {
  @override
  _DifficultyHashCalculator1State createState() =>
      _DifficultyHashCalculator1State();
}

class _DifficultyHashCalculator1State extends State<DifficultyHashCalculator1> {
  String? result;
  int nounce = 0;
  bool found = false;

  void _generateHash() {
    var content = DateTime.now().toString() + nounce.toString();
    var bytes = utf8.encode(content);
    var digest = sha256.convert(bytes);
    setState(() {
      result = digest.toString();
      nounce += 1;
      if (result?.substring(0, 2) == "00") {
        found = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Spacer(),
          Text(
            "Black Box",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          IconButton(
            tooltip: "Run",
            icon: Icon(Icons.arrow_right),
            onPressed: () {
              _generateHash();
            },
          ),
          Text("Result: $result"),
          Text(
            "You tried: $nounce times, and ${found ? "found" : "not found"} ",
          ),
          Spacer(),
        ],
      ),
    );
  }
}
