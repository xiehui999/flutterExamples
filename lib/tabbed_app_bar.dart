import 'package:flutter/material.dart';

class TabbedAppBarSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new DefaultTabController(
          length: choices.length,
          child: new Scaffold(
              appBar: new AppBar(
                  title: const Text("Tabbed APPbar"),
                  bottom: new TabBar(
                      isScrollable: true,
                      tabs: choices.map((choice) {
                        return new Tab(
                          text: choice.title,
                          icon: new Icon(choice.icon),
                        );
                      }).toList())),
              body: new TabBarView(
                  children: choices.map((Choice choice) {
                return new Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: new ChoiceCard(
                    choice: choice,
                  ),
                );
              }).toList()))),
    );
  }
}

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);
  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
//crossAxisAlignment交叉轴的对齐方式，交叉轴是主轴的垂直方向
    return new Card(
      color: Colors.white,
      child: new Center(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Icon(choice.icon, size: 128.0),
            new Text(choice.title, style: textStyle)
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
  Choice(title: "Car", icon: Icons.directions_car),
  Choice(title: 'Bicycle', icon: Icons.directions_bike),
  Choice(title: 'BOAT', icon: Icons.directions_boat),
  Choice(title: 'BUS', icon: Icons.directions_bus),
  Choice(title: 'Train', icon: Icons.directions_railway),
  Choice(title: 'Walk', icon: Icons.directions_walk)
];

void main() {
  runApp(new TabbedAppBarSample());
}
