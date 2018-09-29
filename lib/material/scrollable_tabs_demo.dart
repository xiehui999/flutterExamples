import 'package:flutter/material.dart';

enum TabsDemoStyle { iconsAndText, iconsOnly, textOnly }

class _Page {
  const _Page({this.icon, this.text});

  final IconData icon;
  final String text;
}

const List<_Page> _allPages = <_Page>[
  _Page(icon: Icons.grade, text: 'TRIUMPH'),
  _Page(icon: Icons.playlist_add, text: 'NOTE'),
  _Page(icon: Icons.check_circle, text: 'SUCCESS'),
  _Page(icon: Icons.question_answer, text: 'OVERSTATE'),
  _Page(icon: Icons.sentiment_very_satisfied, text: 'SATISFACTION'),
  _Page(icon: Icons.camera, text: 'APERTURE'),
  _Page(icon: Icons.assignment_late, text: 'WE MUST'),
  _Page(icon: Icons.assignment_turned_in, text: 'WE CAN'),
  _Page(icon: Icons.group, text: 'ALL'),
  _Page(icon: Icons.block, text: 'EXCEPT'),
  _Page(icon: Icons.sentiment_very_dissatisfied, text: 'CRYING'),
  _Page(icon: Icons.error, text: 'MISTAKE'),
  _Page(icon: Icons.loop, text: 'TRYING'),
  _Page(icon: Icons.cake, text: 'CAKE'),
];

class ScrollableTabsDemo extends StatefulWidget {
  static const String routeName = 'material/scrollable-tabs';

  @override
  State<StatefulWidget> createState() {
    return ScrollableTabsDemoState();
  }
}

class ScrollableTabsDemoState extends State<ScrollableTabsDemo>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  TabsDemoStyle _demoStyle = TabsDemoStyle.iconsAndText;
  bool _customIndicator = false;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: _allPages.length, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void changeDemoStyle(TabsDemoStyle style) {
    setState(() {
      _demoStyle = style;
    });
  }

  Decoration getIndicator() {
    if (!_customIndicator) return UnderlineTabIndicator();
    switch (_demoStyle) {
      case TabsDemoStyle.iconsAndText:
        return ShapeDecoration(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                side: BorderSide(color: Colors.white24, width: 2.0)) +
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    side: BorderSide(color: Colors.transparent, width: 4.0)));
      case TabsDemoStyle.iconsOnly:
        return ShapeDecoration(
            shape: CircleBorder(
                side: BorderSide(color: Colors.white24, width: 4.0)) +
                CircleBorder(
                    side: BorderSide(color: Colors.transparent, width: 4.0)));
      case TabsDemoStyle.textOnly:
        return ShapeDecoration(shape: StadiumBorder(
            side: BorderSide(color: Colors.white24, width: 2.0)) +
            StadiumBorder(
                side: BorderSide(color: Colors.transparent, width: 4.0)));
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Theme
        .of(context)
        .accentColor;
    return Scaffold(appBar: AppBar(
      title: Text('Scrollable tabs'),
      actions: <Widget>[IconButton(
        icon: Icon(Icons.sentiment_very_satisfied), onPressed: () {
        setState(() {
          _customIndicator = !_customIndicator;
        });
      },), PopupMenuButton<TabsDemoStyle>(
        onSelected: changeDemoStyle,
        itemBuilder: (BuildContext context) {
          return <PopupMenuItem<TabsDemoStyle>>[
            PopupMenuItem(
              value: TabsDemoStyle.iconsAndText,
              child: Text('Icons and text'),),
            PopupMenuItem(
              value: TabsDemoStyle.iconsOnly, child: Text('Icons only'),),
            PopupMenuItem(
              value: TabsDemoStyle.textOnly, child: Text('Text only'),),
          ];
        },
      )
      ],
      bottom: TabBar(controller: _controller,
          isScrollable: true,
          indicator: getIndicator(),
          tabs: _allPages.map<Tab>((_Page page) {
            assert(_demoStyle != null);
            switch (_demoStyle) {
              case TabsDemoStyle.iconsAndText:
                return Tab(text: page.text, icon: Icon(page.icon),);
              case TabsDemoStyle.iconsOnly:
                return Tab(icon: Icon(page.icon),);
              case TabsDemoStyle.textOnly:
                return Tab(text: page.text,);
            }
          }).toList()),),
      body: TabBarView(
          controller: _controller, children: _allPages.map((_Page page) {
        return SafeArea(top: false,
            bottom: false,
            child: Container(
              key: ObjectKey(page.icon),
              padding: EdgeInsets.all(12.0),
              child: Card(child: Icon(
                page.icon, color: color,
                size: 128.0,
                semanticLabel: 'PLACEHOLDER FOR ${page.text} tab',),),));
      }).toList()),);
  }
}
