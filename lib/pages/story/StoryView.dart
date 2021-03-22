import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:learn_blockchain/data/story.dart';
import 'package:learn_blockchain/model/UserProvider.dart';
import 'package:provider/provider.dart';

class StoryView extends StatefulWidget {
  @override
  _StoryViewState createState() => _StoryViewState();
}

class _StoryViewState extends State<StoryView> {
  List<Story> stories = [];
  int totalSize = 0;
  int start = 0;
  int perPage = 10;

  getStories(bool refresh) async {
    UserProvider userProvider = Provider.of(context, listen: false);
    var size = await userProvider.getStorySize();
    var stories = await userProvider.getStories(start, start + perPage);
    if (stories != null && size != null) {
      if (refresh) {
        setState(() {
          this.stories = stories;
          totalSize = size;
        });
      } else {
        this.stories.addAll(stories);
        setState(() {
          this.stories = this.stories;
          totalSize = size;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      firstRefresh: true,
      onRefresh: () async {
        start = 0;
        await getStories(true);
      },
      onLoad: start + perPage < totalSize
          ? () async {
              start = start + perPage;
              await getStories(false);
            }
          : null,
      child: ListView.separated(
        separatorBuilder: (c, i) => Divider(),
        itemCount: stories.length,
        itemBuilder: (c, index) {
          var story = stories[index];
          return ExpansionTile(
            title: Text("${story.title}"),
            subtitle: Text("${story.time}"),
            expandedAlignment: Alignment.topLeft,
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            childrenPadding: EdgeInsets.all(10),
            children: [
              Text(
                "Content:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${story.content}",
                textAlign: TextAlign.start,
              ),
            ],
          );
        },
      ),
    );
  }
}
