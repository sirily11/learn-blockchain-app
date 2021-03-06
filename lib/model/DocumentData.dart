class DocumentData {
  /// Internet or assets
  final String source;

  /// pdf or md
  final String type;
  final String path;
  final String title;

  DocumentData(
      {required this.path,
      required this.title,
      required this.source,
      required this.type});

  factory DocumentData.fromJSON(Map<String, dynamic> json) => DocumentData(
      path: json['path'],
      title: json['title'],
      type: json['type'],
      source: json['source']);
}

class Lesson {
  final String title;
  final String description;
  final String image;
  final String? playgroundPath;
  final String? quizPath;
  final List<DocumentData> documentData;

  Lesson({
    required this.title,
    required this.description,
    required this.image,
    required this.documentData,
    this.playgroundPath,
    this.quizPath,
  });

  factory Lesson.fromJSON(Map<String, dynamic> json) => Lesson(
        playgroundPath: json['playgroundPath'],
        quizPath: json['quizPath'],
        title: json['title'],
        description: json['description'],
        documentData: (json['documentData'] as List)
            .map((e) => DocumentData.fromJSON(e))
            .toList(),
        image: json['image'],
      );
}
