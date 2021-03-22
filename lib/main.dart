import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:learn_blockchain/model/PageProvider.dart';
import 'package:learn_blockchain/model/StoryProvider.dart';
import 'package:learn_blockchain/model/UserProvider.dart';
import 'package:learn_blockchain/pages/home/HomePage.dart';
import 'package:learn_blockchain/pages/quizzes/FinishFailPage.dart';
import 'package:learn_blockchain/pages/quizzes/FinishSuccessfulPage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (c) => PageProvider(),
        ),
        ChangeNotifierProvider(
          create: (c) => StoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (c) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        routes: {
          '/': (c) => HomePage(),
          "/success": (c) => FinishSuccessfulPage(),
          "/fail": (c) => FinishFailPage(),
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: "/",
        builder: EasyLoading.init(),
      ),
    );
  }
}
