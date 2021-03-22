import 'package:flutter/material.dart';
import 'package:flutter_quill/widgets/controller.dart';
import 'package:flutter_quill/widgets/default_styles.dart';
import 'package:flutter_quill/widgets/editor.dart';
import 'package:flutter_quill/widgets/toolbar.dart';

import 'RenameDialog.dart';

class AddStoryPage extends StatefulWidget {
  @override
  _AddStoryPageState createState() => _AddStoryPageState();
}

class _AddStoryPageState extends State<AddStoryPage> {
  String? title;
  QuillController _controller = QuillController.basic();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Spacer(),
            InkWell(
              onTap: () async {
                var text = await showDialog<String?>(
                  context: context,
                  builder: (c) => RenameDialog(
                    initName: title ?? "",
                  ),
                );
                if (text != null) {
                  setState(() {
                    title = text.length > 0 ? text : null;
                  });
                }
              },
              child: Row(
                children: [
                  Text("$title "),
                  Icon(Icons.edit),
                ],
              ),
            ),
            Spacer(),
          ],
        ),
      ),
      body: Column(
        children: [
          QuillToolbar.basic(controller: _controller),
          Expanded(
            child: Container(
              child: QuillEditor.basic(
                controller: _controller,
                readOnly: false, // true for view only mode
              ),
            ),
          )
        ],
      ),
    );
  }
}
