import 'package:flutter/material.dart';

const String _text1 =
    'Snackbars provide lightweight feedback about an operation by '
    'showing a brief message at the bottom of the screen. Snackbars '
    'can contain an action.';

const String _text2 =
    'Snackbars should contain a single line of text directly related '
    'to the operation performed. They cannot contain icons.';

const String _text3 =
    'By default snackbars automatically disappear after a few seconds ';

class SnackBarDemo extends StatefulWidget {
  static const String routeName = '/material/snack-bar';

  const SnackBarDemo({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SnackBarDemoState();
  }
}

class SnackBarDemoState extends State<SnackBarDemo> {
  int _snackBarIndex = 1;

  Widget buildBody(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: false,
        child: ListView(
          padding: EdgeInsets.all(24.0),
          children: <Widget>[
            Text(_text1),
            Text(_text2),
            Center(
              child: RaisedButton(
                onPressed: () {
                  final int thisSnackBarIndex = _snackBarIndex++;
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text('This is snackbar #$thisSnackBarIndex.'),
                    action: SnackBarAction(
                        label: 'Action',
                        onPressed: () {
                          Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'You pressed snackbar $thisSnackBarIndex\'s action')));
                        }),
                  ));
                },
                child: Text('Show a SnackBar'),
              ),
            ),
            Text(_text3),
          ].map((Widget widget) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: widget,
            );
          }).toList(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Snackbar'),
      ),
      body: Builder(builder: buildBody),
    );
  }
}
