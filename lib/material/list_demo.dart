import 'package:flutter/material.dart';
import 'package:flutter_app/demo.dart';

enum _MaterialListType { oneLine, oneLineWithAvatar, twoLine, threeLine }

class ListDemo extends StatefulWidget {
  const ListDemo({Key key}) : super(key: key);

  static const String routeName = '/material/list';

  @override
  State<StatefulWidget> createState() {
    return ListDemoState();
  }
}

class ListDemoState extends State<ListDemo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  PersistentBottomSheetController<Null> _bottomSheet;
  _MaterialListType _itemType = _MaterialListType.threeLine;
  bool _dense = false;
  bool _showAvatars = true;
  bool _showIcons = false;
  bool _showDividers = false;
  bool _reverseSort = false;
  List<String> items = <String>[
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
  ];

  void changeItemType(_MaterialListType type) {
    setState(() {
      _itemType = type;
    });
    _bottomSheet?.setState(() {});
  }

  void _showConfigurationSheet() {
    final PersistentBottomSheetController<Null> bottomSheet =
        _scaffoldKey.currentState.showBottomSheet((BuildContext context) {
      return Container(
        decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Colors.black26))),
        child: ListView(
          shrinkWrap: true,
          primary: false,
          children: <Widget>[
            MergeSemantics(
              child: ListTile(
                dense: true,
                title: Text('One-line'),
                trailing: Radio(
                    value: _showAvatars
                        ? _MaterialListType.oneLineWithAvatar
                        : _MaterialListType.oneLine,
                    groupValue: _itemType,
                    onChanged: changeItemType),
              ),
            ),
            MergeSemantics(
              child: ListTile(
                dense: true,
                title: Text('Two-line'),
                trailing: Radio(
                    value: _MaterialListType.twoLine,
                    groupValue: _itemType,
                    onChanged: changeItemType),
              ),
            ),
            MergeSemantics(
              child: ListTile(
                dense: true,
                title: const Text('Three-line'),
                trailing: Radio<_MaterialListType>(
                  value: _MaterialListType.threeLine,
                  groupValue: _itemType,
                  onChanged: changeItemType,
                ),
              ),
            ),
            MergeSemantics(
              child: ListTile(
                dense: true,
                title: const Text('Show avatar'),
                trailing: Checkbox(
                  value: _showAvatars,
                  onChanged: (bool value) {
                    setState(() {
                      _showAvatars = value;
                    });
                    _bottomSheet?.setState(() {});
                  },
                ),
              ),
            ),
            MergeSemantics(
              child: ListTile(
                dense: true,
                title: const Text('Show icon'),
                trailing: Checkbox(
                  value: _showIcons,
                  onChanged: (bool value) {
                    setState(() {
                      _showIcons = value;
                    });
                    _bottomSheet?.setState(() {});
                  },
                ),
              ),
            ),
            MergeSemantics(
              child: ListTile(
                dense: true,
                title: const Text('Show dividers'),
                trailing: Checkbox(
                  value: _showDividers,
                  onChanged: (bool value) {
                    setState(() {
                      _showDividers = value;
                    });
                    _bottomSheet?.setState(() {});
                  },
                ),
              ),
            ),
            MergeSemantics(
              child: ListTile(
                dense: true,
                title: const Text('Dense layout'),
                trailing: Checkbox(
                  value: _dense,
                  onChanged: (bool value) {
                    setState(() {
                      _dense = value;
                    });
                    _bottomSheet?.setState(() {});
                  },
                ),
              ),
            ),
          ],
        ),
      );
    });
    setState(() {
      _bottomSheet = bottomSheet;
    });
    _bottomSheet.closed.whenComplete(() {
      if (mounted) {
        setState(() {
          _bottomSheet = null;
        });
      }
    });
  }

  Widget buildListTile(BuildContext context, String item) {
    Widget secondary;
    if (_itemType == _MaterialListType.twoLine) {
      secondary = const Text('Additional item information.');
    } else {
      secondary = Text(
          'Even more addtional list item information appears on line three.');
    }
    return MergeSemantics(
      child: ListTile(
        isThreeLine: _itemType == _MaterialListType.threeLine,
        dense: _dense,
        leading: _showAvatars
            ? ExcludeSemantics(
                child: CircleAvatar(
                  child: Text(item),
                ),
              )
            : null,
        title: Text('This item reprsents $item'),
        subtitle: secondary,
        trailing: _showIcons
            ? Icon(
                Icons.info,
                color: Theme.of(context).disabledColor,
              )
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String layoutText = _dense ? ' \u2013 Dense' : '';
    String itemTypeText;
    switch (_itemType) {
      case _MaterialListType.oneLine:
      case _MaterialListType.oneLineWithAvatar:
        itemTypeText = 'Single-line';
        break;
      case _MaterialListType.twoLine:
        itemTypeText = 'Two-line';
        break;
      case _MaterialListType.threeLine:
        itemTypeText = 'Three-line';
        break;
    }
    Iterable<Widget> listTiles = items.map((String item) {
      return buildListTile(context, item);
    });
    if (_showDividers)
      listTiles = ListTile.divideTiles(tiles: listTiles, context: context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Scrolling list \n$itemTypeText$layoutText'),
        actions: <Widget>[
          MaterialDemoDocumentationButton(ListDemo.routeName),
          IconButton(
              icon: Icon(Icons.sort_by_alpha),
              onPressed: () {
                setState(() {
                  _reverseSort = !_reverseSort;
                  items.sort((String a, String b) {
                    return _reverseSort ? b.compareTo(a) : a.compareTo(b);
                  });
                });
              }),
          IconButton(
              icon: Icon(Theme.of(context).platform == TargetPlatform.iOS
                  ? Icons.more_horiz
                  : Icons.more_vert),
              onPressed: _bottomSheet == null ? _showConfigurationSheet : null)
        ],
      ),
      body: Scrollbar(
          child: ListView(
        padding: EdgeInsets.symmetric(vertical: _dense ? 4.0 : 8.0),
        children: listTiles.toList(),
      )),
    );
  }
}
