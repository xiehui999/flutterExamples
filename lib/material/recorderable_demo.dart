import 'package:flutter/material.dart';
import 'package:flutter_app/demo.dart';

enum ReorderableListType { horizontalAvatar, verticalAvatar, threeLine }

class _ListItem {
  _ListItem(this.value, this.checkState);

  final String value;
  bool checkState;
}

class ReorderableListDemo extends StatefulWidget {
  const ReorderableListDemo({Key key}) : super(key: key);
  static const String routeName = '/material/recorderable-list';

  @override
  State<StatefulWidget> createState() {
    return ReorderableListDemoState();
  }
}

class ReorderableListDemoState extends State<ReorderableListDemo> {
  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();
  PersistentBottomSheetController<Null> _bottomSheet;
  ReorderableListType _itemType = ReorderableListType.threeLine;
  bool _reverseSort = false;
  final List<_ListItem> _items = <String>[
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
    'N',
  ].map((String item) {
    return _ListItem(item, false);
  }).toList();

  void changeItemType(ReorderableListType type) {
    setState(() {
      _itemType = type;
    });
    _bottomSheet?.setState(() {});
    _bottomSheet?.close;
  }

  void _showConfigurationSheet() {
    setState(() {
      _bottomSheet =
          scaffoldKey.currentState.showBottomSheet((BuildContext context) {
        return DecoratedBox(
          decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.black26))),
          child: ListView(
            shrinkWrap: true,
            primary: false,
            children: <Widget>[
              RadioListTile(
                  value: ReorderableListType.horizontalAvatar,
                  dense: true,
                  groupValue: _itemType,
                  onChanged: changeItemType),
              RadioListTile<ReorderableListType>(
                dense: true,
                title: const Text('Vertical Avatars'),
                value: ReorderableListType.verticalAvatar,
                groupValue: _itemType,
                onChanged: changeItemType,
              ),
              RadioListTile<ReorderableListType>(
                dense: true,
                title: const Text('Three-line'),
                value: ReorderableListType.threeLine,
                groupValue: _itemType,
                onChanged: changeItemType,
              ),
            ],
          ),
        );
      });
    });
  }
  Widget buildListTile(_ListItem item) {

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
  }
}
