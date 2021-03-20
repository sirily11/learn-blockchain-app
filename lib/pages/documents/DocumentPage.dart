import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:learn_blockchain/data/data.dart';
import 'package:learn_blockchain/model/DocumentData.dart';
import 'package:learn_blockchain/model/PageProvider.dart';
import 'package:learn_blockchain/pages/documents/DocumentDisplay.dart';
import 'package:provider/provider.dart';

class DocumentPage extends StatefulWidget {
  static const valueKey = ValueKey("documentPage");
  static const pageBlueprint = "/documents/:documentId";
  static const pageString = "/documents/";

  final Lesson lesson;

  DocumentPage({required this.lesson});

  @override
  _DocumentPageState createState() => _DocumentPageState();
}

class _DocumentPageState extends State<DocumentPage> {
  @override
  void dispose() {
    EasyLoading.dismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PageProvider pageProvider = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(pageProvider.title),
      ),
      body: PageView(
        controller: pageProvider.pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: ColorizeAnimatedTextKit(
                  text: [
                    widget.lesson.title,
                  ],
                  textStyle: TextStyle(fontSize: 50.0, fontFamily: "Horizon"),
                  textAlign: TextAlign.center,
                  colors: [
                    Colors.purple,
                    Colors.blue,
                  ],
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.lesson.description,
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              IconButton(
                iconSize: 50,
                color: Colors.blue,
                onPressed: () {
                  pageProvider.nextPage();
                },
                icon: Icon(Icons.arrow_right),
              ),
            ],
          ),
          for (var document in widget.lesson.documentData)
            DocumentDisplay(
              playgroundPath: widget.lesson.playgroundPath,
              quizPath: widget.lesson.quizPath,
              documentData: document,
              isFirstPage: widget.lesson.documentData.indexOf(document) == 0,
              isLastPage: widget.lesson.documentData.indexOf(document) ==
                  widget.lesson.documentData.length - 1,
              source: document.source,
              type: document.type,
            )
        ],
      ),
    );
  }
}
