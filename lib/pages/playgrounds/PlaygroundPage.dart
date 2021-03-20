import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:learn_blockchain/model/utils.dart';
import 'package:learn_blockchain/pages/playgrounds/TakeQuizButton.dart';
import 'package:path/path.dart' as p;

class PlaygroundPage extends StatefulWidget {
  static const valueKey = ValueKey("playground");
  static const pathBlueprint = "/playground";

  final String playgroundPath;
  final String quizPath;

  const PlaygroundPage({
    Key? key,
    required this.playgroundPath,
    required this.quizPath,
  }) : super(key: key);

  @override
  _PlaygroundPageState createState() => _PlaygroundPageState();
}

class _PlaygroundPageState extends State<PlaygroundPage> {
  List<String>? descriptions;

  @override
  void initState() {
    super.initState();

    EasyLoading.show();
    var number = PlaygroundUtils.getNumberOfDescriptions(
        playgroundPath: widget.playgroundPath);
    var path =
        PlaygroundUtils.getFilePath(playgroundPath: widget.playgroundPath);

    PlaygroundUtils.loadMarkdowns(number, path).then((value) async {
      setState(() {
        descriptions = value;
      });
      await Future.delayed(Duration(milliseconds: 200));
      EasyLoading.dismiss();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          PlaygroundUtils.getTitle(widget.playgroundPath),
        ),
        actions: [
          TakeQuizButton(
            quizPath: widget.quizPath,
          ),
        ],
      ),
      body: Builder(
        builder: (c) {
          if (descriptions == null) {
            return Container();
          } else {
            return Scrollbar(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: PlaygroundUtils.getWidget(
                  playgroundPath: widget.playgroundPath,
                  descriptions: descriptions!,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
