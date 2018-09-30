import 'package:flutter/material.dart';

import '../demo.dart';

const String _kAsset0 = 'assets/square/trevor.png';
const String _kAsset1 = 'assets/square/stella.png';
const String _kAsset2 = 'assets/square/sandra.png';

class DrawerDemo extends StatefulWidget {
  static const String routeName = '/material/drawer';

  @override
  DrawerDemoState createState() => DrawerDemoState();
}

class DrawerDemoState extends State<DrawerDemo>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static const List<String> _drawerContents = <String>['A', 'B', 'C', 'D', 'E'];
  static final Animatable<Offset> _drawerDetailsTween =
      Tween<Offset>(begin: Offset(0.0, -1.0), end: Offset.zero)
          .chain(CurveTween(curve: Curves.fastOutSlowIn));
  AnimationController _controller;
  Animation<double> _drawerContentsOpacity;
  Animation<Offset> _drawerDetailsPosition;
  bool _showDrawerContents = true;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _drawerContentsOpacity = CurvedAnimation(
        parent: ReverseAnimation(_controller), curve: Curves.fastOutSlowIn);
    _drawerDetailsPosition = _controller.drive(_drawerDetailsTween);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  IconData _backIcon() {
    switch (Theme.of(context).platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return Icons.arrow_back;
      case TargetPlatform.iOS:
        return Icons.arrow_back_ios;
    }
    return null;
  }

  void _showNotImplementedMessage() {
    Navigator.pop(context); // Dismiss the drawer.
    _scaffoldKey.currentState.showSnackBar(
        const SnackBar(content: Text("The drawer's items don't do anything")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(_backIcon()),
            alignment: Alignment.centerLeft,
            tooltip: 'Back',
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text('Navigation drawer'),
        actions: <Widget>[
          MaterialDemoDocumentationButton(DrawerDemo.routeName)
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Code4Android Widget'),
              accountEmail: Text('xiehui0902@163.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage(_kAsset0),
              ),
              otherAccountsPictures: <Widget>[
                GestureDetector(
                  onTap: () {
                    _onOtherAccountsTap(context);
                  },
                  child: Semantics(
                    label: 'Switch to Account B',
                    child: CircleAvatar(
                      backgroundImage: AssetImage(_kAsset1),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _onOtherAccountsTap(context);
                  },
                  child: Semantics(
                    label: 'Switch to Account B',
                    child: CircleAvatar(
                      backgroundImage: AssetImage(_kAsset2),
                    ),
                  ),
                )
              ],
              margin: EdgeInsets.only(top: 0.0),
              onDetailsPressed: () {
                //点击账号邮箱时回调
                _showDrawerContents = !_showDrawerContents;
                if (_showDrawerContents)
                  _controller.reverse();
                else
                  _controller.forward();
              },
            ),
            MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: Expanded(
                    child: ListView(
                  padding: EdgeInsets.only(top: 8.0),
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        FadeTransition(
                          opacity: _drawerContentsOpacity,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: _drawerContents.map((String id) {
                              return ListTile(
                                leading: CircleAvatar(
                                  child: Text(id),
                                ),
                                title: Text('Drawer item $id'),
                                onTap: _showNotImplementedMessage,
                              );
                            }).toList(),
                          ),
                        ),
                        SlideTransition(
                          position: _drawerDetailsPosition,
                          child: FadeTransition(
                            opacity: ReverseAnimation(_drawerContentsOpacity),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                ListTile(
                                  leading: Icon(Icons.add),
                                  title: Text('Add Account'),
                                  onTap: _showNotImplementedMessage,
                                ),
                                ListTile(
                                  leading: const Icon(Icons.settings),
                                  title: const Text('Manage accounts'),
                                  onTap: _showNotImplementedMessage,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                )))
          ],
        ),
      ),
      body: Center(
        child: InkWell(
          onTap: () {
            _scaffoldKey.currentState.openDrawer();
          },
          child: Semantics(
            button: true,
            label: 'Open Drawer',
            excludeSemantics: true,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(image: AssetImage(_kAsset0))),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Tap here to open the drawer',
                    style: Theme.of(context).textTheme.subhead,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onOtherAccountsTap(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Account switching not implemented'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Ok'))
            ],
          );
        });
  }
}
