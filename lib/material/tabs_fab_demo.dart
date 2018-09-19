import 'package:flutter/material.dart';

const String _explanatoryText =
    "When the Scaffold's floating action button changes, the new button fades and "
    'turns into view. In this demo, changing tabs can cause the app to be rebuilt '
    'with a FloatingActionButton that the Scaffold distinguishes from the others '
    'by its key.';

class _Page {
  _Page({this.lable, this.colors, this.icon});

  final String lable;
  final MaterialColor colors;
  final IconData icon;

  Color get labelColor =>
      colors != null ? colors.shade300 : Colors.grey.shade300;

  bool get fabDefined => colors != null && icon != null;

  Color get fabColor => colors.shade400;

  Icon get fabIcon => Icon(icon);

  Key get fabKey => ValueKey<Color>(fabColor);
}

final List<_Page> _allPages = <_Page>[
  _Page(lable: 'Blue', colors: Colors.indigo, icon: Icons.add),
  _Page(lable: 'Eco', colors: Colors.green, icon: Icons.create),
  _Page(
    lable: 'No',
  ),
  _Page(lable: 'Teal', colors: Colors.teal, icon: Icons.add),
  _Page(lable: 'Blue', colors: Colors.indigo, icon: Icons.add),
  _Page(lable: 'Red', colors: Colors.red, icon: Icons.create),
];

class TabsFabDemo extends StatefulWidget {
  static const String routeName = '/material/tabs-fab';

  @override
  State<StatefulWidget> createState() {
    return TabsFabDemoState();
  }
}

class TabsFabDemoState extends State<TabsFabDemo>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TabController _controller;
  _Page _selectedPage;
  bool _extendedButtons = false;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: _allPages.length, vsync: this);
    _controller.addListener(() {
      setState(() {
        _selectedPage = _allPages[_controller.index];
      });
    });
    _selectedPage = _allPages[0];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('FAB per tab'),
        bottom: TabBar(
            controller: _controller,
            tabs: _allPages.map((_Page page) {
              return Tab(
                text: page.lable.toLowerCase(),
              );
            }).toList()),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.sentiment_very_dissatisfied),
              onPressed: () {
                setState(() {
                  _extendedButtons = !_extendedButtons;
                });
              })
        ],
      ),
      floatingActionButton: buildFloatingActionButton(_selectedPage),
      body: TabBarView(
          controller: _controller,
          children: _allPages.map((_Page page) {
            return buildTabView(page);
          }).toList()),
    );
  }

  void _showExplanatoryText() {
    _scaffoldKey.currentState.showBottomSheet<Null>((BuildContext context) {
      return Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Theme.of(context).dividerColor),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Text(
            _explanatoryText,
            style: Theme.of(context).textTheme.subhead,
          ),
        ),
      );
    });
  }

  Widget buildTabView(_Page page) {
    return Builder(builder: (BuildContext contex) {
      return Container(
        key: ValueKey<String>(page.lable),
        padding: EdgeInsets.fromLTRB(48.0, 48.0, 48.0, 96.0),
        child: Card(
          child: Center(
            child: Text(
              page.lable,
              style: TextStyle(color: page.labelColor, fontSize: 32.0),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    });
  }

  Widget buildFloatingActionButton(_Page page) {
    if (!page.fabDefined) {
      return null;
    }
    ;
    if (_extendedButtons) {
      return FloatingActionButton.extended(
          key: ValueKey<Key>(page.fabKey),
          tooltip: 'SHow explanation',
          backgroundColor: page.fabColor,
          onPressed: () {
            _showExplanatoryText();
          },
          label: Text(page.lable),
          icon: page.fabIcon);
    }
    return FloatingActionButton(
      key: page.fabKey,
      tooltip: 'Show explanation',
      backgroundColor: page.fabColor,
      child: page.fabIcon,
      onPressed: () {
        _showExplanatoryText();
      },
    );
  }
}
