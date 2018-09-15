import 'package:flutter/material.dart';

class TextStyleItem extends StatelessWidget {
  const TextStyleItem(
      {Key key, @required this.name, @required this.style, @required this.text})
      : assert(name != null),
        assert(style != null),
        assert(text != null),
        super(key: key);

  final String name;
  final TextStyle style;
  final String text;

  @override
  Widget build(BuildContext context) {
  }
}
