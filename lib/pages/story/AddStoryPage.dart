import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:learn_blockchain/data/story.dart';
import 'package:learn_blockchain/model/UserProvider.dart';
import 'package:provider/provider.dart';

import 'RenameDialog.dart';

class AddStoryPage extends StatefulWidget {
  @override
  _AddStoryPageState createState() => _AddStoryPageState();
}

class _AddStoryPageState extends State<AddStoryPage> {
  String? title;
  TextEditingController textEditingController = TextEditingController();
  double balance = 0;

  @override
  void initState() {
    UserProvider userProvider = Provider.of(context, listen: false);

    userProvider.getAccount().then((value) async {
      var b = await userProvider.getAccountBalence(value.privateKey);
      setState(() {
        balance = b;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of(context);

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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              maxLines: 30,
              controller: textEditingController,
              decoration: InputDecoration(
                labelText: "Story",
                border: OutlineInputBorder(),
              ),
            ),
            ListTile(
              title: Text("Balance"),
              subtitle: Text("$balance"),
              trailing: Text("LBCC"),
            ),
            TextButton(
              onPressed: title == null
                  ? null
                  : () async {
                      if (balance < 10) {
                        await EasyLoading.showError("Balance insufficent");
                        await Future.delayed(Duration(seconds: 2));
                        await EasyLoading.dismiss();
                        return;
                      }

                      var account = await userProvider.getAccount();

                      var story = Story(
                        title: title!,
                        content: textEditingController.text,
                        time: DateTime.now(),
                      );

                      if (account.privateKey != null &&
                          account.address != null) {
                        var success = await userProvider.addStory(
                          account.address!,
                          account.privateKey!,
                          JsonEncoder().convert(
                            story.toJson(),
                          ),
                        );
                        if (success) {
                          Navigator.pop(context);
                        }
                      }
                    },
              child: Text("Submit"),
            )
          ],
        ),
      ),
    );
  }
}
