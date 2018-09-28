import 'package:flutter/material.dart';

class TwoLevelListDemo extends StatelessWidget {
  static const String routeName = '/material/two-level-list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expand/collapse list control'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Top'),
          ),
          ExpansionTile(
            title: Text('Sublist'),
            backgroundColor: Theme.of(context).accentColor.withOpacity(0.025),
            children: <Widget>[
              ListTile(title: Text('One'),),
              ListTile(title: Text('Two'),),
              ListTile(title: Text('Three'),),
              ListTile(title: Text('Four'),),
            ],
          ),
          ListTile(title: Text('Bottom'),)
        ],
      ),
    );
  }
}
