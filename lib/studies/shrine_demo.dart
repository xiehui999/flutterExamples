import 'package:flutter/material.dart';
import 'shrine_home.dart' show ShrineHome;
import 'shrine_them.dart' show ShrineTheme;

Widget buildShrine(BuildContext context, Widget child) {
  return Theme(
    data: ThemeData(
        primarySwatch: Colors.grey,
        iconTheme: IconThemeData(color: Color(0xFF707070)),
        platform: Theme.of(context).platform),
    child: ShrineTheme(child: child),
  );
}

class ShrineDemo extends StatelessWidget {
  static const String routeName = '/shrine'; // Used by the Gallery app.

  @override
  Widget build(BuildContext context) => buildShrine(context, ShrineHome());
}

class ShrinePageRoute<T> extends MaterialPageRoute<T> {
  ShrinePageRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return buildShrine(
        context, super.buildPage(context, animation, secondaryAnimation));
  }
}
