import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter_app/home_bottom_navigation.dart';
import 'package:flutter_app/cupertino/cupertino_navigation.dart';
import 'typography_demo.dart';
void main() => runApp(new FlutterView());

TextTheme _buildTextTheme(TextTheme base) {
  return base.copyWith(title: base.title.copyWith(fontFamily: 'GoogleSans'));
}

ThemeData _buildLightTheme() {
  const Color primaryColor = Color(0xFF0175C2);
  final ThemeData base = new ThemeData.light();
  return base.copyWith(
    primaryColor: primaryColor,
    buttonColor: primaryColor,
    indicatorColor: Colors.white,
    splashColor: Colors.white24,
    splashFactory: InkRipple.splashFactory,
    accentColor: const Color(0xFF13B9FD),
    canvasColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    backgroundColor: Colors.white,
    errorColor: const Color(0xFFB00020),
    buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
    textTheme: _buildTextTheme(base.textTheme),
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildTextTheme(base.accentTextTheme),
  );
}

class FlutterView extends StatelessWidget {
  /**
   * title:任务窗口显示的标题，
   * routes
      定义应用中页面跳转规则。 该对象是一个 Map<String, WidgetBuilder>，使用 Navigator.pushNamed 来路由的时候，会在 routes 查找路由名字
      然后使用 对应的 WidgetBuilder 来构造一个带有页面切换动画的 MaterialPageRoute。如果应用只有一个界面，则不用设置这个属性，使用 home 设置这个界面即可
      ROUTES 通过Navigator.defaultRouteName指定默认路由，此时，不能再添加home，否则报错
   */

  Map<String, WidgetBuilder> _routes = <String, WidgetBuilder>{
    Navigator.defaultRouteName: (context) => new SplashPage(),
    HomeTab.routeName: (BuildContext context) => new HomeTab(),
    TypographyDemo.routeName: (BuildContext context) => new TypographyDemo(),
  };



  /**
   * showPerformanceOverlay:是否显示性能监视器
   *
   */

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter View',
      theme: _buildLightTheme(),
      showPerformanceOverlay: false,
      routes: _routes,
      builder: (BuildContext contex, Widget child) {
//        textDirection设置方向
//      textScaleFactor可以设置全局字体大小
        return new Directionality(
            textDirection: TextDirection.ltr,
            child: new Builder(builder: (BuildContext context) {
              return new MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: child);
            }));
      },
//      home: new SplashPage(),
    );
  }
}

class SplashPage extends StatefulWidget {
  @override
  SplashPageState createState() => new SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  static const String _channel = 'increment';
  static const String _pong = 'pong';
  static const String _emptyMessage = '';
  static const BasicMessageChannel<String> platform =
      BasicMessageChannel<String>(_channel, StringCodec());
  int _counter = 0;
  Timer timer;

  @override
  void initState() {
    super.initState();
    timer = new Timer(new Duration(milliseconds: 1500), () {
//      Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (context) => new CupertinoNavigation()
      Navigator.of(context).pushAndRemoveUntil(
          new MaterialPageRoute(builder: (context) => new HomeTab()),
          (route) => route == null);
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    timer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Color(0xffffffff),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Flutter Demo',
            style: TextStyle(
                color: Color(0xff70C2F0),
                fontWeight: FontWeight.bold,
                fontSize: 26.0),
          ),
          new Padding(padding: EdgeInsets.only(top: 30.0)),
          new Image.asset(
            'assets/flutter-mark-square-64.png',
          )
        ],
      ),
    );
  }
}
