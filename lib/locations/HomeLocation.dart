// ignore: import_of_legacy_library_into_null_safe
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:learn_blockchain/pages/home/HomePage.dart';

class HomeLocation extends BeamLocation {
  @override
  List<BeamPage> pagesBuilder(BuildContext context) {
    return [
      BeamPage(
        key: HomePage.valueKey,
        child: HomePage(),
      )
    ];
  }

  @override
  List<String> get pathBlueprints => [HomePage.pathBlueprint];
}
