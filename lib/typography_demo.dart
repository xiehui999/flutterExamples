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
    final ThemeData themeData = Theme.of(context);
    final TextStyle nameStyle = themeData.textTheme.caption
        .copyWith(color: themeData.textTheme.caption.color);
    return new Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 72.0,
            child: Text(
              name,
              style: nameStyle,
            ),
          ),
          new Expanded(
              child: Text(
            text,
            style: style.copyWith(height: 1.0),
          ))
        ],
      ),
    );
  }
}

class TypographyDemo extends StatelessWidget {
  static const String routeName = '/typography';

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final List<Widget> styleItems = <Widget>[
      TextStyleItem(
          name: 'Display 3', style: textTheme.display3, text: 'Regular 56 sp'),
      TextStyleItem(
          name: 'Display 2', style: textTheme.display2, text: 'Regular 45 sp'),
      TextStyleItem(
          name: 'Display 1', style: textTheme.headline, text: 'Regular 34 sp'),
      TextStyleItem(
          name: 'Title', style: textTheme.title, text: 'Medium 20 sp'),
      TextStyleItem(
          name: 'Subheading', style: textTheme.subhead, text: 'Regular 16 sp'),
      TextStyleItem(
          name: 'Body 2', style: textTheme.body2, text: 'Medium 14 sp'),
      TextStyleItem(
          name: 'Body 1', style: textTheme.body1, text: 'Regular 14 sp'),
      TextStyleItem(
          name: 'Caption', style: textTheme.caption, text: 'Regular 12 sp'),
      TextStyleItem(
          name: 'Button',
          style: textTheme.button,
          text: 'Medium(all caps) 14 sp'),
    ];
    if (MediaQuery.of(context).size.width > 500) {
      styleItems.insert(
          0,
          TextStyleItem(
              name: 'Display 4',
              style: textTheme.display4,
              text: 'Light 112 sp'));
    }
    return new Scaffold(
      appBar: AppBar(
        title: Text('Typography'),
      ),
      body: SafeArea(
          top: false,
          bottom: false,
          child: ListView(
            children: styleItems,
          )),
    );
  }
}
