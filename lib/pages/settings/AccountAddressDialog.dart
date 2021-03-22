import 'package:flutter/material.dart';

class AddressData {
  final String? address;
  final String? privateKey;

  AddressData({required this.address, required this.privateKey});
}

class AccountAddressDialog extends StatefulWidget {
  final String address;
  final String privateAddress;

  const AccountAddressDialog({
    Key? key,
    required this.address,
    required this.privateAddress,
  }) : super(key: key);

  @override
  _AccountAddressDialogState createState() => _AccountAddressDialogState();
}

class _AccountAddressDialogState extends State<AccountAddressDialog> {
  late final TextEditingController textEditingController;
  late final TextEditingController textEditingController2;

  @override
  void initState() {
    textEditingController = TextEditingController(text: widget.address);
    textEditingController2 = TextEditingController(text: widget.privateAddress);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Account Address"),
      content: Container(
        width: MediaQuery.of(context).size.width,
        height: 200,
        child: Column(
          children: [
            TextFormField(
              controller: textEditingController,
              decoration: InputDecoration(labelText: "Account Address"),
            ),
            TextFormField(
              controller: textEditingController2,
              maxLines: 3,
              decoration: InputDecoration(labelText: "Private Address"),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel"),
        ),
        TextButton(
          onPressed: () => Navigator.pop(
            context,
            AddressData(
              address: textEditingController.text,
              privateKey: textEditingController2.text,
            ),
          ),
          child: Text("Ok"),
        ),
      ],
    );
  }
}
