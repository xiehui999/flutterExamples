import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/demo.dart';

class CupertinoAlertDemo extends StatefulWidget {
  static const String routeName = '/cupertino/alert';

  @override
  State<StatefulWidget> createState() {
    return CupertinoAlertDemoState();
  }
}

class CupertinoAlertDemoState extends State<CupertinoAlertDemo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void showDemoDialog<T>({BuildContext context, Widget child}) {
    //barrierDismissible  点击蒙版是否关闭Dialog默认true，
    showDialog<T>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => child).then<void>((T value) {
      if (value != null) {
        _scaffoldKey.currentState
            .showSnackBar(SnackBar(content: Text('You selected:${value}')));
      }
    });
  }

  void showDemoActionSheet<T>({BuildContext context, Widget child}) {
    showCupertinoModalPopup<T>(
        context: context,
        builder: (BuildContext context) => child).then<void>((T value) {
      if (value != null) {
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text('You selected: $value'),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Cupertino Alerts'),
        actions: <Widget>[
          MaterialDemoDocumentationButton(CupertinoAlertDemo.routeName)
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 72.0),
        children: <Widget>[
          CupertinoButton(
              child: Text('Alert'),
              color: CupertinoColors.activeBlue,
              onPressed: () {
                showDemoDialog<String>(
                    context: context,
                    child: CupertinoAlertDialog(
                      content: Text('Discard draft?'),
                      actions: <Widget>[
                        CupertinoDialogAction(
                          child: Text('Discard'),
                          isDestructiveAction: true,
                          onPressed: () {
                            Navigator.pop(context, 'Discard');
                          },
                        ),
                        CupertinoDialogAction(
                          child: const Text('Cancel'),
                          isDefaultAction: true,
                          onPressed: () {
                            Navigator.pop(context, 'Cancel');
                          },
                        ),
                      ],
                    ));
              }),
          const Padding(padding: EdgeInsets.all(8.0)),
          CupertinoButton(
            child: Text('Alert with Title'),
            color: CupertinoColors.activeBlue,
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 36.0),
            onPressed: () {
              showDemoDialog<String>(
                  context: context,
                  child: CupertinoAlertDialog(
                    title: Text(
                        'Allow "Maps" to access your location while you are using the app?'),
                    content: const Text(
                        'Your current location will be displayed on the map and used '
                        'for directions, nearby search results, and estimated travel times.'),
                    actions: <Widget>[
                      CupertinoDialogAction(
                        child: Text('Don\'t Allow'),
                        onPressed: () {
                          Navigator.pop(context, 'Disallow');
                        },
                      ),
                      CupertinoDialogAction(
                        child: Text('Allow'),
                        onPressed: () {
                          Navigator.pop(context, 'Allow');
                        },
                      )
                    ],
                  ));
            },
          ),
          const Padding(padding: EdgeInsets.all(8.0)),
          CupertinoButton(
              child: Text('Alert with Buttons'),
              color: CupertinoColors.activeBlue,
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 36.0),
              onPressed: () {
                showDemoDialog<String>(
                    context: context,
                    child: CupertinoDessertDialog(
                      title: Text('Select Favorite Dessert'),
                      content: Text(
                          'Please select your favorite type of dessert from the '
                          'list below. Your selection will be used to customize the suggested '
                          'list of eateries in your area.'),
                    ));
              }),
          const Padding(padding: EdgeInsets.all(8.0)),
          CupertinoButton(
              child: Text('Alert Buttons only'),
              color: CupertinoColors.activeBlue,
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 36.0),
              onPressed: () {
                showDemoDialog(
                    context: context, child: CupertinoDessertDialog());
              }),
          const Padding(padding: EdgeInsets.all(8.0)),
          CupertinoButton(
              child: Text('Action Sheet'),
              color: CupertinoColors.activeBlue,
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 36.0),
              onPressed: () {
                showDemoActionSheet<String>(
                    context: context,
                    child: CupertinoActionSheet(
                      title: Text('Favorite Dessert'),
                      message: Text(
                          'Please select the best dessert from the options below.'),
                      actions: <Widget>[
                        CupertinoActionSheetAction(
                            onPressed: () {
                              Navigator.pop(context, 'Profiteroles');
                            },
                            child: Text('Profiteroles')),
                        CupertinoActionSheetAction(
                            onPressed: () {
                              Navigator.pop(context, 'Cannolis');
                            },
                            child: Text('Cannolis')),
                        CupertinoActionSheetAction(
                            onPressed: () {
                              Navigator.pop(context, 'Trifle');
                            },
                            child: Text('Trifle')),
                        CupertinoActionSheetAction(
                            onPressed: () {
                              Navigator.pop(context, 'Cancel');
                            },
                            isDefaultAction: true,
                            child: Text('Cancel'))
                      ],
                    ));
              })
        ],
      ),
    );
  }
}

class CupertinoDessertDialog extends StatelessWidget {
  const CupertinoDessertDialog({Key key, this.title, this.content})
      : super(key: key);
  final Widget title;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: title,
      content: content,
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text('Cheesecake'),
          onPressed: () {
            Navigator.pop(context, 'Cheesecake');
          },
        ),
        CupertinoDialogAction(
          child: Text('Tiramisu'),
          onPressed: () {
            Navigator.pop(context, 'Tiramisu');
          },
        ),
        CupertinoDialogAction(
          child: Text('Apple Pie'),
          onPressed: () {
            Navigator.pop(context, 'Apple Pie');
          },
        ),
        CupertinoDialogAction(
          child: Text("Devil's food cake"),
          onPressed: () {
            Navigator.pop(context, "Devil's food cake");
          },
        ),
        CupertinoDialogAction(
          child: Text('Banana Split'),
          onPressed: () {
            Navigator.pop(context, 'Banana Split');
          },
        ),
        CupertinoDialogAction(
          child: Text('Oatmeal Cookie'),
          onPressed: () {
            Navigator.pop(context, 'Oatmeal Cookie');
          },
        ),
        CupertinoDialogAction(
          child: Text('Chocolate Brownie'),
          onPressed: () {
            Navigator.pop(context, 'Chocolate Brownie');
          },
        ),
        CupertinoDialogAction(
          child: Text('Cancel'),
          isDestructiveAction: true,
          onPressed: () {
            Navigator.pop(context, 'Cancel');
          },
        )
      ],
    );
  }
}
