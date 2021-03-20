import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

class HashCalculator2 extends StatefulWidget {
  @override
  _HashCalculatorState createState() => _HashCalculatorState();
}

class _HashCalculatorState extends State<HashCalculator2> {
  final controller = TextEditingController();
  String selection = "sha1";
  String? hash;
  final selections = [
    "sha1",
    "sha224",
    "sha256",
    "sha384",
    "sha512",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Pick your algorithm"),
        for (var s in selections)
          RadioListTile(
              title: Text(s),
              value: s,
              groupValue: selection,
              onChanged: (v) {
                setState(() {
                  selection = s;
                });
              }),
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
                  Digest digest;

                  switch (selection) {
                    case "sha1":
                      var bytes = utf8.encode(controller.text);
                      digest = sha1.convert(bytes);
                      break;
                    case "sha224":
                      var bytes = utf8.encode(controller.text);
                      digest = sha224.convert(bytes);
                      break;
                    case "sha256":
                      var bytes = utf8.encode(controller.text);
                      digest = sha256.convert(bytes);
                      break;
                    case "sha384":
                      var bytes = utf8.encode(controller.text);
                      digest = sha384.convert(bytes);
                      break;
                    case "sha512":
                      var bytes = utf8.encode(controller.text);
                      digest = sha512.convert(bytes);
                      break;

                    default:
                      var bytes = utf8.encode(controller.text);
                      digest = sha256.convert(bytes);
                  }

                  setState(() {
                    hash = digest.toString();
                  });
                },
                child: Text("Calculate hash!"))
          ],
        ),
        Text("$selection Hash: $hash")
      ],
    );
  }
}
