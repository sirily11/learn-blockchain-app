import 'package:flutter/material.dart';
import 'package:learn_blockchain/data/story.dart';
import 'package:learn_blockchain/pages/story/mini-app/MiniApp.dart';

class StoryCard extends StatelessWidget {
  final Story story;
  StoryCard({required this.story});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (story.type == "text")
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    "https://cdn.mos.cms.futurecdn.net/ntFmJUZ8tw3ULD3tkBaAtf.jpg",
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            if (story.type == "text") buildTextContent(),
            if (story.type == "miniapp") buildMiniApp(context),
            Divider(),
          ],
        ),
      ),
    );
  }

  Widget buildMiniApp(context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (c) => MiniApp(
                  story: story,
                ),
              ),
            );
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 40,
            child: Center(
              child: Text("App: ${story.title}"),
            ),
          ),
        ),
      ),
    );
  }

  Column buildTextContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${story.title}",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text("${story.content}"),
      ],
    );
  }
}
