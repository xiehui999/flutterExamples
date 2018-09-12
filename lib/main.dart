import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter_app/home_bottom_navigation.dart';
import 'package:flutter_app/cupertino/cupertino_navigation.dart';
void main() => runApp(new FlutterView());

class FlutterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter View',
      theme: new ThemeData(primarySwatch: Colors.green),
      home: new SplashPage(),
    );
  }
}

class SplashPage extends StatefulWidget {
  @override
  SplashPageState createState() => new SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  static const String _channel = 'increment';
  static const String _pong = 'pong';
  static const String _emptyMessage = '';
  static const BasicMessageChannel<String> platform =
      BasicMessageChannel<String>(_channel, StringCodec());
  int _counter = 0;
  Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = new Timer(new Duration(milliseconds: 1500), () {
      Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (context) => new CupertinoNavigation()
//      Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (context) => new HomeTab()
      ), (route) => route == null);
    });
  }
  

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Color(0xffffffff),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Flutter Demo',
            style: TextStyle(
                color: Color(0xff70C2F0),
                fontWeight: FontWeight.bold,
                fontSize: 26.0),
          ),
          new Padding(padding: EdgeInsets.only(top: 30.0)),
          new Image.asset(
            'assets/flutter-mark-square-64.png',
          )
        ],
      ),
    );
  }
}
