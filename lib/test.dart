import 'package:flutter/material.dart';

class TestTabBar extends StatefulWidget {
  @override
  TestTabBarState createState() {
    return new TestTabBarState();
  }
}

class TestTabBarState extends State<TestTabBar>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Test'),
        ),
        body: new TabBarView(
          children: [
            new Text('11111'),
            new Text('22222'),
            new Text('33333'),
            new Text('44444'),
          ],
          controller: _tabController,
        ),
        bottomNavigationBar: new TabBar(
          labelColor: Colors.pink,
          indicatorColor: Colors.red,
          unselectedLabelColor: Colors.grey,
          tabs: <Widget>[
            new Tab(
                text: 'Bike',
                icon: new Icon(
                  Icons.directions_bike,
                  color: Colors.pink,
                )),
            new Tab(
                text: 'Boat',
                icon: new Icon(
                  Icons.directions_boat,
                  color: Colors.pink,
                )),
            new Tab(
              text: 'Bus',
              icon: new Icon(
                Icons.directions_bus,
                color: Colors.pink,
              ),
            ),
            new Tab(
              text: 'Walk',
              icon: new Icon(
                Icons.directions_walk,
                color: Colors.pink,
              ),
            ),
          ],
          controller: _tabController,
        ),
      ),
    );
  }
}

//使用DefaultTabController
class TestTabBarState1 extends State<TestTabBar1> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new DefaultTabController(
          length: 4,
          child: new Scaffold(
            appBar: new AppBar(
              title: new Text('顶部title'),
              bottom: new TabBar(tabs: <Widget>[
                new Tab(
                    text: 'Bike',
                    icon: new Icon(
                      Icons.directions_bike,
                      color: Colors.pink,
                    )),
                new Tab(
                    text: 'Boat',
                    icon: new Icon(
                      Icons.directions_boat,
                      color: Colors.pink,
                    )),
                new Tab(
                  text: 'Bus',
                  icon: new Icon(
                    Icons.directions_bus,
                    color: Colors.pink,
                  ),
                ),
                new Tab(
                  text: 'Walk',
                  icon: new Icon(
                    Icons.directions_walk,
                    color: Colors.pink,
                  ),
                ),
              ]),
            ),
            body: new TabBarView(children: <Widget>[
              new Text('11111'),
              new Text('22222'),
              new Text('33333'),
              new Text('44444'),
            ]),
          )),
    );
  }
}

class TestTabBar1 extends StatefulWidget {
  @override
  TestTabBarState1 createState() {
    return new TestTabBarState1();
  }
}

void main() {
  runApp(new TestTabBar1());
}
