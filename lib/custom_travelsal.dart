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


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
  }
}
