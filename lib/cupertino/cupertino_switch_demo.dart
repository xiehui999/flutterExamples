import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../demo.dart';

class CupertinoSwitchDemo extends StatefulWidget {
  static const String routeName = '/coupertino/switch';

  @override
  State<StatefulWidget> createState() {
    return CupertinoSwitchDemoState();
  }
}

class CupertinoSwitchDemoState extends State<CupertinoSwitchDemo> {
  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cupertino Switch'),
        actions: <Widget>[
          MaterialDemoDocumentationButton(CupertinoSwitchDemo.routeName)
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Semantics(
              container: true,
              child: Column(
                children: <Widget>[
                  CupertinoSwitch(
                      value: _switchValue,
                      onChanged: (bool value) {
                        setState(() {
                          _switchValue = value;
                        });
                      }),
                  Text('Active'),
                ],
              ),
            ),
            Semantics(
              container: true,
              child: Column(
                children: <Widget>[
                  CupertinoSwitch(
                      value: _switchValue,
                      activeColor: Colors.redAccent,
                      onChanged: (bool value) {
                        setState(() {
                          _switchValue = value;
                        });
                      }),
                  Text('Active:activeColor'),
                ],
              ),
            ),
            Semantics(
              container: true,
              child: Column(
                children: <Widget>[
                  CupertinoSwitch(
                    value: true,
                    onChanged: null,
                  ),
                  Text('Disabled')
                ],
              ),
            ),
            Semantics(
              container: true,
              child: Column(
                children: const <Widget>[
                  CupertinoSwitch(
                    value: false,
                    onChanged: null,
                  ),
                  Text(
                      'Disabled'
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
