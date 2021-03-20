import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

class HashCalculator extends StatefulWidget {
  @override
  _HashCalculatorState createState() => _HashCalculatorState();
}

class _HashCalculatorState extends State<HashCalculator> {
  final controller = TextEditingController();
  String? hash;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(labelText: "Enter something"),
                controller: controller,
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  var bytes = utf8.encode(controller.text);
                  var digest = sha256.convert(bytes);
                  setState(() {
                    hash = digest.toString();
                  });
                },
                child: Text("Calculate hash!"))
          ],
        ),
        Text("Result Hash: $hash")
      ],
    );
  }
}
