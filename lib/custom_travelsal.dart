import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

class RowColumnTraversal extends StatelessWidget {
  const RowColumnTraversal({this.rowOrder, this.columnOrder, this.child});

  final int rowOrder;
  final int columnOrder;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return new Semantics(
      sortKey: new OrdinalSortKey(columnOrder.toDouble()),
      child: new Semantics(
        sortKey: new OrdinalSortKey(rowOrder.toDouble()),
        child: child,
      ),
    );
  }
}

class SpinnerButton extends StatelessWidget {
  const SpinnerButton(
      {Key key,
      this.onPressed,
      this.icon,
      this.rawOrder,
      this.columnOrder,
      this.field,
      this.increment})
      : super(key: key);
  final VoidCallback onPressed;
  final IconData icon;
  final int rawOrder;
  final int columnOrder;
  final Field field;
  final bool increment;

  @override
  Widget build(BuildContext context) {
    final String label =
        '${increment ? 'Increment' : 'Decrement'}${_fileToName(field)}';
    return new RowColumnTraversal(
      rowOrder: rawOrder,
      columnOrder: columnOrder,
      child: new Center(
        child: new IconButton(
          icon: new Icon(icon),
          onPressed: onPressed,
          tooltip: label,
        ),
      ),
    );
  }
}

class FieldWidget extends StatelessWidget {
  const FieldWidget(
      {Key key,
      this.rowOrder,
      this.columnOrder,
      this.onDecrease,
      this.onIncrease,
      this.value,
      this.field})
      : super(key: key);

  final int rowOrder;
  final int columnOrder;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;
  final int value;
  final Field field;

  @override
  Widget build(BuildContext context) {
    final String stringValue = '${_fileToName(field)}${value}';
    final String increasedValue = '${_fileToName(field)}${value + 1}';
    final String decreasedValue = '${_fileToName(field)}${value - 1}';
    return new RowColumnTraversal(
      rowOrder: rowOrder,
      columnOrder: columnOrder,
      child: new Semantics(
        onDecrease: onDecrease,
        onIncrease: onIncrease,
        value: stringValue,
        increasedValue: increasedValue,
        decreasedValue: decreasedValue,
        child: new ExcludeSemantics(
          child: new Text(value.toString()),
        ),
      ),
    );
  }
}

enum Field { DOGS, CATS, FISH }

String _fileToName(Field field) {
  switch (field) {
    case Field.DOGS:
      return 'DOGS';
      break;
    case Field.CATS:
      return 'CATS';
      break;
    case Field.FISH:
      return 'FISH';
      break;
  }
}

class CustomTraversalExample extends StatefulWidget {
  @override
  CustomTraversalExampleState createState() {
    return CustomTraversalExampleState();
  }
}

class CustomTraversalExampleState extends State<CustomTraversalExample> {
  List<int> fields = <int>[0, 0, 0];

  void _addToField(Field field, int delta) {
    setState(() {
      fields[field.index] += delta;
    });
  }

  Widget _makeFieldHeader(int rowOrder, int columnOrder, Field field) {
    return new RowColumnTraversal(
        rowOrder: rowOrder,
        columnOrder: columnOrder,
        child: new Text(_fileToName(field)));
  }

  Widget _makeSpinnerButton(int rowOrder, int columnOrder, Field field,
      {bool increment = true}) {
    return new SpinnerButton(
      rawOrder: rowOrder,
      columnOrder: columnOrder,
      icon: increment ? Icons.arrow_upward : Icons.arrow_downward,
      onPressed: () => _addToField(field, increment ? 1 : -1),
      field: field,
      increment: increment,
    );
  }

  Widget _makeEntryField(int rowOrder, int columnPrder, Field field) {
    return new FieldWidget(
      rowOrder: rowOrder,
      columnOrder: columnPrder,
      onIncrease: () => _addToField(field, 1),
      onDecrease: () => _addToField(field, -1),
      value: fields[field.index],
      field: field,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: Text('Pet Inventory'),
        ),
        body: new Builder(builder: (BuildContext context) {
          return new DefaultTextStyle(
            style: DefaultTextStyle.of(context).style.copyWith(fontSize: 21.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Semantics(
                  sortKey: const OrdinalSortKey(0.0),
                  child: const Text('How many pets do you own?'),
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 40.0)),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    _makeFieldHeader(1, 0, Field.DOGS),
                    _makeFieldHeader(1, 1, Field.CATS),
                    _makeFieldHeader(1, 2, Field.FISH),
                  ],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    _makeSpinnerButton(3, 0, Field.DOGS, increment: true),
                    _makeSpinnerButton(3, 1, Field.CATS, increment: true),
                    _makeSpinnerButton(3, 2, Field.FISH, increment: true),
                  ],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _makeEntryField(2, 0, Field.DOGS),
                    _makeEntryField(2, 1, Field.CATS),
                    _makeEntryField(2, 2, Field.FISH),
                  ],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    _makeSpinnerButton(4, 0, Field.DOGS, increment: true),
                    _makeSpinnerButton(4, 1, Field.CATS, increment: true),
                    _makeSpinnerButton(4, 2, Field.FISH, increment: true),
                  ],
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
                new Semantics(
                  sortKey: const OrdinalSortKey(5.0),
                  child: new MaterialButton(
                    child: const Text('RESET'),
                    onPressed: () {
                      setState(() {
                        fields = <int>[0, 0, 0];
                      });
                    },
                    textColor: Colors.blue,
                    textTheme: ButtonTextTheme.normal,
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}

void main(){
  runApp(new CustomTraversalExample());
}