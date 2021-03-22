import 'package:flutter/material.dart';

class AccountAddressDialog extends StatefulWidget {
  final String address;

  const AccountAddressDialog({Key? key, required this.address})
      : super(key: key);

  @override
  _AccountAddressDialogState createState() => _AccountAddressDialogState();
}

class _AccountAddressDialogState extends State<AccountAddressDialog> {
  late final TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController(text: widget.address);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Account Address"),
      content: Container(
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          controller: textEditingController,
          decoration: InputDecoration(labelText: "Account Address"),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel"),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, textEditingController.text),
          child: Text("Ok"),
        ),
      ],
    );
  }
}
