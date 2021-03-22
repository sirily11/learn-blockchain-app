import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

class DifficultyHashCalculator2 extends StatefulWidget {
  @override
  _DifficultyHashCalculator2State createState() =>
      _DifficultyHashCalculator2State();
}

class _DifficultyHashCalculator2State extends State<DifficultyHashCalculator2> {
  String? result;
  int nounce = 0;
  bool found = false;
  bool run = false;
  double difficulty = 1;

  bool allZeroes(String value) {
    for (var i = 0; i < value.length; i++) {
      if (value[i] != "0") {
        return false;
      }
    }
    return true;
  }

  void _generateHash() {
    var time = DateTime.now().toString();
    Future.doWhile(() async {
      var content = time + nounce.toString();
      var bytes = utf8.encode(content);
      var digest = sha256.convert(bytes);
      setState(() {
        result = digest.toString();
        nounce += 1;
      });
      await Future.delayed(
        Duration(milliseconds: 70),
      );
      if (allZeroes(result!.substring(0, difficulty.toInt()))) {
        setState(() {
          found = true;
          run = false;
        });
        return false;
      }

      return run;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Spacer(),
          Text(
            "Difficulty Level: ${difficulty.toInt()}",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Slider(
            min: 1,
            max: 10,
            value: difficulty,
            onChanged: (v) {
              setState(() {
                difficulty = v;
              });
            },
          ),
          IconButton(
            tooltip: "Run/Stop",
            icon: Icon(!run ? Icons.arrow_right : Icons.stop),
            onPressed: () {
              if (!run) {
                setState(() {
                  nounce = 0;
                  run = true;
                  found = false;
                });
                _generateHash();
              } else {
                setState(() {
                  run = false;
                });
              }
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
