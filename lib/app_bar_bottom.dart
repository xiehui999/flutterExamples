import 'package:flutter/material.dart';

// 有状态组件
class AppBarBottomSample extends StatefulWidget {
//  createStatechuag 创建所需状态
  @override
  _AppBarBottomSampleState createState() {
    return new _AppBarBottomSampleState();
  }
}

// setState更改状态setState（（）{}）,重绘组件

//State四种状态  1.created 当state对象创建的时候，State.initState()方法被调用
//2.initialized 当state对象被创建，但还么有构建时，  State.didChangeDependencies在这个时候被调用
//3.ready State对象已经被创建，State.dispose还没有被调用的时候
//4.defunct State.dispose 被调用后，State对象不能被构建
//

//完整生命周期如下：
//
//创建一个State对象时，会调用StatefulWidget.createState；
//和一个BuildContext相关联，可以认为被加载了（mounted）；
//调用initState；
//调用didChangeDependencies；
//经过上述步骤，State对象被完全的初始化了，调用build；
//如果有需要，会调用didUpdateWidget；
//如果处在开发模式，热加载会调用reassemble；
//如果它的子树（subtree）包含需要被移除的State对象，会调用deactivate；
//调用dispose,State对象以后都不会被构建；
//当调用了dispose,State对象处于未加载（unmounted），已经被dispose的State对象没有办法被重新加载（remount）。
class _AppBarBottomSampleState extends State<AppBarBottomSample>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: choices.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _nextPage(int delta) {
    final int newIndex = _tabController.index + delta;
    if (newIndex < 0 || newIndex >= _tabController.length) return;
    _tabController.animateTo(newIndex);
  }

  /**
   * MaterialApp 主要属性如下：
      title ： 在任务管理窗口中所显示的应用名字
      theme ： 应用各种 UI 所使用的主题颜色
      color ： 应用的主要颜色值（primary color），也就是安卓任务管理窗口中所显示的应用颜色
      home ： 应用默认所显示的界面 Widget
      routes ： 应用的顶级导航表格，这个是多页面应用用来控制页面跳转的，类似于网页的网址
      initialRoute ：第一个显示的路由名字，默认值为 Window.defaultRouteName
      onGenerateRoute ： 生成路由的回调函数，当导航的命名路由的时候，会使用这个来生成界面
      onLocaleChanged ： 当系统修改语言的时候，会触发å这个回调
      navigatorObservers ： 应用 Navigator 的监听器
      debugShowMaterialGrid ： 是否显示 纸墨设计 基础布局网格，用来调试 UI 的工具
      showPerformanceOverlay ： 显示性能标签，https://flutter.io/debugging/#performanceoverlay
      checkerboardRasterCacheImages 、showSemanticsDebugger、debugShowCheckedModeBanner 各种调试开关
   */
  /**
   * Scaffold
   * appBar：显示在界面顶部的一个 AppBar，也就是 Android 中的 ActionBar 、Toolbar
      body：当前界面所显示的主要内容 Widget
      floatingActionButton：纸墨设计中所定义的 FAB，界面的主要功能按钮
      persistentFooterButtons：固定在下方显示的按钮，比如对话框下方的确定、取消按钮
      drawer：侧边栏控件
      backgroundColor： 内容的背景颜色，默认使用的是 ThemeData.scaffoldBackgroundColor 的值
      bottomNavigationBar： 显示在页面底部的导航栏
      resizeToAvoidBottomPadding：类似于 Android 中的 android:windowSoftInputMode=”adjustResize”，控制界面内容 body 是否重新布局来避免底部被覆盖了，比如当键盘显示的时候，重新布局避免被键盘盖住内容。默认值为 true。
   */

  /**
   * AppBar android  TooBar
   * leading;标题前面显示的一个空间，如返回按钮
   * title:标题控件，
   * actions:一个Widget列表，常用菜单是IconButton，不常用的使用PopupMenuButton
   */
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text("AppBar Bottom Widget"),
          leading: new IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              _nextPage(-1);
            },
            tooltip: 'Previous choice',
          ),
          actions: <Widget>[
            new IconButton(
                icon: const Icon(Icons.arrow_forward),
                tooltip: 'Next choice',
                onPressed: () {
                  _nextPage(1);
                }),
            new PopupMenuButton(
              itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                    new PopupMenuItem<String>(
                        child: new Text("MENU1"), value: "menu1"),
                    new PopupMenuItem<String>(
                      child: new Text("MENU2"),
                      value: "mebu2",
                    )
                  ],
              onSelected: (String action) {
                switch (action) {
                  case "menu1":
                    break;
                  case "menu2":
                    break;
                }
              },
            )
          ],
          bottom: new PreferredSize(
              child: new Theme(
                  data: Theme.of(context).copyWith(accentColor: Colors.white),
                  child: new Container(
                    height: 48.0,
                    alignment: Alignment.center,
                    child: new TabPageSelector(
                      controller: _tabController,
                    ),
                  )),
              preferredSize: const Size.fromHeight(48.0)),
        ),
        body: new TabBarView(
            controller: _tabController,
            children: choices.map((Choice choice) {
              return new Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: new ChoiceCard(
                    choice: choice,
                  ));
            }).toList()),
      ),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = <Choice>[
  Choice(title: 'CAR', icon: Icons.directions_car),
  Choice(title: 'BICYCLE', icon: Icons.directions_bike),
  Choice(title: 'BUS', icon: Icons.directions_bus),
  Choice(title: 'TRAIN', icon: Icons.directions_railway),
  Choice(title: 'walk', icon: Icons.directions_walk)
];

//StatefulWidget   有状态组件

//StatelessWidget  无状态
class ChoiceCard extends StatelessWidget {
  final Choice choice;

  const ChoiceCard({Key key, this.choice}) : super(key: key);

//  Stack类似android FrameLayout ,
//  Table  多行多列布局（Row,Column只能实现单列）
  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return new Card(
      color: Colors.white,
      child: new Center(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Icon(
              choice.icon,
              size: 128.0,
              color: textStyle.color,
            ),
            new Text(
              choice.title,
              style: textStyle,
            )
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(new AppBarBottomSample());
}
