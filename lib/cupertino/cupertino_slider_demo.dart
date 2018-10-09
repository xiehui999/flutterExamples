import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../demo.dart';

class CupertinoSliderDemo extends StatefulWidget {
  static const String routeName = '/cupertino/slider';

  @override
  State<StatefulWidget> createState() {
    return CupertinoSliderDemoState();
  }
}

class CupertinoSliderDemoState extends State<CupertinoSliderDemo> {
  double _value = 25.0;
  double _discreteValue = 20.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cupertino Sliders'),
        actions: <Widget>[
          MaterialDemoDocumentationButton(CupertinoSliderDemo.routeName)
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CupertinoSlider(
                value: _value,
                min: 0.0,
                max: 100.0,
                onChanged: (double value) {
                  setState(() {
                    _value = value;
                  });
                }),
            Text('Cupertino Continuous: ${_value.toStringAsFixed(1)}'),
            Padding(padding: EdgeInsets.symmetric(vertical: 30.0)),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CupertinoSlider(
                    value: _discreteValue,
                    activeColor:Colors.redAccent,
                    min: 0.0,
                    max: 100.0,
                    divisions: 100,
                    onChanged: (double value) {
                      setState(() {
                        _discreteValue = value;
                      });
                    }),
                Text('Cupertino Discrete: ${_discreteValue.toStringAsFixed(1)}'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
