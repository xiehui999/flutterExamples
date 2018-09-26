import 'package:flutter/material.dart';

const String _introText =
    'Tooltips are short identifying messages that briefly appear in response to '
    'a long press. Tooltip messages are also used by services that make Flutter '
    'apps accessible, like screen readers.';

class TooltipDemo extends StatelessWidget {
  static const String routeName = '/material/tooltips';

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Tooltips'),
      ),
      body: Builder(builder: (BuildContext context) {
        return SafeArea(
            top: false,
            bottom: false,
            child: ListView(
              children: <Widget>[
                Text(
                  _introText,
                  style: themeData.textTheme.subhead,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'long press the',
                      style: themeData.textTheme.subhead,
                    ),
                    Tooltip(
                      message: 'call icon',
                      child: Icon(Icons.call,
                          size: 18.0, color: themeData.iconTheme.color),
                    ),
                    Text(
                      'icon. ',
                      style: themeData.textTheme.subhead,
                    )
                  ],
                ),
                Center(
                  child: IconButton(
                      icon: Icon(Icons.call),
                      iconSize: 48.0,
                      tooltip: 'Place a phone call',
                      color: themeData.iconTheme.color,
                      onPressed: () {
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text('That was an ordinary tap')));
                      }),
                )
              ].map((Widget widget) {
                return Padding(padding: EdgeInsets.only(
                    top: 16.0, left: 16.0, right: 16.0), child: widget,);
              }).toList(),
            ));
      }),
    );
  }
}
