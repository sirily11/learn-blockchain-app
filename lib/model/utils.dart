import 'dart:convert';
import 'dart:io';
// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';
import 'package:learn_blockchain/data/story.dart';
import 'package:learn_blockchain/pages/playgrounds/difficulty/DifficultyPlayground.dart';
import 'package:native_pdf_view/native_pdf_view.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:learn_blockchain/pages/playgrounds/hash/HashPlayground.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class Utils {
  static Future<String> loadMarkdown(String path) async {
    return await rootBundle.loadString(path);
  }

  static Future<dynamic> loadJSON(String path) async {
    var string = await rootBundle.loadString(path);

    return JsonDecoder().convert(string);
  }

  static Future<PdfController?> loadPdfFromNetwork(String path) async {
    try {
      var dio = Dio();
      final tmpPath = await getApplicationDocumentsDirectory();
      final savePath = p.join(tmpPath.toString(), p.basename(path));
      var status = await Permission.storage.request();
      if (!await File(savePath).exists()) {
        await dio.download(path, savePath);
      }

      return PdfController(document: PdfDocument.openFile(savePath));
    } catch (err) {
      print(err);
    }
  }
}

class PlaygroundUtils {
  static String getTitle(String playgroundPath) {
    switch (playgroundPath) {
      case "/hash":
        return "Hash Playground";

      case "/difficulty":
        return "Difficulty Playground";

      default:
        return "No path";
    }
  }

  static Widget getWidget(
      {required String playgroundPath, required List<String> descriptions}) {
    switch (playgroundPath) {
      case "/hash":
        return HashPlayground(descriptions: descriptions);
      case "/difficulty":
        return DifficultyPlayground(descriptions: descriptions);

      default:
        return Text("Invaild playground path");
    }
  }

  static int getNumberOfDescriptions({required String playgroundPath}) {
    switch (playgroundPath) {
      case "/hash":
        return 2;

      case "/difficulty":
        return 3;

      default:
        return 0;
    }
  }

  static String getFilePath({required String playgroundPath}) {
    switch (playgroundPath) {
      case "/hash":
        return "assets/playground/hash";
      case "/difficulty":
        return "assets/playground/difficulty";
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

class StoryUtils {
  static Future<String> imageToBase64(File file) async {
    final bytes = await file.readAsBytes();
    String img64 = base64Encode(bytes);
    return img64;
  }

  static Future<List<String>> imagesToBase64(List<File> files) async {
    List<String> results = [];
    for (var file in files) {
      var result = await StoryUtils.imageToBase64(file);
      results.add(result);
    }
    return results;
  }
}
