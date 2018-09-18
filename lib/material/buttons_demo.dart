import 'package:flutter/material.dart';
import 'package:flutter_app/demo.dart';

const String _raisedText =
    'Raised buttons add dimension to mostly flat layouts. They emphasize '
    'functions on busy or wide spaces.';

const String _raisedCode = 'buttons_raised';

const String _flatText = 'A flat button displays an ink splash on press '
    'but does not lift. Use flat buttons on toolbars, in dialogs and '
    'inline with padding';

const String _flatCode = 'buttons_flat';

class ButtonsDemo extends StatefulWidget {
  static const String routeName = '/material/buttons';

  @override
  State<StatefulWidget> createState() {
    return ButtonsDemoState();
  }
}

class ButtonsDemoState extends State<ButtonsDemo> {
  ShapeBorder _buttonShape;

  @override
  Widget build(BuildContext context) {
    final ButtonThemeData buttonTheme =
        ButtonTheme.of(context).copyWith(shape: _buttonShape);

    final List<ComponentDemoTabData> demos = <ComponentDemoTabData>[
      ComponentDemoTabData(
        tabName: 'RAISED',
        description: _raisedText,
        demoWidget: ButtonTheme.fromButtonThemeData(
          data: buttonTheme,
          child: buildRaisedButton(),
        ),
        exampleCodeTag: _raisedCode,
      ),
      ComponentDemoTabData(
          tabName: 'Flat',
          description: _flatText,
          exampleCodeTag: _flatCode,
          demoWidget: ButtonTheme.fromButtonThemeData(
            data: buttonTheme,
            child: buildFlatButton(),
          ))
    ];

    return TabbedComponentDemoScaffold(
      title: 'Buttons',
      demos: demos,
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.sentiment_very_dissatisfied),
            onPressed: () {
              setState(() {
                _buttonShape = _buttonShape == null ? StadiumBorder() : null;
              });
            })
      ],
    );
  }
}

Widget buildRaisedButton() {
  return Align(
    alignment: const Alignment(0.0, -0.2),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ButtonBar(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RaisedButton(
              child: const Text('RAISED BUTTON'),
              onPressed: () {
                // Perform some action
              },
            ),
            const RaisedButton(
              child: Text('DISABLED'),
              onPressed: null,
            ),
          ],
        ),
        ButtonBar(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RaisedButton.icon(
              icon: const Icon(Icons.add, size: 18.0),
              label: const Text('RAISED BUTTON'),
              onPressed: () {
                // Perform some action
              },
            ),
            RaisedButton.icon(
              icon: const Icon(Icons.add, size: 18.0),
              label: const Text('DISABLED'),
              onPressed: null,
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildFlatButton() {
  return Align(
    alignment: Alignment(0.0, -0.2),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ButtonBar(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FlatButton(onPressed: () {}, child: Text('Flat Button')),
            const FlatButton(onPressed: null, child: Text('Disable'))
          ],
        ),
        ButtonBar(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FlatButton.icon(
                onPressed: () {},
                icon: Icon(Icons.add_circle_outline, size: 18.0),
                label: Text('Flat Button')),
            FlatButton.icon(
                onPressed: null,
                icon: Icon(
                  Icons.add_circle_outline,
                  size: 18.0,
                ),
                label: Text('Disable'))
          ],
        )
      ],
    ),
  );
}
