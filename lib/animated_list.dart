import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class AnimatedListSample extends StatefulWidget {
  @override
  _AnimatedListSampleState createState() => new _AnimatedListSampleState();
}

class _AnimatedListSampleState extends State<AnimatedListSample> {
  final GlobalKey<AnimatedListState> _listKey =
      new GlobalKey<AnimatedListState>();
  ListModel<int> _list;
  int _seletedItem;
  int _nextItem;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _list = new ListModel<int>(
        listKey: _listKey,
        initialItems: <int>[0, 1, 2],
        removedItemBuilder: _buildRemovedItem);
    _nextItem = 3;
  }

  Widget _buildRemovedItem(
      int item, BuildContext context, Animation<double> animation) {
    return new CardItem(
      animation: animation,
      item: item,
      seleted: false,
    );
  }

  void _insert() {
    final int index =
        _seletedItem == null ? _list.length : _list.indexOf(_seletedItem);
    _list.insert(index, _nextItem++);
  }

  void _remove() {
    if (_seletedItem != null) {
      _list.removeAt(_list.indexOf(_seletedItem));
    }
    setState(() {
      _seletedItem = null;
    });
  }

  Widget _buildItem(
      BuildContext context, int index, Animation<double> animation) {
    return new CardItem(
      animation: animation,
      item: _list[index],
      seleted: _seletedItem == _list[index],
      onTap: () {
        _seletedItem = _seletedItem == _list[index] ? null : _list[index];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('AnimatedList'),
          actions: <Widget>[
            new IconButton(
              icon: const Icon(
                Icons.add_circle,
              ),
              onPressed: _insert,
              tooltip: 'inset a new Item',
            ),
            new IconButton(
              icon: const Icon(Icons.remove_circle),
              onPressed: _remove,
              tooltip: 'inset a new time',
            )
          ],
        ),
        body: new Padding(
          padding: const EdgeInsets.all(16.0),
          child: new AnimatedList(
            key: _listKey,
            initialItemCount: _list.length,
            itemBuilder: _buildItem,
          ),
        ),
      ),
    );
  }
}

class ListModel<E> {
  ListModel({@required this.listKey, @required this.removedItemBuilder, Iterable<E> initialItems})
      : assert(listKey != null),
        assert(removedItemBuilder != null),
        _items = new List<E>.from(initialItems??<E>[]);

  final GlobalKey<AnimatedListState> listKey;
  final dynamic removedItemBuilder;
  final List<E> _items;

  AnimatedListState get _animatedList => listKey.currentState;

  void insert(int index, E item) {
    _items.insert(index, item);
    _animatedList.insertItem(index);
  }

  E removeAt(int index) {
    E removeItem = _items.removeAt(index);
    if (removeItem != null) {
      _animatedList.removeItem(index,
          (BuildContext context, Animation<double> animation) {
        return removedItemBuilder(removeItem, context, animation);
      });
    }
  }

  int get length => _items.length;

  E operator [](int index) => _items[index];

  int indexOf(E item) => _items.indexOf(item);
}

class CardItem extends StatelessWidget {
  const CardItem(
      {Key key, this.animation, this.onTap, this.item, this.seleted = false})
      : assert(animation != null),
        assert(item != null && item >= 0),
        assert(seleted != null),
        super(key: key);

  final Animation<double> animation;
  final VoidCallback onTap;
  final int item;
  final bool seleted;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.display1;
    if (seleted)
      textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);
    return new Padding(
      padding: const EdgeInsets.all(2.0),
      child: new SizeTransition(
        sizeFactor: animation,
        axis: Axis.vertical,
        child: new GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: new SizedBox(
            height: 128.0,
            child: new Card(
              color: Colors.primaries[item % Colors.primaries.length],
              child: new Center(
                child: new Text(
                  'Item ${item}',
                  style: textStyle,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(new AnimatedListSample());
}
