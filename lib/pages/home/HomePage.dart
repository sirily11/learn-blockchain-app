import 'package:flutter/material.dart';
import 'package:learn_blockchain/pages/documents/DocumentView.dart';
import 'package:learn_blockchain/pages/home/ModuleCard.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Learn BlockChain"),
        elevation: 0,
      ),
      body: ListView(
        children: [
          ModuleCard(
            playgroundPath: "/hash",
            quizPath: "assets/quizzes/part1/quiz1.json",
            documentData: [
              DocumentData(
                path: "assets/document/part1/decentralization.md",
                title: "Decentralization",
              ),
              DocumentData(
                path: "assets/document/part1/what_is_block_chain.md",
                title: "Decentralization",
              )
            ],
            title: "Introduction",
            description:
                "In this section, you will learn some basics about block chain tech!",
          )
        ],
      ),
    );
  }
}
