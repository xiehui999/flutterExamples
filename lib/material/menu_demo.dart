import 'package:flutter/material.dart';

class MenuDemo extends StatefulWidget {
  const MenuDemo({Key key}) : super(key: key);
  static const String routeName = '/material/menu';

  @override
  State<StatefulWidget> createState() {
    return MenuDemoState();
  }
}

class MenuDemoState extends State<MenuDemo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final String _simpleValue1 = 'Menu item value one';
  final String _simpleValue2 = 'Menu item value two';
  final String _simpleValue3 = 'Menu item value three';
  String _simpleValue;
  final String _checkedValue1 = 'one';
  final String _checkedValue2 = 'two';
  final String _checkedValue3 = 'three';
  final String _checkedValue4 = 'four';
  List<String> _checkedValues;

  @override
  void initState() {
    super.initState();
    _simpleValue = _simpleValue2;
    _checkedValues = <String>[_checkedValue3];
  }

  void showSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(value)));
  }

  void showMenuSelection(String value) {
    if (<String>[_simpleValue1, _simpleValue2, _simpleValue3].contains(value))
      _simpleValue = value;
    showSnackBar('You selected :${value}');
  }

  void showCheckedMenuSelections(String value) {
    if (_checkedValues.contains(value)) {
      _checkedValues.remove(value);
    } else {
      _checkedValues.add(value);
    }
    showSnackBar('Checked ${_checkedValues}');
  }

  bool isChecked(String value) => _checkedValues.contains(value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Menu'),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: showMenuSelection,
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<String>>[
                PopupMenuItem(
                  child: Text('ToolBar menu'),
                  value: 'Toolbar menu',
                ),
                PopupMenuItem(
                  child: Text('Right here'),
                  value: 'Right here',
                ),
                PopupMenuItem(
                  child: Text('Hooray!'),
                  value: 'Hooray!',
                ),
              ];
            },
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        children: <Widget>[
          ListTile(
            title: Text('An item with a context menu bottom'),
            trailing: PopupMenuButton<String>(
                padding: EdgeInsets.zero,
                onSelected: showMenuSelection,
                itemBuilder: (BuildContext context) {
                  return <PopupMenuItem<String>>[
                    PopupMenuItem<String>(
                      value: _simpleValue1,
                      child: Text('Context menu item one'),
                    ),
                    PopupMenuItem<String>(
                      enabled: false,
                      child: Text('A disabled menu item'),
                    ),
                    PopupMenuItem<String>(
                      value: _simpleValue3,
                      child: Text('Context menu item three'),
                    ),
                  ];
                }),
          ),
          ListTile(
            title: Text('An item with a sectioned menu'),
            trailing: PopupMenuButton<String>(
              padding: EdgeInsets.zero,
              onSelected: showMenuSelection,
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'Preview',
                    child: ListTile(
                      leading: Icon(Icons.visibility),
                      title: Text('Preview'),
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'Share',
                    child: ListTile(
                      leading: Icon(Icons.person_add),
                      title: Text('Share'),
                    ),
                  ),
                  PopupMenuItem(
                    child: ListTile(
                      leading: Icon(Icons.link),
                      title: Text('Get Link'),
                    ),
                    value: 'Get Link',
                  ),
                  const PopupMenuDivider(),
                  const PopupMenuItem<String>(
                      value: 'Remove',
                      child: ListTile(
                          leading: Icon(Icons.delete), title: Text('Remove')))
                ];
              },
            ),
          ),
          PopupMenuButton<String>(
            padding: EdgeInsets.zero,
            initialValue: _simpleValue,
            onSelected: showMenuSelection,
            child: ListTile(
              title: Text('An item with a simple menu'),
              subtitle: Text(_simpleValue),
            ),
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<String>>[
                PopupMenuItem<String>(
                  value: _simpleValue1,
                  child: Text(_simpleValue1),
                ),
                PopupMenuItem<String>(
                  value: _simpleValue2,
                  child: Text(_simpleValue2),
                ),
                PopupMenuItem<String>(
                  value: _simpleValue3,
                  child: Text(_simpleValue3),
                )
              ];
            },
          ),
          ListTile(
            title: Text('An item with a checklist menu'),
            trailing: PopupMenuButton<String>(
                padding: EdgeInsets.zero,
                onSelected: showCheckedMenuSelections,
                itemBuilder: (BuildContext context){
                  return <PopupMenuItem<String>>[
                    CheckedPopupMenuItem<String>(value: _checkedValue1,checked: isChecked(_checkedValue1),child: Text(_checkedValue1),),
                    CheckedPopupMenuItem<String>(value: _checkedValue2,checked: isChecked(_checkedValue2),child: Text(_checkedValue2),),
                    CheckedPopupMenuItem<String>(value: _checkedValue3,checked: isChecked(_checkedValue3),child: Text(_checkedValue3),),
                    CheckedPopupMenuItem<String>(value: _checkedValue4,checked: isChecked(_checkedValue4),child: Text(_checkedValue4),),
                  ];
                }),
          )
        ],
      ),
    );
  }
}
