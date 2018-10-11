import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../demo.dart';
import 'cupertino_navigation.dart';

class CupertinoPickerDemo extends StatefulWidget {
  static const String routeName = '/cupertino/picker';

  @override
  State<StatefulWidget> createState() {
    return CupertinoPickerDemoState();
  }
}

class CupertinoPickerDemoState extends State<CupertinoPickerDemo> {
  int _selectedColorIndex = 0;
  Duration timer = Duration();
  DateTime date = DateTime.now();
  DateTime time = DateTime.now();
  DateTime dateTime = DateTime.now();

  Widget _buildMenu(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
          color: CupertinoColors.white,
          border: Border(
              top: BorderSide(color: Color(0xFFBCBBC1), width: 0.0),
              bottom: BorderSide(color: Color(0xFFBCBBC1), width: 0.0))),
      height: 44.0,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: SafeArea(
          top: false,
          bottom: false,
          child: DefaultTextStyle(
              style: TextStyle(
                  letterSpacing: -0.24,
                  fontSize: 17.0,
                  color: CupertinoColors.black),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: children,
              )),
        ),
      ),
    );
  }

  Widget _buildBottomPicker(Widget picker) {
    return Container(
      height: 216.0,
      padding: EdgeInsets.only(top: 6.0),
      color: CupertinoColors.white,
      child: DefaultTextStyle(
          style: TextStyle(color: CupertinoColors.black, fontSize: 20.0),
          child: GestureDetector(
            onTap: () {},
            child: SafeArea(
              child: picker,
              top: false,
            ),
          )),
    );
  }

  Widget _buildColorPicker(BuildContext context) {
    final FixedExtentScrollController scrollController =
        FixedExtentScrollController(initialItem: _selectedColorIndex);
    return GestureDetector(
      onTap: () async {
        await showCupertinoModalPopup(
            context: context,
            builder: (BuildContext context) {
              return _buildBottomPicker(CupertinoPicker(
                  scrollController: scrollController,
                  itemExtent: 32.0,
                  onSelectedItemChanged: (int index) {
                    setState(() {
                      _selectedColorIndex = index;
                    });
                  },
                  children:
                      List<Widget>.generate(coolColorNames.length, (int index) {
                    return Center(
                      child: Text(coolColorNames[index]),
                    );
                  })));
            });
      },
      child: _buildMenu(<Widget>[
        const Text('Favorite Color'),
        Text(
          coolColorNames[_selectedColorIndex],
          style: TextStyle(color: CupertinoColors.inactiveGray),
        )
      ]),
    );
  }

  Widget _buildCountdownTimerPicker(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showCupertinoModalPopup(
            context: context,
            builder: (BuildContext context) {
              return _buildBottomPicker(CupertinoTimerPicker(
                  initialTimerDuration: timer,
                  onTimerDurationChanged: (Duration newTimer) {
                    setState(() {
                      timer = newTimer;
                    });
                  }));
            });
      },
      child: _buildMenu(<Widget>[
        Text('Countdown Timer'),
        Text(
          '${timer.inHours}:'
              '${(timer.inMinutes % 60).toString().padLeft(2, '0')}:'
              '${(timer.inSeconds % 60).toString().padLeft(2, '0')}',
          style: const TextStyle(color: CupertinoColors.inactiveGray),
        )
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cupertino Picker'),
        actions: <Widget>[
          MaterialDemoDocumentationButton(CupertinoPickerDemo.routeName)
        ],
      ),
      body: DefaultTextStyle(
          style: TextStyle(
              fontSize: 17.0,
              color: CupertinoColors.black,
              fontFamily: '.SF UI Text'),
          child: DecoratedBox(
            decoration: BoxDecoration(color: Color(0xFFEFEFF4)),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 32.0),
                ),
                _buildColorPicker(context),
                _buildCountdownTimerPicker(context),
              ],
            ),
          )),
    );
  }
}
