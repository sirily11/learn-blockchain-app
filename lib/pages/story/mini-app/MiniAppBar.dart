import 'package:flutter/material.dart';

class MiniAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;

  MiniAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    var appbar = AppBar(
      title: Text(title),
      leading: Container(),
      elevation: 0,
    );

    return Stack(children: [
      appbar,
      Positioned(
        right: 20,
        bottom: 20,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Container(
            height: 30,
            width: 80,
            color: Colors.white.withOpacity(0.7),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.more_horiz),
                  VerticalDivider(),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.close),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  @override
  Size get preferredSize {
    return AppBar(
      title: Text(title),
      leading: Container(),
    ).preferredSize;
  }
}
