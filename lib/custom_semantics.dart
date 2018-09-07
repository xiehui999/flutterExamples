import 'package:flutter/material.dart';

class AdjustableDropdownListTile extends StatelessWidget {
  const AdjustableDropdownListTile(
      {this.label, this.value, this.items, this.onChange});

  final String label;
  final String value;
  final List<String> items;
  final ValueChanged<String> onChange;

  @override
  Widget build(BuildContext context) {
    final int indexOfValue = items.indexOf(value);
    assert(indexOfValue != -1);
    final bool canIncrease = indexOfValue < items.length - 1;
    final bool canDecrease = indexOfValue > 0;

    return new Semantics(
      container: true,
      label: label,
      value: value,
      increasedValue: canIncrease ? _increasedValue : null,
      decreasedValue: canDecrease ? _decreasedValue : null,
      onIncrease: canIncrease ? _performIncrease : null,
      onDecrease: canDecrease ? _performDecrease : null,
      child: new ExcludeSemantics(
        child: new ListTile(
          title: new Text(label),
          trailing: new DropdownButton<String>(
              items: items.map((String item) {
                return new DropdownMenuItem<String>(
                  child: new Text(item),
                  value: item,
                );
              }).toList(),
              value: value,
              onChanged: onChange),
        ),
      ),
    );
  }

  String get _increasedValue {
    final int indexOfValue = items.indexOf(value);
    assert(indexOfValue < items.length - 1);
    return items[indexOfValue + 1];
  }

  String get _decreasedValue {
    final int indexOfValue = items.indexOf(value);
    assert(indexOfValue > 0);
    return items[indexOfValue - 1];
  }

  void _performIncrease() => onChange(_increasedValue);

  void _performDecrease() => onChange(_decreasedValue);
}

class AdjustableDropdownExample extends StatefulWidget {
  @override
  AdjustableDropdownExampleState createState() {
    return new AdjustableDropdownExampleState();
  }
}

class AdjustableDropdownExampleState extends State<AdjustableDropdownExample> {

  final List<String> items = <String>[
    '1 second',
    '5 seconds',
    '15 seconds',
    '30 seconds',
    '1 minute'
  ];
  String timeout;

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Adjustable  DropDown'),
        ),
        body: new ListView(
          children: <Widget>[
            new AdjustableDropdownListTile(
              label: 'Timeout',
              value: timeout ?? items[2],
              items: items,
              onChange: (String value) {
                setState(() {
                  timeout = value;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}

void main(){
  runApp(new AdjustableDropdownExample());
}