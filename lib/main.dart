import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

void main() => runApp(new FlutterView());

class FlutterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter View',
      theme: new ThemeData(primarySwatch: Colors.green),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const String _channel = 'increment';
  static const String _pong = 'pong';
  static const String _emptyMessage = '';
  static const BasicMessageChannel<String> platform =
      BasicMessageChannel<String>(_channel, StringCodec());
  int _counter = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    platform.setMockMessageHandler(_handlePlatformIncrement);
  }

  Future<String> _handlePlatformIncrement(String message) async {
    setState(() {
      _counter++;
    });
    return _emptyMessage;
  }

  void _sendFlutterIncrement() {
    platform.send(_pong);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Expanded(
              child: new Center(
            child: new Text(
                'Platform button tapped $_counter time ${_counter == 1 ? '' : 's'}.'),
          )),
          new Container(
            padding: const EdgeInsets.only(bottom: 15.0, left: 5.0),
            child: new Row(
              children: <Widget>[
//                assets文件在yaml中指明
                new Image.asset('assets/flutter-mark-square-64.png',
                    scale: 1.5),
                const Text(
                  'Flutter',
                  style: TextStyle(fontSize: 30.0),
                )
              ],
            ),
          )
        ],
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _sendFlutterIncrement,
        child: const Icon(Icons.add),
      ),
    );
  }
}
