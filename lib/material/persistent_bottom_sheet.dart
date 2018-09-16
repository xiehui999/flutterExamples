import 'package:flutter/material.dart';

class PersistentBottomSheet extends StatefulWidget {
  static const String routeName = '/material/persistent-bottom-sheet';

  @override
  State<StatefulWidget> createState() {
    return new PersistentBottomSheetState();
  }
}

class PersistentBottomSheetState extends State<PersistentBottomSheet> {
  final GlobalKey<ScaffoldState> _scaffolfKey = GlobalKey<ScaffoldState>();
  VoidCallback _showBottomSheetCallBack;

  @override
  void initState() {
    super.initState();
    _showBottomSheetCallBack = _showBottomSheet;
  }

  void _showBottomSheet() {
    setState(() {
      _showBottomSheetCallBack = null;
    });
    _scaffolfKey.currentState
        .showBottomSheet<Null>((BuildContext context) {
          final ThemeData themeData = Theme.of(context);
          return Container(
            decoration: BoxDecoration(
                border:
                    Border(top: BorderSide(color: themeData.disabledColor))),
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: Text(
                'This is a Material persistent bottom sheet. Drag downwards to dismiss it',
                textAlign: TextAlign.center,
                style: TextStyle(color: themeData.accentColor, fontSize: 24.0),
              ),
            ),
          );
        })
        .closed
        .whenComplete(() {
          if (mounted) {
            setState(() {
              _showBottomSheetCallBack = _showBottomSheet;
            });
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffolfKey,
      appBar: AppBar(title: Text('Persistent bottom sheet')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Text('You tapped the floating action button'),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Ok'),
                    ),
                  ],
                );
              });
        },
        child: Icon(
          Icons.add,
          semanticLabel: 'Add',
        ),
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: RaisedButton(
            child: Text('Show Bottom Sheet'),
            onPressed: _showBottomSheetCallBack),
      ),
    );
  }
}
