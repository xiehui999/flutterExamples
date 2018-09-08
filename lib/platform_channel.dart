import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class PlatformChannel extends StatefulWidget {
  @override
  _PlatformChannelState createState() {
    return new _PlatformChannelState();
  }
}

class _PlatformChannelState extends State<PlatformChannel> {
  static const MethodChannel methodChannel =
      MethodChannel('samples.flutter.io/battery');

  static const EventChannel eventChannel =
      EventChannel('samples.flutter.io/charging');
  String _batteryLevel = 'Battery level: unknown.';
  String _chargingStatus = 'Battery status: unknown.';

  Future<Null> _getBatterLevel() async {
    String batteryLevel;
    try {
      final int result = await methodChannel.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level: $result';
    } on PlatformException {
      batteryLevel = 'Failed to get battery level';
    }
    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    eventChannel.receiveBroadcastStream().listen(_onEvent, onError: _onError);
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(_batteryLevel, key: const Key('Battery level label')),
              new Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: new RaisedButton(
                    onPressed: _getBatterLevel,
                    child: new Text('Refresh'),
                  ))
            ],
          ),
          new Text(_chargingStatus)
        ],
      ),
    );
  }

  void _onEvent(event) {
    setState(() {
      _chargingStatus =
          "Battery status :${event == 'Charging' ? "Charging" : 'discharging'} ";
    });
  }

  void _onError(event) {
    setState(() {
      _chargingStatus = 'Battery status: unknown.';
    });
  }
}

void main() {
  runApp(new MaterialApp(
    home: new PlatformChannel(),
  ));
}
