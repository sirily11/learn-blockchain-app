import 'dart:math';
// ignore: import_of_legacy_library_into_null_safe
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:learn_blockchain/data/data.dart';
import 'package:learn_blockchain/model/DocumentData.dart';
import 'package:learn_blockchain/model/PageProvider.dart';
import 'package:learn_blockchain/pages/documents/DocumentPage.dart';
import 'package:learn_blockchain/pages/settings/SettingsView.dart';
import 'package:learn_blockchain/pages/story/AddStoryPage.dart';
import 'package:learn_blockchain/pages/story/StoryView.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const valueKey = ValueKey("home");
  static const pathBlueprint = "/";

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Lesson> lessons = [];
  int _crrentIndex = 0;

  @override
  void initState() {
    super.initState();

    lessons = documentDataList.map((e) => Lesson.fromJSON(e)).toList();
  }

  void pushToLesson(Lesson lesson, int index) {
    PageProvider provider = Provider.of(context, listen: false);
    provider.title = lesson.title;
    Navigator.push(context,
        MaterialPageRoute(builder: (c) => DocumentPage(lesson: lesson)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _crrentIndex,
        onTap: (number) {
          setState(() {
            _crrentIndex = number;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Story"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings")
        ],
      ),
    );
  }

  AppBar _buildAppbar() {
    switch (_crrentIndex) {
      case 1:
        return AppBar(
          title: Text("Story"),
          actions: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (c) => AddStoryPage(),
                  ),
                );
              },
            ),
          ],
        );

      case 2:
        return AppBar(
          title: Text("Settings"),
        );
      default:
        return AppBar(
          title: Text("Learn BlockChain"),
          elevation: 0,
        );
    }
  }

  Widget _buildBody() {
    switch (_crrentIndex) {
      case 1:
        return StoryView();

      case 2:
        return SettingsView();

      default:
        return Scrollbar(
          child: ListView.separated(
            itemCount: lessons.length + 1,
            separatorBuilder: (c, i) => i > 0 ? Divider() : Container(),
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
                              pushToLesson(lesson, index);
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                lesson.image,
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width * 0.77,
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
                      aspectRatio: 3.0,
                    ),
                  ),
                );
              } else {
                var lesson = lessons[index - 1];
                return ListTile(
                  onTap: () {
                    pushToLesson(lesson, index - 1);
                  },
                  title: Text(lesson.title),
                  subtitle: Text(""),
                  leading: Image.asset(
                    lesson.image,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                );
              }
            },
          ),
        );
    }
  }
}
