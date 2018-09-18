import 'package:flutter/material.dart';

class ButtonsDemo {
  void setState(VoidCallback callback) {}
  BuildContext context;

  void buttons() {
//START buttons_raised
    RaisedButton(child: Text('Button title'), onPressed: () {});
    const RaisedButton(child: Text('Button title'), onPressed: null);

    //with icon
    RaisedButton.icon(
        onPressed: () {}, icon: Icon(Icons.add), label: Text('Button title'));
//END

//START buttons_outline
    OutlineButton(
      onPressed: () {},
      child: Text('Button title'),
    );

    OutlineButton.icon(
        onPressed: () {},
        icon: Icon(
          Icons.add,
          size: 18.0,
        ),
        label: Text('Button title'));

//END

//START buttons_flat
    FlatButton(onPressed: () {}, child: Text('Button title'));

    const FlatButton(onPressed: null, child: Text('Button title'));
//END
//START buttons_dropdown

    String dropdownValue;
    DropdownButton<String>(
      value: dropdownValue,
      onChanged: (String newValue) {
        setState(() {
          if (newValue != null) dropdownValue = newValue;
        });
      },
      items: <String>['one', 'two'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
//END
//START
    bool value;
    IconButton(
      icon: Icon(Icons.thumb_up),
      onPressed: () {
        setState(() => value = !value);
      },
      color: value ? Theme.of(context).primaryColor : null,
    );
//END

//START buttons_action

    Scaffold(
      appBar: AppBar(
        title: Text('Demo'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.add),
      ),
    );
//END
  }
}

class SelectionControls {
  void setState(VoidCallback callback) {}

  void selectionControls() {
    bool checkboxValue = false;

// Create a checkbox.
    Checkbox(
      value: checkboxValue,
      onChanged: (bool value) {
        setState(() {
          checkboxValue = value;
        });
      },
    );

    Checkbox(
      tristate: true,
      value: checkboxValue,
      onChanged: (bool value) {
        setState(() {
          checkboxValue = value;
        });
      },
    );
    const Checkbox(value: false, onChanged: null);

    int radioValue = 0;
    void handleRadioValueChanged(int value) {
      setState(() {
        radioValue = value;
      });
    }

    Row(children: <Widget>[
      Radio<int>(
          value: 0, groupValue: radioValue, onChanged: handleRadioValueChanged),
      Radio<int>(
          value: 1, groupValue: radioValue, onChanged: handleRadioValueChanged),
      Radio<int>(
          value: 2, groupValue: radioValue, onChanged: handleRadioValueChanged)
    ]);

    const Radio<int>(value: 0, groupValue: 0, onChanged: null);

    bool switchValue = false;

// Create a switch.
    Switch(
        value: switchValue,
        onChanged: (bool value) {
          setState(() {
            switchValue = value;
          });
        });

// Create a disabled switch.
// Switches are disabled when onChanged isn't
    const Switch(value: false, onChanged: null);
  }
}
