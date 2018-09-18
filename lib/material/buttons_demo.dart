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

const String _outlineText =
    'Outline buttons become opaque and elevate when pressed. They are often '
    'paired with raised buttons to indicate an alternative, secondary action.';

const String _outlineCode = 'buttons_outline';

const String _dropdownText =
    'A dropdown button displays a menu that\'s used to select a value from a '
    'small set of values. The button displays the current value and a down '
    'arrow.';

const String _dropdownCode = 'buttons_dropdown';

const String _iconText =
    'IconButtons are appropriate for toggle buttons that allow a single choice '
    'to be selected or deselected, such as adding or removing an item\'s star.';

const String _iconCode = 'buttons_icon';

const String _actionText =
    'Floating action buttons are used for a promoted action. They are '
    'distinguished by a circled icon floating above the UI and can have motion '
    'behaviors that include morphing, launching, and a transferring anchor '
    'point.';

const String _actionCode = 'buttons_action';

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
          )),
      ComponentDemoTabData(
          tabName: 'OutLine',
          description: _outlineText,
          exampleCodeTag: _outlineCode,
          demoWidget: ButtonTheme.fromButtonThemeData(
            data: buttonTheme,
            child: buildOutLineButton(),
          )),
      ComponentDemoTabData(
        tabName: 'DROPDOWN',
        description: _dropdownText,
        demoWidget: buildDropdownButton(),
        exampleCodeTag: _dropdownCode,
      ),
      ComponentDemoTabData(
        tabName: 'ICON',
        description: _iconText,
        demoWidget: buildIconButton(),
        exampleCodeTag: _iconCode,
      ),
      ComponentDemoTabData(
        tabName: 'ACTION',
        description: _actionText,
        demoWidget: buildActionButton(),
        exampleCodeTag: _actionCode,
      ),
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

  Widget buildOutLineButton() {
    return Align(
      alignment: Alignment(0.0, -0.2),
      child: Column(
        children: <Widget>[
          ButtonBar(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              OutlineButton(
                onPressed: () {},
                child: Text('OutLine Button'),
              ),
              const OutlineButton(
                onPressed: null,
                child: Text('Disable'),
              ),
            ],
          ),
          ButtonBar(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              OutlineButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.add),
                  label: Text('OutLine Button')),
              OutlineButton.icon(
                  onPressed: null,
                  icon: Icon(Icons.add),
                  label: Text('Disable'))
            ],
          )
        ],
      ),
    );
  }

  String dropdown1Value = 'Three';
  String dropdown2Value;
  String dropdown3Value = 'Four';

  Widget buildDropdownButton() {
    return Padding(
      padding: EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ListTile(
            title: Text('Simple dropdown'),
            trailing: DropdownButton<String>(
              value: dropdown1Value,
              onChanged: (String newValue) {
                setState(() {
                  dropdown1Value = newValue;
                });
              },
              items:
                  <String>['One', 'Two', 'Three', 'Four'].map((String value) {
                return DropdownMenuItem<String>(
                  child: Text(value),
                  value: value,
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 24.0),
          ListTile(
            title: Text('Dropdown with a hint:'),
            trailing: DropdownButton<String>(
                value: dropdown2Value,
                hint: Text('Choose'),
                items:
                    <String>['One', 'Two', 'Three', 'Four'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String newValue) {
                  setState(() {
                    dropdown2Value = newValue;
                  });
                }),
          ),
          SizedBox(
            height: 24.0,
          ),
          ListTile(
            title: Text('Scrollable dropdown'),
            trailing: DropdownButton<String>(
                value: dropdown3Value,
                items: <String>[
                  'One',
                  'Two',
                  'Three',
                  'Four',
                  'Can',
                  'I',
                  'Have',
                  'A',
                  'Little',
                  'Bit',
                  'More',
                  'Five',
                  'Six',
                  'Seven',
                  'Eight',
                  'Nine',
                  'Ten'
                ].map((String vale) {
                  return DropdownMenuItem<String>(
                    child: Text(vale),
                    value: vale,
                  );
                }).toList(),
                onChanged: (String newValue) {
                  setState(() {
                    dropdown3Value = newValue;
                  });
                }),
          )
        ],
      ),
    );
  }

  bool iconButtonToggle = false;

  Widget buildIconButton() {
    return Align(
      alignment: Alignment(0.0, -0.2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.thumb_up,
              semanticLabel: 'Thumbs up',
            ),
            onPressed: () {
              setState(() {
                iconButtonToggle = !iconButtonToggle;
                ;
              });
            },
            color: iconButtonToggle ? Theme.of(context).primaryColor : null,
          ),
          IconButton(
              icon: Icon(
                Icons.thumb_up,
                semanticLabel: 'Thumbs up',
              ),
              onPressed: null)
        ].map((Widget button) {
          return SizedBox(
            width: 64.0,
            height: 64.0,
            child: button,
          );
        }).toList(),
      ),
    );
  }

  Widget buildActionButton() {
    return Align(
      alignment: Alignment(0.0, -0.2),
      child: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
