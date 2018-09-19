import 'package:flutter/material.dart';

class ElevationDemo extends StatefulWidget {
  static const String routeName = '/material/elevation';

  @override
  State<StatefulWidget> createState() {
    return ElevationState();
  }
}

class ElevationState extends State<ElevationDemo> {
  bool showElevation = true;

  List<Widget> buildCards() {
    const List<double> elevations = <double>[
      0.0,
      3.0,
      5.0,
      8.0,
      15.0,
      20.0,
      25.0
    ];
    return elevations.map((double elevation) {
      return Center(
        child: Card(
          margin: EdgeInsets.all(20.0),
          elevation: showElevation ? elevation : 0.0,
          child: SizedBox(
            height: 100.0,
            width: 100.0,
            child: Text('${elevation.toStringAsFixed(0)}pt'),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Elevation'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.sentiment_very_dissatisfied),
              onPressed: () {
                setState(() {
                  showElevation = !showElevation;
                });
              })
        ],
      ),
      body: ListView(
        children: buildCards(),
      ),
    );
  }
}
