import 'package:flutter/material.dart';

import 'package:flutter_app/demo.dart';

const String _checkboxText =
    'Checkboxes allow the user to select multiple options from a set. '
    'A normal checkbox\'s value is true or false and a tristate checkbox\'s '
    'value can also be null.';

const String _checkboxCode = 'selectioncontrols_checkbox';

const String _radioText =
    'Radio buttons allow the user to select one option from a set. Use radio '
    'buttons for exclusive selection if you think that the user needs to see '
    'all available options side-by-side.';

const String _radioCode = 'selectioncontrols_radio';

const String _switchText =
    'On/off switches toggle the state of a single settings option. The option '
    'that the switch controls, as well as the state it’s in, should be made '
    'clear from the corresponding inline label.';

const String _switchCode = 'selectioncontrols_switch';

class SelectionControlsDemo extends StatefulWidget {
  static const String routeName = '/material/selection-controls';

  @override
  State<StatefulWidget> createState() {
    return SelectionControlsDemoState();
  }
}

class SelectionControlsDemoState extends State<SelectionControlsDemo> {
  bool checkboxValueA = true;
  bool checkboxValueB = false;
  bool checkboxValueC;
  int radioValue = 0;
  bool switchValue = false;

  void handleRadioValueChanged(int value) {
    setState(() {
      radioValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<ComponentDemoTabData> demos = <ComponentDemoTabData>[
      ComponentDemoTabData(
        tabName: 'CheckBox',
        description: _checkboxText,
        demoWidget: buildCheckbox(),
        exampleCodeTag: _checkboxCode,
        documentationUrl:
            'https://docs.flutter.io/flutter/material/Checkbox-class.html',
      ),
      ComponentDemoTabData(
        tabName: 'Radio',
        description: _radioText,
        demoWidget: buildRadio(),
        exampleCodeTag: _radioCode,
        documentationUrl:
            'https://docs.flutter.io/flutter/material/Radio-class.html',
      ),
      ComponentDemoTabData(
        tabName: 'SWITCH',
        description: _switchText,
        demoWidget: buildSwitch(),
        exampleCodeTag: _switchCode,
        documentationUrl:
            'https://docs.flutter.io/flutter/material/Switch-class.html',
      ),
    ];
    return TabbedComponentDemoScaffold(
      title: 'Selection controls',
      demos: demos,
    );
  }

  Widget buildCheckbox() {
    return Align(
      alignment: const Alignment(0.0, -0.2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Checkbox(
              value: checkboxValueA,
              onChanged: (bool value) {
                setState(() {
                  checkboxValueA = value;
                });
              }),
          Checkbox(
              value: checkboxValueB,
              onChanged: (bool value) {
                setState(() {
                  checkboxValueB = value;
                });
              }),
//          tristate是否三种状态（value  true null false）
          Checkbox(
              value: checkboxValueC,
              tristate: true,
              onChanged: (bool value) {
                print("checkboxValueC");
                print(value);
                setState(() {
                  checkboxValueC = value;
                });
              }),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Checkbox(value: true, onChanged: null),
              Checkbox(value: false, onChanged: null),
              Checkbox(
                value: null,
                onChanged: null,
                tristate: true,
              )
            ],
          )
        ],
      ),
    );
  }

  Widget buildRadio() {
    return Align(
      alignment: Alignment(0.0, -0.2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Radio<int>(
                value: 0,
                groupValue: radioValue,
                activeColor: Colors.red,
                onChanged: handleRadioValueChanged,
              ),
              Radio<int>(
                value: 1,
                groupValue: radioValue,
                onChanged: handleRadioValueChanged,
              ),
              Radio<int>(
                value: 2,
                groupValue: radioValue,
                onChanged: handleRadioValueChanged,
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Radio<int>(
                value: 0,
                groupValue: 0,
                onChanged: null,
              ),
              Radio<int>(value: 1, groupValue: 0, onChanged: null),
              Radio<int>(value: 2, groupValue: 0, onChanged: null)
            ],
          )
        ],
      ),
    );
  }

  Widget buildSwitch() {
    return Align(
      alignment: Alignment(0.0, -0.2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Switch(
              value: switchValue,
              onChanged: (bool value) {
                setState(() {
                  switchValue = value;
                });
              }),
          const Switch(value: true, onChanged: null),
          const Switch(value: false, onChanged: null)
        ],
      ),
    );
  }
}
