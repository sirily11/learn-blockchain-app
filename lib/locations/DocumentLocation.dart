import 'package:beamer/beamer.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:learn_blockchain/data/data.dart';
import 'package:learn_blockchain/locations/HomeLocation.dart';
import 'package:learn_blockchain/model/DocumentData.dart';
import 'package:learn_blockchain/pages/documents/DocumentPage.dart';
import 'package:learn_blockchain/pages/playgrounds/PlaygroundPage.dart';
import 'package:learn_blockchain/pages/quizzes/DoQuizPage.dart';
import 'package:learn_blockchain/pages/quizzes/FinishFailPage.dart';
import 'package:learn_blockchain/pages/quizzes/FinishSuccessfulPage.dart';
import 'package:path/path.dart' as p;

class DocumentLocation extends BeamLocation {
  DocumentLocation(
      {String? pathBlueprint,
      Map<String, String>? pathParameters,
      Map<String, String>? queryParameters})
      : super(
          pathParameters: pathParameters,
          pathBlueprint: pathBlueprint,
          queryParameters: queryParameters,
        );

  @override
  List<BeamPage> pagesBuilder(BuildContext context) {
    var documentId = int.tryParse(pathParameters['documentId'] ?? "");
    print(Beamer.of(context).beamHistory);

    Lesson? lesson;
    if (documentId != null) {
      lesson = documents[documentId];
    }

    return [
      ...HomeLocation().pagesBuilder(context),
      if (pathSegments.contains("documents"))
        if (lesson != null)
          BeamPage(
            key: DocumentPage.valueKey,
            child: DocumentPage(
              lesson: lesson,
            ),
          ),
      if (pathSegments.contains("playground") && lesson != null)
        BeamPage(
          key: PlaygroundPage.valueKey,
          child: PlaygroundPage(
            playgroundPath: lesson.playgroundPath!,
            quizPath: lesson.quizPath!,
          ),
        ),
      if (pathSegments.contains("quiz") && lesson != null)
        BeamPage(
          key: DoQuizPage.valueKey,
          child: DoQuizPage(
            quizPath: lesson.quizPath!,
          ),
        ),
      if (pathSegments.contains("success"))
        BeamPage(
          key: FinishSuccessfulPage.valueKey,
          child: FinishSuccessfulPage(),
        ),
      if (pathSegments.contains("fail"))
        BeamPage(
          key: FinishFailPage.valueKey,
          child: FinishFailPage(),
        )
    ];
  }

  @override
  List<String> get pathBlueprints => [
        "/documents/:documentId",
        "/documents/:documentId/playground",
        "/documents/:documentId/playground/quiz"
      ];
}
