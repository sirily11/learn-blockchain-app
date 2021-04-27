import 'package:flutter/material.dart';
import 'package:learn_blockchain/data/story.dart';
import 'package:learn_blockchain/model/StoryProvider.dart';
import 'package:learn_blockchain/pages/story/mini-app/MiniAppBar.dart';
import 'package:learn_blockchain/pages/story/mini-app/SpendTokenDialog.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MiniApp extends StatefulWidget {
  final Story story;

  MiniApp({required this.story});

  @override
  _MiniAppState createState() => _MiniAppState();
}

class _MiniAppState extends State<MiniApp> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MiniAppBar(
        title: widget.story.title,
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: widget.story.content,
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (c) {
              setState(() {
                isLoading = false;
              });
            },
            javascriptChannels: [
              JavascriptChannel(
                  name: "spend",
                  onMessageReceived: (message) async {
                    double? amount = double.tryParse(message.message);

                    if (amount != null) {
                      var localAuth = LocalAuthentication();
                      bool didAuthenticate = await localAuth.authenticate(
                        localizedReason: 'Please authenticate to spend',
                        biometricOnly: true,
                      );
                      if (didAuthenticate) {
                        showModalBottomSheet(
                          context: context,
                          enableDrag: false,
                          barrierColor: Colors.transparent,
                          builder: (c) => SpendTokenDialog(
                            mint: false,
                            amout: amount,
                          ),
                        );
                      }
                    }
                  }),
              JavascriptChannel(
                  name: "mint",
                  onMessageReceived: (message) async {
                    double? amount = double.tryParse(message.message);

                    if (amount != null) {
                      StoryProvider provider =
                          Provider.of(context, listen: false);
                      var account = await provider.getAccount();
                      if (account.privateKey == null) {
                        return;
                      }
                      await provider.mint(account.privateKey!, amount.toInt());
                      var balence =
                          await provider.getAccountBalence(account.privateKey!);
                      showModalBottomSheet(
                        context: context,
                        enableDrag: false,
                        barrierColor: Colors.transparent,
                        builder: (c) => SpendTokenDialog(
                          mint: true,
                          amout: amount,
                          balence: balence,
                        ),
                      );
                    }
                  }),
            ].toSet(),
          ),
          if (isLoading)
            Center(
              child: CircularProgressIndicator(),
            )
        ],
      ),
    );
  }
}
