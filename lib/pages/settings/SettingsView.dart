import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:learn_blockchain/model/StoryProvider.dart';
import 'package:provider/provider.dart';

import 'AccountAddressDialog.dart';

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  String? account;
  String? privateKey;
  double balence = 0;

  @override
  void initState() {
    super.initState();
    fetch();
  }

  fetch() async {
    StoryProvider provider = Provider.of(context, listen: false);
    EasyLoading.show();
    provider.getAccount().then((value) async {
      setState(() {
        account = value.address;
        privateKey = value.privateKey;
      });
      var balence = await provider.getAccountBalence(value.privateKey);
      setState(() {
        this.balence = balence;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    StoryProvider provider = Provider.of(context);
    return EasyRefresh(
      onRefresh: () => fetch(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          ListTile(
            onTap: () async {
              var newAddress = await showDialog<AddressData?>(
                context: context,
                builder: (c) => AccountAddressDialog(
                  address: account ?? "",
                  privateAddress: privateKey ?? "",
                ),
              );

              if (newAddress != null) {
                await provider.updateAccount(
                    newAddress.address!, newAddress.privateKey!);
                setState(() {
                  account = newAddress.address;
                  privateKey = newAddress.privateKey;
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
          ),
        ]),
      ),
    );
  }
}
