import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum AppBarBehavior { normal, pinned, floating, snapping }

class ContactsDemo extends StatefulWidget {
  static const String routeName = '/contacts';

  @override
  State<StatefulWidget> createState() {
    return ContactsDemoState();
  }
}

class ContactsDemoState extends State<ContactsDemo> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();
  final double _appBarHeight = 256.0;
  AppBarBehavior _appBarBehavior = AppBarBehavior.pinned;

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.indigo,
            platform: Theme.of(context).platform),
        child: Scaffold(
          key: _scaffoldKey,
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: _appBarHeight,
                pinned: _appBarBehavior == AppBarBehavior.pinned,
                floating: _appBarBehavior == AppBarBehavior.floating ||
                    _appBarBehavior == AppBarBehavior.snapping,
                snap: _appBarBehavior == AppBarBehavior.snapping,
                actions: <Widget>[
                  IconButton(
                      icon: Icon(Icons.create),
                      tooltip: 'Edite',
                      onPressed: () {
                        _scaffoldKey.currentState.showSnackBar(
                            SnackBar(content: Text("isn't supported")));
                      }),
                  PopupMenuButton<AppBarBehavior>(
                      onSelected: (AppBarBehavior value) {
                    setState(() {
                      _appBarBehavior = value;
                    });
                  }, itemBuilder: (BuildContext context) {
                    return <PopupMenuItem<AppBarBehavior>>[
                      PopupMenuItem(
                        child: Text('App bar scrolls away'),
                        value: AppBarBehavior.normal,
                      ),
                      PopupMenuItem(
                        child: Text('pp bar stays put'),
                        value: AppBarBehavior.pinned,
                      ),
                      PopupMenuItem(
                        child: Text('App bar floats'),
                        value: AppBarBehavior.floating,
                      ),
                      PopupMenuItem(
                        child: Text('App bar snaps'),
                        value: AppBarBehavior.snapping,
                      ),
                    ];
                  })
                ],
                flexibleSpace: FlexibleSpaceBar(
                  title: Text('Ali Connors'),
                  background: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Image.asset(
                        'assets/square/ali_landscape.png',
                        fit: BoxFit.cover,
                        height: _appBarHeight,
                      ),
                      DecoratedBox(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: <Color>[
                            Color(0x60000000),
                            Color(0x00000000),
                          ],
                                  begin: Alignment(0.0, -1.0),
                                  end: Alignment(0.0, -0.4))))
                    ],
                  ),
                ),
              ),
              SliverList(
                  delegate: SliverChildListDelegate(<Widget>[
                AnnotatedRegion<SystemUiOverlayStyle>(
                    child: Text('1111',style: TextStyle(height: 1000.0),), value: SystemUiOverlayStyle.dark)
              ]))
            ],
          ),
        ));
  }
}
