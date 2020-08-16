import 'package:flutter/material.dart';

class FontsDemo extends StatelessWidget {
  static const String routeName = './fonts';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Fonts"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  new Text(
                    "Rock Salt",
                  ),
                  new Text(
                    "测试文字11Do one thing at a time, and do well",
                    style: TextStyle(fontFamily: "Rock Salt", fontSize: 17),
                  )
                ],
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  new Text("VT323"),
                  new Text(
                    "You 你好啊cannot improve your past, but you can improve your future. Once time is wasted, life is wasted.",
                    style: TextStyle(fontSize: 25, fontFamily: "VT323"),
                  )
                ],
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  new Text("Ewert"),
                  new Text(
                    "You cannot improve your past, but you can improve your future. Once time is wasted, life is wasted.",
                    style: TextStyle(fontSize: 25, fontFamily: "Ewert"),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
