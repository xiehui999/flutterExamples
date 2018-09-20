import 'package:flutter/material.dart';
import 'package:flutter_app/material/full_screen_dialog_demo.dart';

enum DialogDemoAction {
  cancel,
  discard,
  disagree,
  agree,
}

const String _alertWithoutTitleText = 'Discard draft?';

const String _alertWithTitleText =
    'Let Google help apps determine location. This means sending anonymous location '
    'data to Google, even when no apps are running.';

class DialogDemoItem extends StatelessWidget {
  const DialogDemoItem(
      {Key key, this.icon, this.color, this.text, this.onPressed})
      : super(key: key);
  final IconData icon;
  final Color color;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            size: 36.0,
            color: color,
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Text(text),
          )
        ],
      ),
    );
  }
}

class DialogDemo extends StatefulWidget {
  static const String routeName = '/material/dialog';

  @override
  State<StatefulWidget> createState() {
    return DialogDemoState();
  }
}

class DialogDemoState extends State<DialogDemo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    final DateTime now = DateTime.now();
    _selectedTime = TimeOfDay(hour: now.hour, minute: now.minute);
  }

  void showDemoDialog<T>({BuildContext context, Widget child}) {
    showDialog<T>(context: context, builder: (BuildContext context) => child)
        .then<void>((T value) {
      if (value != null) {
        _scaffoldKey.currentState
            .showSnackBar(SnackBar(content: Text('You selected:$value')));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TextStyle dialogTextStyle = themeData.textTheme.subhead
        .copyWith(color: themeData.textTheme.caption.color);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Dialog'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 72.0),
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              showDemoDialog<DialogDemoAction>(
                  context: context,
                  child: AlertDialog(
                    content: Text(
                      _alertWithTitleText,
                      style: dialogTextStyle,
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.pop(context, DialogDemoAction.cancel);
                        },
                      ),
                      FlatButton(
                          onPressed: () {
                            Navigator.pop(context, DialogDemoAction.discard);
                          },
                          child: Text('Discard'))
                    ],
                  ));
            },
            child: Text('Alert'),
          ),
          RaisedButton(
            child: Text('Alert with title'),
            onPressed: () {
              showDemoDialog<DialogDemoAction>(
                  context: context,
                  child: AlertDialog(
                    title: Text('Use Google\'s location service'),
                    content: Text(
                      _alertWithTitleText,
                      style: dialogTextStyle,
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('Disagree'),
                        onPressed: () {
                          Navigator.pop(context, DialogDemoAction.disagree);
                        },
                      ),
                      FlatButton(
                        child: Text('Agree'),
                        onPressed: () {
                          Navigator.pop(context, DialogDemoAction.agree);
                        },
                      )
                    ],
                  ));
            },
          ),
          RaisedButton(
              child: Text('Simple'),
              onPressed: () {
                showDemoDialog<String>(
                    context: context,
                    child: SimpleDialog(
                      title: Text('Set backup account'),
                      children: <Widget>[
                        DialogDemoItem(
                          icon: Icons.account_circle,
                          color: themeData.primaryColor,
                          text: 'username@gamil.com',
                          onPressed: () {
                            Navigator.pop(context, 'username@gmail.com');
                          },
                        ),
                        DialogDemoItem(
                            icon: Icons.account_circle,
                            color: themeData.primaryColor,
                            text: 'user02@gmail.com',
                            onPressed: () {
                              Navigator.pop(context, 'user02@gmail.com');
                            }),
                        DialogDemoItem(
                            icon: Icons.add_circle,
                            text: 'add account',
                            color: themeData.disabledColor)
                      ],
                    ));
              }),
          RaisedButton(
              child: Text('Confirmartion'),
              onPressed: () {
                showTimePicker(context: context, initialTime: _selectedTime)
                    .then<Null>((TimeOfDay value) {
                  if (value != null && value != _selectedTime) {
                    _selectedTime = value;
                    _scaffoldKey.currentState.showSnackBar(SnackBar(
                        content:
                            Text('you selected:${value.format(context)}')));
                  }
                });
              }),
          RaisedButton(
            child: Text('Fullscreen'),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute<DismissDialogAction>(
                      builder: (BuildContext context) {
                        return FullScreenDialogDemo();
                      },
                      fullscreenDialog: true));
            },
          )
        ].map((Widget button) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: button,
          );
        }).toList(),
      ),
    );
  }
}
