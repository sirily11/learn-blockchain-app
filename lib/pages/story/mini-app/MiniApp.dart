import 'package:flutter/material.dart';
import 'package:learn_blockchain/data/story.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MiniApp extends StatefulWidget {
  final Story story;

  MiniApp({required this.story});

  @override
  _MiniAppState createState() => _MiniAppState();
}

class _MiniAppState extends State<MiniApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.story.title}"),
      ),
      body: WebView(),
    );
  }
}
