import 'dart:async';
import 'package:flutter/material.dart';

enum IndicatorType { overscroll, refresh }

class OverscrollDemo extends StatefulWidget {
  static const String routeName = '/material/overscroll';

  @override
  State<StatefulWidget> createState() {
    return OverscrollDemoState();
  }
}

class OverscrollDemoState extends State<OverscrollDemo> {
  final GlobalKey<ScaffoldState> _scaffolfKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  static final List<String> _items = <String>[
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffolfKey,
      appBar: AppBar(
        title: Text('Pull to Refresh'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh),
              tooltip: 'Refresh',
              onPressed: () {
                _refreshIndicatorKey.currentState.show();
              })
        ],
      ),
      body: RefreshIndicator(
          key: _refreshIndicatorKey,
          child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              itemCount: _items.length,
              itemBuilder: (BuildContext context, int index) {
                final String item = _items[index];

                return ListTile(
                  isThreeLine: true,
                  leading: CircleAvatar(
                    child: Text(item),
                  ),
                  title: Text('This item represents $item .'),
                  subtitle: Text(
                      'Even more additional list item information appears on line three.'),
                );
              }),
          onRefresh: _handleRefresh),
    );
  }

  Future<Null> _handleRefresh() {
    final Completer<Null> completer = Completer<Null>();
    Timer(Duration(seconds: 3), () {
      completer.complete(null);
    });
    return completer.future.then((_) {
      _scaffolfKey.currentState?.showSnackBar(SnackBar(
        content: Text('Refresh complete'),
        action: SnackBarAction(
            label: 'Reset',
            onPressed: () {
              _refreshIndicatorKey.currentState.show();
            }),
      ));
    });
  }
}
