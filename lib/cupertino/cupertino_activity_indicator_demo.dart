import 'package:flutter/cupertino.dart';
import 'package:flutter_app/demo.dart';

class CupertinoProgressIndicatorDemo extends StatelessWidget {
  static const String routeName = '/cupertino/progress_indicator';

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          previousPageTitle: 'Cupertino',
          middle: Text('Cupertino Activity Indicator'),
          trailing: CupertinoDemoDocumentationButton(routeName),
        ),
        child: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CupertinoActivityIndicator(),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            CupertinoActivityIndicator(
              animating: false,
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            CupertinoActivityIndicator(radius: 30.0),
          ],
        )));
  }
}
