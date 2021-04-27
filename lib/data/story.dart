// To parse this JSON data, do
//
//     final story = storyFromJson(jsonString);

import 'dart:convert';

Story storyFromJson(String str) => Story.fromJson(json.decode(str));

String storyToJson(Story data) => json.encode(data.toJson());

class Story {
  static final supportedTypes = ["text", "poll", "miniapp"];

  Story({
    required this.title,
    required this.content,
    required this.time,
    required this.type,
    required this.images,
  });

  String title;
  String content;
  DateTime time;

  /// Story Type
  /// text
  /// poll
  /// miniapp
  String type;
  List<String> images;

  factory Story.fromJson(Map<String, dynamic> json) => Story(
        title: json["title"],
        content: json["content"],
        time: DateTime.parse(json["time"]),
        type: json["type"] ?? "text",
        images: [],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "content": content,
        "time": time.toIso8601String(),
        "type": type,
        // "images": images,
      };
}
