import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:learn_blockchain/data/data.dart';
import 'package:learn_blockchain/model/DocumentData.dart';
import 'package:learn_blockchain/model/PageProvider.dart';
import 'package:learn_blockchain/pages/documents/DocumentView.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Lesson> lessons = [];

  @override
  void initState() {
    super.initState();

    lessons = documentDataList.map((e) => Lesson.fromJSON(e)).toList();
  }

  void pushToLesson(Lesson lesson) {
    PageProvider provider = Provider.of(context, listen: false);
    provider.title = lesson.title;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (c) => DocumentView(
          quizPath: lesson.quizPath,
          documentData: lesson.documentData,
          playgroundPath: lesson.playgroundPath,
          title: lesson.title,
          description: lesson.description,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Learn BlockChain"),
          elevation: 0,
        ),
        body: Scrollbar(
          child: ListView.separated(
            itemCount: lessons.length + 1,
            separatorBuilder: (c, i) => i > 1 ? Divider() : Container(),
            itemBuilder: (context, index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: CarouselSlider.builder(
                    itemCount: min(3, lessons.length),
                    itemBuilder: (context, index, _) {
                      var lesson = lessons[index];
                      return Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              pushToLesson(lesson);
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                lesson.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 10,
                            child: Text(
                              lesson.title,
                              style: TextStyle(
                                color: Colors.white,
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(1.0, 1.0),
                                    blurRadius: 1.0,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      );
                    },
                    options: CarouselOptions(
                      height: 190,
                      aspectRatio: 2.0,
                    ),
                  ),
                );
              } else {
                var lesson = lessons[index - 1];
                return ListTile(
                  onTap: () {
                    pushToLesson(lesson);
                  },
                  title: Text(lesson.title),
                  subtitle: Text(""),
                  leading: Image.asset(lesson.image),
                );
              }
            },
          ),
        ));
  }
}
