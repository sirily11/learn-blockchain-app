import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:learn_blockchain/model/UserProvider.dart';
import 'package:provider/provider.dart';

import 'AccountAddressDialog.dart';

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  TextEditingController textEditingController = TextEditingController();
  String? account;
  double balence = 0;

  @override
  void initState() {
    UserProvider provider = Provider.of(context, listen: false);
    EasyLoading.show();
    provider.getAccount().then((value) async {
      setState(() {
        account = value;
      });
      textEditingController.text = value;
      var balence = await provider.getAccountBalence(account);
      setState(() {
        this.balence = balence;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider provider = Provider.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        ListTile(
          onTap: () async {
            var newAddress = await showDialog<String?>(
              context: context,
              builder: (c) => AccountAddressDialog(
                address: account ?? "",
              ),
            );

            if (newAddress != null) {
              await provider.updateAccount(newAddress);
              setState(() {
                account = newAddress;
              });
            }
          },
          title: Text("Account Info"),
          subtitle: Text(
            "${account ?? "null"}",
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Divider(),
        Tooltip(
          message: "Learn Blockchain Coin Balance",
          child: ListTile(
            title: Text("Your balance"),
            subtitle: Text("$balence"),
            trailing: Text("LBCC"),
          ),
        )
      ]),
    );
  }
}
