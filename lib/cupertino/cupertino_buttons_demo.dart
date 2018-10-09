import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../demo.dart';

class CupertinoButtonsDemo extends StatefulWidget {
  static const String routeName = './cupertino/buttons';

  @override
  State<StatefulWidget> createState() {
    return CupertinoButtonsDemoState();
  }
}

class CupertinoButtonsDemoState extends State<CupertinoButtonsDemo> {
  int _pressedCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cupertino Buttons'),
        actions: <Widget>[
          MaterialDemoDocumentationButton(CupertinoButtonsDemo.routeName)
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
                'iOS themed buttons are flat. They can have borders or backgrounds but '
                'only when necessary.'),
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(_pressedCount > 0
                  ? 'Button pressed $_pressedCount time${_pressedCount == 1 ? "" : "s"}'
                  : ' '),
              const Padding(padding: EdgeInsets.all(12.0)),
              Align(
                alignment: Alignment(0.0, -0.2),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CupertinoButton(
                        child: Text('Cupertino Button'),
                        onPressed: () {
                          setState(() {
                            _pressedCount += 1;
                          });
                        }),
                    CupertinoButton(child: Text('Disabled'), onPressed: null)
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.all(12.0)),
              CupertinoButton(
                  child: Text('With Background'),
                  color: CupertinoColors.activeBlue,
                  onPressed: () {
                    setState(() {
                      _pressedCount += 1;
                    });
                  }),
              const Padding(padding: EdgeInsets.all(12.0)),
              const CupertinoButton(
                child: Text('Disabled'),
                color: CupertinoColors.activeBlue,
                onPressed: null,
              ),
            ],
          ))
        ],
      ),
    );
  }
}
