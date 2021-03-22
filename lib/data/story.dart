// To parse this JSON data, do
//
//     final story = storyFromJson(jsonString);

import 'dart:convert';

Story storyFromJson(String str) => Story.fromJson(json.decode(str));

String storyToJson(Story data) => json.encode(data.toJson());

class Story {
  Story({
    required this.title,
    required this.content,
    required this.time,
  });

  String title;
  String content;
  DateTime time;

  factory Story.fromJson(Map<String, dynamic> json) => Story(
        title: json["title"],
        content: json["content"],
        time: DateTime.parse(json["time"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "content": content,
        "time": time.toIso8601String(),
      };
}
