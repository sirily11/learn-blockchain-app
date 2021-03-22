// ignore: import_of_legacy_library_into_null_safe
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:learn_blockchain/locations/DocumentLocation.dart';
import 'package:learn_blockchain/pages/playgrounds/PlaygroundPage.dart';

class PlaygroundLocation extends BeamLocation {
  PlaygroundLocation({Map<String, String>? queryParameters})
      : super(queryParameters: queryParameters);

  @override
  List<BeamPage> pagesBuilder(BuildContext context) {
    var playgroundPath = queryParameters['playgroundPath'];
    var quizPath = queryParameters['quizPath'];

    return [
      ...DocumentLocation().pagesBuilder(context),
      if (playgroundPath != null && quizPath != null)
        BeamPage(
          key: PlaygroundPage.valueKey,
          child: PlaygroundPage(
            playgroundPath: playgroundPath,
            quizPath: quizPath,
          ),
        )
    ];
  }

  @override
  List<String> get pathBlueprints => [PlaygroundPage.pathBlueprint];
}
