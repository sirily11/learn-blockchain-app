import 'package:flutter/material.dart';

class RenameDialog extends StatefulWidget {
  final String initName;

  const RenameDialog({Key? key, required this.initName}) : super(key: key);
  @override
  _RenameDialogState createState() => _RenameDialogState();
}

class _RenameDialogState extends State<RenameDialog> {
  late TextEditingController textEditingController;
  @override
  void initState() {
    textEditingController = TextEditingController(text: widget.initName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Rename"),
      content: Container(
        width: MediaQuery.of(context).size.width,
        child: TextField(
          controller: textEditingController,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("cancel"),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, textEditingController.text),
          child: Text("ok"),
        )
      ],
    );
  }
}
