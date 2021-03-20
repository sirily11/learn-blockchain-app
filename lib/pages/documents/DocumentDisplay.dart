import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:learn_blockchain/locations/DocumentLocation.dart';
import 'package:learn_blockchain/locations/PlaygroundLocation.dart';
import 'package:learn_blockchain/model/DocumentData.dart';
import 'package:learn_blockchain/model/PageProvider.dart';
import 'package:learn_blockchain/model/utils.dart';
import 'package:learn_blockchain/pages/playgrounds/PlaygroundPage.dart';
import 'package:learn_blockchain/pages/quizzes/DoQuizPage.dart';
import 'package:native_pdf_view/native_pdf_view.dart';
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
  final String type;
  final String source;

  DocumentDisplay({
    required this.documentData,
    required this.isLastPage,
    required this.isFirstPage,
    required this.quizPath,
    required this.playgroundPath,
    required this.type,
    required this.source,
  });

  @override
  _DocumentDisplayState createState() => _DocumentDisplayState();
}

class _DocumentDisplayState extends State<DocumentDisplay> {
  final ScrollController scrollController = ScrollController();
  String? markdown;
  PdfController? pdfController;
  double scrollPercentage = 0;

  @override
  void initState() {
    super.initState();
    PageProvider pageProvider = Provider.of(context, listen: false);
    if (widget.type == "md")
      scrollController.addListener(() {
        // pageProvider.title = widget.documentData.title;
        var percentage = scrollController.position.pixels /
            scrollController.position.maxScrollExtent;
        setState(() {
          scrollPercentage = percentage;
        });
      });

    EasyLoading.show();

    if (widget.type == "md") {
      Utils.loadMarkdown(widget.documentData.path).then((value) async {
        setState(() {
          markdown = value;
        });
        await Future.delayed(Duration(milliseconds: 500));
        EasyLoading.dismiss();
      });
    } else if (widget.type == "pdf") {
      Utils.loadPdfFromNetwork(widget.documentData.path).then((value) async {
        if (value != null) {
          setState(() {
            pdfController = value;
          });
        } else {
          await EasyLoading.showError("Cannot load PDF");
        }
        EasyLoading.dismiss();
      });
    }
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
                child: _buildContent(pageProvider),
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

  /// Build display content based on the file type
  Widget _buildContent(PageProvider pageProvider) {
    if (widget.type == "pdf") {
      if (pdfController != null) {
        return Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: PdfView(
                pageLoader: CupertinoActivityIndicator(),
                onDocumentLoaded: (d) {
                  pageProvider.title =
                      widget.documentData.title + "(0/${d.pagesCount})";
                  setState(() {
                    scrollPercentage = 0;
                  });
                },
                onPageChanged: (v) {
                  pageProvider.title = widget.documentData.title +
                      "($v/${pdfController!.pagesCount})";
                  setState(() {
                    scrollPercentage = v / pdfController!.pagesCount;
                  });
                },
                controller: pdfController!,
                scrollDirection: Axis.vertical,
              ),
            ),
            Positioned(
              bottom: 10,
              width: 400,
              height: 300,
              right: 0,
              child: buildControls(pageProvider),
            ),
          ],
        );
      }
    } else if (widget.type == "md") {
      return Column(
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
      );
    }
    return Container();
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
        if (widget.isLastPage &&
            widget.playgroundPath == null &&
            widget.quizPath != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                // context.beamToNamed(
                //     "/documents/${Beamer.of(context).currentLocation.pathParameters["documentId"]}/playground");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (c) => DoQuizPage(
                      quizPath: widget.quizPath!,
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Take Quiz"),
              ),
            ),
          ),
      ]),
    );
  }
}
