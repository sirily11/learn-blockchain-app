import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:learn_blockchain/model/DocumentData.dart';
import 'package:learn_blockchain/model/PageProvider.dart';
import 'package:learn_blockchain/pages/documents/DocumentDisplay.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

class DocumentView extends StatefulWidget {
  final String title;
  final String description;
  final List<DocumentData> documentData;
  final String quizPath;
  final String playgroundPath;

  DocumentView({
    @required this.documentData,
    @required this.playgroundPath,
    @required this.title,
    @required this.description,
    @required this.quizPath,
  });

  @override
  _DocumentViewState createState() => _DocumentViewState();
}

class _DocumentViewState extends State<DocumentView> {
  

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
                      widget.title,
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
                      widget.description,
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
            for (var document in widget.documentData)
              DocumentDisplay(
                playgroundPath: widget.playgroundPath,
                quizPath: widget.quizPath,
                documentData: document,
                isFirstPage: widget.documentData.indexOf(document) == 0,
                isLastPage: widget.documentData.indexOf(document) ==
                    widget.documentData.length - 1,
              )
          ],
        ));
  }
}
