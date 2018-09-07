import 'package:flutter/material.dart';

class ExpansionTileSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('ExpansionTile'),
        ),
        body: new ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return new EntryItem(
              entry: data[index],
            );
          },
          itemCount: data.length,
        ),
      ),
    );
  }
}

class EntryItem extends StatelessWidget {
  EntryItem({this.entry});

  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty)
      return new ListTile(
        title: new Text(root.title),
      );
    return ExpansionTile(
      key: new PageStorageKey(root),
      title: new Text(root.title),
      children: root.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}

class Entry {
  Entry(this.title, [this.children = const <Entry>[]]);

  final String title;
  final List<Entry> children;
}

final List<Entry> data = <Entry>[
  new Entry('Chapter A', <Entry>[
    new Entry('section A0', <Entry>[
      new Entry('Item A0.1'),
      new Entry('Item A0.2'),
      new Entry('Item A0.3'),
    ])
  ]),
  new Entry('Chapter B', <Entry>[
    new Entry('Section B0'),
    new Entry('Section B1'),
  ]),
  new Entry('Chapter C', <Entry>[
    new Entry('Section C0'),
    new Entry('Section C1'),
    new Entry('Section C2', <Entry>[
      new Entry('Item C2.0'),
      new Entry('Item C2.1'),
      new Entry('Item C2.2'),
      new Entry('Item C2.3',<Entry>[
        new Entry('Item C2.3.0'),
        new Entry('Item C2.3.1'),
        new Entry('Item C2.3.2'),
      ]),
    ]),
  ])
];

void main() {
  runApp(new ExpansionTileSample());
}
