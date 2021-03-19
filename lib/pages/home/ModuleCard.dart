import 'package:flutter/material.dart';
import 'package:learn_blockchain/pages/documents/DocumentView.dart';

class ModuleCard extends StatelessWidget {
  final List<DocumentData> documentData;
  final String title;
  final String description;
  final String quizPath;
  final String playgroundPath;

  const ModuleCard({
    Key key,
    @required this.documentData,
    @required this.title,
    @required this.description,
    @required this.quizPath,
    @required this.playgroundPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (c) => DocumentView(
                quizPath: quizPath,
                documentData: documentData,
                playgroundPath: playgroundPath,
                title: title,
                description: description,
              ),
            ),
          );
        },
        child: Card(
          child: Container(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "$title",
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
