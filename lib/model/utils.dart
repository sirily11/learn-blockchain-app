import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:learn_blockchain/pages/playgrounds/hash/HashPlayground.dart';

class Utils {
  static Future<String> loadMarkdown(String path) async {
    return await rootBundle.loadString(path);
  }

  static Future<dynamic> loadJSON(String path) async {
    var string = await rootBundle.loadString(path);

    return JsonDecoder().convert(string);
  }

  static Widget gotoPlayground(String path, String quizPath) {
    switch (path) {
      case "/hash":
        return HashPlayground(
          quizPath: quizPath,
        );
      default:
        return Text("No such page");
    }
  }
}

class PlaygroundUtils {
  static Future<List<String>> loadMarkdowns(int number, String basePath) async {
    List<String> desc = [];
    int i = 0;
    while (i < number) {
      var string = await rootBundle.loadString("$basePath/part${i + 1}.md");
      desc.add(string);
      i += 1;
    }

    return desc;
  }
}
