import 'dart:convert';
import 'package:path/path.dart' as p;
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
}

class PlaygroundUtils {
  static String getTitle(String playgroundPath) {
    switch (playgroundPath) {
      case "/hash":
        return "Hash Playground";

      default:
        return "No path";
    }
  }

  static Widget getWidget(
      {required String playgroundPath, required List<String> descriptions}) {
    switch (playgroundPath) {
      case "/hash":
        return HashPlayground(descriptions: descriptions);

      default:
        return Text("Invaild playground path");
    }
  }

  static int getNumberOfDescriptions({required String playgroundPath}) {
    switch (playgroundPath) {
      case "/hash":
        return 2;

      default:
        return 0;
    }
  }

  static String getFilePath({required String playgroundPath}) {
    switch (playgroundPath) {
      case "/hash":
        return "assets/playground/hash";

      default:
        return "";
    }
  }

  static Future<List<String>> loadMarkdowns(int number, String basePath) async {
    List<String> desc = [];
    int i = 0;
    while (i < number) {
      var string =
          await rootBundle.loadString(p.join(basePath, "part${i + 1}.md"));
      desc.add(string);
      i += 1;
    }

    return desc;
  }
}
