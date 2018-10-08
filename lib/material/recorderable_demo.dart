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
                  title: const Text('Horizontal Avatars'),
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
    _bottomSheet.closed.whenComplete(() {
      if (mounted) {
        setState(() {
          _bottomSheet = null;
        });
      }
    });
  }

  Widget buildListTile(_ListItem item) {
    const Widget secondary = Text(
      'Even more additional list item information appears on line three.',
    );
    Widget listTile;
    switch (_itemType) {
      case ReorderableListType.threeLine:
        listTile = CheckboxListTile(
            key: Key(item.value),
            isThreeLine: true,
            title: Text('This item represents ${item.value}.'),
            subtitle: secondary,
            secondary: Icon(Icons.drag_handle),
            value: item.checkState ?? false,
            onChanged: (bool newValue) {
              setState(() {
                item.checkState = newValue;
              });
            });
        break;
      case ReorderableListType.horizontalAvatar:
      case ReorderableListType.verticalAvatar:
        listTile = Container(
          key: Key(item.value),
          height: 100.0,
          width: 100.0,
          child: CircleAvatar(
            child: Text(item.value),
            backgroundColor: Colors.green,
          ),
        );
        break;
    }
    return listTile;
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final _ListItem item = _items.removeAt(oldIndex);
      _items.insert(newIndex, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Recorderable list'),
        actions: <Widget>[
          MaterialDemoDocumentationButton(ReorderableListDemo.routeName),
          IconButton(
              icon: Icon(Icons.sort_by_alpha),
              tooltip: 'Sort',
              onPressed: () {
                setState(() {
                  _reverseSort = !_reverseSort;
                  _items.sort((_ListItem a, _ListItem b) => _reverseSort
                      ? b.value.compareTo(a.value)
                      : a.value.compareTo(b.value));
                });
              }),
          IconButton(
              icon: Icon(Theme.of(context).platform == TargetPlatform.iOS
                  ? Icons.more_horiz
                  : Icons.more_vert),
              tooltip: 'Show menu',
              onPressed: _bottomSheet == null ? _showConfigurationSheet : null),
        ],
      ),
      body: Scrollbar(
          child: ReorderableListView(
              header: _itemType != ReorderableListType.threeLine
                  ? Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Header of the list',
                        style: Theme.of(context).textTheme.headline,
                      ),
                    )
                  : null,
              scrollDirection: _itemType == ReorderableListType.horizontalAvatar
                  ? Axis.horizontal
                  : Axis.vertical,
              children: _items.map(buildListTile).toList(),
              onReorder: _onReorder)),
    );
  }
}
