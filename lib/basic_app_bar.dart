import 'package:flutter/material.dart';

class BasicAppBarSample extends StatefulWidget {
  @override
  _BasicAppBarSampleState createState() {
    return new _BasicAppBarSampleState();
  }
}

class _BasicAppBarSampleState extends State<BasicAppBarSample> {
  Choice _selectedChoice = choices[0];

  void _select(Choice choice) {
    setState(() {
      _selectedChoice = choice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Basic AppBar'),
          actions: <Widget>[
            new IconButton(
                icon: new Icon(choices[0].icon),
                onPressed: () {
                  _select(choices[0]);
                }),
            new IconButton(
                icon: new Icon(choices[1].icon),
                onPressed: () {
                  _select(choices[1]);
                }),
            new PopupMenuButton<Choice>(itemBuilder: (BuildContext context) {
              return choices.map((Choice choice) {
                return new PopupMenuItem<Choice>(
                  child: new Text(choice.title),
                  value: choice,
                );
              }).toList();
            })
          ],
        ),
      ),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = <Choice>[
  Choice(title: 'Car', icon: Icons.directions_car),
  Choice(title: 'Bicycle', icon: Icons.directions_bike),
  Choice(title: 'Boat', icon: Icons.directions_boat),
  Choice(title: 'Bus', icon: Icons.directions_bus),
  Choice(title: 'Train', icon: Icons.directions_railway),
  Choice(title: 'Walk', icon: Icons.directions_walk)
];

void main() {
  runApp(new BasicAppBarSample());
}
