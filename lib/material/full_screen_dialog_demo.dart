import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

enum DismissDialogAction {
  cancel,
  discard,
  save,
}

class DateTimeItem extends StatelessWidget {
  DateTimeItem({Key key, DateTime dateTime, @required this.onChanged})
      : assert(onChanged != null),
        date = DateTime(dateTime.year, dateTime.month, dateTime.day),
        time = TimeOfDay(hour: dateTime.hour, minute: dateTime.minute),
        super(key: key);
  final DateTime date;
  final TimeOfDay time;
  final ValueChanged<DateTime> onChanged;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return DefaultTextStyle(
        style: themeData.textTheme.subhead,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: themeData.dividerColor))),
                child: InkWell(
                  onTap: () {
                    showDatePicker(
                        context: context,
                        initialDate: date,
                        firstDate: date.subtract(Duration(days: 30)),
                        lastDate: date.add(Duration(days: 30)))
                        .then((DateTime value) {
                      if (value != null) {
                        onChanged(DateTime(value.year, value.month, value.day,
                            time.hour, time.minute));
                      }
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(DateFormat('EEE, MMM d yyyy').format(date)),
                      Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black54,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 8.0),
              padding: EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                border:
                Border(bottom: BorderSide(color: themeData.dividerColor)),
              ),
              child: InkWell(
                onTap: () {
                  showTimePicker(context: context, initialTime: time)
                      .then((TimeOfDay value) {
                    if (value != null) {
                      onChanged(DateTime(date.year, date.month, date.day,
                          value.hour, value.minute));
                    }
                  });
                },
                child: Row(
                  children: <Widget>[
                    Text('${time.format(context)}'),
                    Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black54,
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}

class FullScreenDialogDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FullScreenDialogDemoState();
  }
}

class FullScreenDialogDemoState extends State<FullScreenDialogDemo> {
  DateTime _fromDateTime = DateTime.now();
  DateTime _toDateTime = DateTime.now();
  bool _allDayValue = false;
  bool _saveNeeded = false;
  bool _hasLocation = false;
  bool _hasName = false;
  String _eventName;

  Future<bool> _onWillPop() async {
    _saveNeeded = _hasLocation || _hasName || _saveNeeded;
    if (!_saveNeeded) return true;

    final ThemeData themeData = Theme.of(context);
    final TextStyle dialogTextStyle = themeData.textTheme.subhead
        .copyWith(color: themeData.textTheme.caption.color);
    return await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(
              'Discard new event',
              style: dialogTextStyle,
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text('Cancel')),
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text('Discard'))
            ],
          );
        }) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(_hasName ? _eventName : 'Event Name tbd'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Save',
              style: theme.textTheme.body1.copyWith(color: Colors.white),
            ),
            onPressed: () {
              Navigator.pop(context, DismissDialogAction.save);
            },
          )
        ],
      ),
      body: Form(
          onWillPop: _onWillPop,
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                alignment: Alignment.bottomLeft,
                child: TextField(
                  decoration:
                  InputDecoration(labelText: 'Event name', filled: true),
                  style: theme.textTheme.headline,
                  onChanged: (String value) {
                    setState(() {
                      _hasName = value.isNotEmpty;
                      if (_hasName) {
                        _eventName = value;
                      }
                    });
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                alignment: Alignment.bottomLeft,
                child: TextField(
                  decoration: InputDecoration(
                      labelText: 'Location', hintText: 'Where is the event'),
                  onChanged: (String value) {
                    setState(() {
                      _hasLocation = value.isNotEmpty;
                    });
                  },
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Form',
                    style: theme.textTheme.caption,
                  ),
                  DateTimeItem(
                    dateTime: _fromDateTime,
                    onChanged: (DateTime value) {
                      setState(() {
                        _fromDateTime = value;
                        _saveNeeded = true;
                      });
                    },
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'To',
                    style: theme.textTheme.caption,
                  ),
                  DateTimeItem(
                    dateTime: _toDateTime,
                    onChanged: (DateTime value) {
                      setState(() {
                        _toDateTime = value;
                        _saveNeeded = true;
                      });
                    },
                  ),
                  Text('All Day')
                ],
              ),
              Container(
                decoration: BoxDecoration(
                    border:
                    Border(bottom: BorderSide(color: theme.dividerColor))),
                child: Row(
                  children: <Widget>[
                    Checkbox(
                        value: _allDayValue,
                        onChanged: (bool value) {
                          setState(() {
                            _allDayValue = value;
                            _saveNeeded = true;
                          });
                        }),
                    Text('All day')
                  ],
                ),
              )
            ].map((Widget child) {
              return Container(padding: EdgeInsets.symmetric(vertical: 8.0),
                height: 96.0,
                child: child,);
            }).toList(),
          )),
    );
  }
}
