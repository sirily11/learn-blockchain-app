import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:learn_blockchain/locations/DocumentLocation.dart';
import 'package:learn_blockchain/locations/PlaygroundLocation.dart';
import 'package:learn_blockchain/model/DocumentData.dart';
import 'package:learn_blockchain/model/PageProvider.dart';
import 'package:learn_blockchain/model/utils.dart';
import 'package:learn_blockchain/pages/playgrounds/PlaygroundPage.dart';
import 'package:provider/provider.dart';
import 'package:beamer/beamer.dart';
import 'package:path/path.dart' as p;

import 'DocumentPage.dart';

class DocumentDisplay extends StatefulWidget {
  final DocumentData documentData;
  final String? playgroundPath;
  final String? quizPath;
  final bool isLastPage;
  final bool isFirstPage;

  DocumentDisplay({
    required this.documentData,
    required this.isLastPage,
    required this.isFirstPage,
    required this.quizPath,
    required this.playgroundPath,
  });

  @override
  _DocumentDisplayState createState() => _DocumentDisplayState();
}

class _DocumentDisplayState extends State<DocumentDisplay> {
  final ScrollController scrollController = ScrollController();
  String? markdown;
  double scrollPercentage = 0;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      var percentage = scrollController.position.pixels /
          scrollController.position.maxScrollExtent;
      setState(() {
        scrollPercentage = percentage;
      });
    });

    PageProvider pageProvider = Provider.of(context, listen: false);

    EasyLoading.show();
    Utils.loadMarkdown(widget.documentData.path).then((value) async {
      pageProvider.title = widget.documentData.title;
      setState(() {
        markdown = value;
      });
      await Future.delayed(Duration(milliseconds: 500));
      EasyLoading.dismiss();
    });
  }

  @override
  Widget build(BuildContext context) {
    PageProvider pageProvider = Provider.of(context);

    return Stack(
      children: [
        Scrollbar(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    if (markdown != null)
                      MarkdownBody(
                        selectable: true,
                        data: markdown ?? "",
                        styleSheet: MarkdownStyleSheet(
                          p: TextStyle(
                            fontSize: 15,
                            height: 2,
                          ),
                        ),
                        imageBuilder: (url, title, alt) => Center(
                          child: Image.network(url.toString()),
                        ),
                      ),
                    buildControls(pageProvider),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          width: MediaQuery.of(context).size.width,
          height: 8,
          left: 0,
          child: LinearProgressIndicator(
            value: scrollPercentage,
            backgroundColor: Colors.green.withOpacity(0.3),
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
          ),
        )
      ],
    );
  }

  Widget buildControls(PageProvider pageProvider) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Row(children: [
        Spacer(),
        if (!widget.isLastPage)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                pageProvider.nextPage();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Next"),
              ),
            ),
          ),
        if (!widget.isFirstPage)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                pageProvider.prevPage();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Prev"),
              ),
            ),
          ),
        if (widget.isLastPage &&
            widget.quizPath != null &&
            widget.playgroundPath != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                // context.beamToNamed(
                //     "/documents/${Beamer.of(context).currentLocation.pathParameters["documentId"]}/playground");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (c) => PlaygroundPage(
                      quizPath: widget.quizPath!,
                      playgroundPath: widget.playgroundPath!,
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Go To Playground"),
              ),
            ),
          ),
      ]),
    );
  }
}
