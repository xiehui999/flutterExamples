import 'package:flutter/material.dart';
import 'listItem.dart';
import 'dart:developer';

const double ItemHeight = 64.0;
const Color _kFlutterBlue = Color(0xFF003D75);

class NavigationIconView {
  NavigationIconView({
    Widget icon,
    Widget activeIcon,
    String title,
    Color color,
    TickerProvider vsync,
  })  : _icon = icon,
        _color = color,
        _title = title,
        item = new BottomNavigationBarItem(
            icon: icon,
            title: new Text(title),
            activeIcon: activeIcon,
            backgroundColor: color),
        controller = new AnimationController(
            vsync: vsync, duration: kThemeAnimationDuration) {
    _animation = new CurvedAnimation(
        parent: controller,
        curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn));
  }

  final Widget _icon;
  final Color _color;
  final String _title;
  final BottomNavigationBarItem item;
  final AnimationController controller;
  CurvedAnimation _animation;

  FadeTransition treansition(
      BottomNavigationBarType type, BuildContext context) {
    Color iconColor;
    if (type == BottomNavigationBarType.shifting) {
      iconColor = _color;
    } else {
      final ThemeData themeData = Theme.of(context);
      iconColor = themeData.brightness == Brightness.light
          ? themeData.primaryColor
          : themeData.accentColor;
    }
    return new FadeTransition(
      opacity: _animation,
      child: new SlideTransition(
        position:
            new Tween<Offset>(begin: const Offset(0.0, 0.02), end: Offset.zero)
                .animate(_animation),
        child: new IconTheme(
            data: new IconThemeData(color: iconColor, size: 120.0),
            child: new Semantics(
              label: 'Placeholder for $_title tab',
            )),
      ),
    );
  }
}

class CustomIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final IconThemeData iconThemeData = IconTheme.of(context);
    return new Container(
      margin: const EdgeInsets.all(4.0),
      width: iconThemeData.size - 8.0,
      height: iconThemeData.size - 8.0,
      color: iconThemeData.color,
    );
  }
}

class CustomInactiveIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    return new Container(
        margin: const EdgeInsets.all(4.0),
        width: iconTheme.size - 8.0,
        height: iconTheme.size - 8.0,
        decoration: new BoxDecoration(
          border: new Border.all(color: iconTheme.color, width: 2.0),
        ));
  }
}

class HomeTab extends StatefulWidget {
  static const String routeName = '/hometab'; // Used by the Gallery app.

  @override
  State<StatefulWidget> createState() {
    return new HomeTabState();
  }
}

class HomeTabState extends State<HomeTab>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  int _currentIndex = 0;
  BottomNavigationBarType _type = BottomNavigationBarType.fixed;
  List<NavigationIconView> _navigationViews;

  @override
  void initState() {
    super.initState();
    _navigationViews = <NavigationIconView>[
      new NavigationIconView(
          icon: const Icon(Icons.access_alarm),
          title: 'Style',
          color: Colors.deepPurple,
          vsync: this),
      new NavigationIconView(
          activeIcon: new CustomIcon(),
          icon: new CustomInactiveIcon(),
          title: 'Material',
          color: Colors.deepOrange,
          vsync: this),
      new NavigationIconView(
          activeIcon: const Icon(Icons.favorite),
          icon: const Icon(Icons.favorite_border),
          title: 'Cupertino',
          color: Colors.indigo,
          vsync: this),
      new NavigationIconView(
          icon: const Icon(Icons.event_available),
          title: 'Event',
          color: Colors.pink,
          vsync: this)
    ];
    for (NavigationIconView view in _navigationViews) {
      view.controller.addListener(_rebuild);
      _navigationViews[_currentIndex].controller.value = 1.0;
    }
  }

//前后台状态监听
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    ///通过state判断App前后台切换
    if (state == AppLifecycleState.resumed) {}
  }

  @override
  void dispose() {
    for (NavigationIconView view in _navigationViews) {
      view.controller.dispose();
    }
    super.dispose();
  }

  void _rebuild() {
    setState(() {
      // Rebuild in order to animate views.
    });
  }

  Widget _buildTransitionsStack() {
//    _currentIndex
    final List<FadeTransition> transitions = <FadeTransition>[];
    for (NavigationIconView view in _navigationViews) {
      transitions.add(view.treansition(_type, context));
    }
    transitions.sort((FadeTransition a, FadeTransition b) {
      final Animation<double> aAnimation = a.opacity;
      final Animation<double> bAnimation = b.opacity;
      final double aValue = aAnimation.value;
      final double bValue = bAnimation.value;
      return aValue.compareTo(bValue);
    });
    return new Stack(children: transitions);
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBar bottomNavigationBar = new BottomNavigationBar(
      items: _navigationViews.map((NavigationIconView navigationView) {
        return navigationView.item;
      }).toList(),
      currentIndex: _currentIndex,
      type: _type,
      onTap: (int index) {
        setState(() {
          _navigationViews[_currentIndex].controller.reverse();
          _currentIndex = index;
          _navigationViews[_currentIndex].controller.forward();
        });
      },
    );
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Navigation'),
        actions: <Widget>[
          new PopupMenuButton<BottomNavigationBarType>(
              onSelected: (BottomNavigationBarType value) {
            setState(() {
              _type = value;
            });
          }, itemBuilder: (BuildContext context) {
            return <PopupMenuItem<BottomNavigationBarType>>[
              PopupMenuItem<BottomNavigationBarType>(
                value: BottomNavigationBarType.fixed,
                child: new Text('Fixed'),
              ),
              PopupMenuItem<BottomNavigationBarType>(
                value: BottomNavigationBarType.shifting,
                child: new Text('Shifting'),
              )
            ];
          })
        ],
      ),
      body: IndexedStack(
        children: <Widget>[
          new Center(
            child: new TabView(
              itemType: ItemType.STYLESANDMEDIA,
            ),
          ),
          new Center(
              child: new TabView(
            itemType: ItemType.MATERIAL,
          )),
          new Center(
              child: new TabView(
            itemType: ItemType.CUPERTINO,
          )),
          new Center(
              child: new TabView(
            itemType: ItemType.STYLESANDMEDIA,
          )),
        ],
        index: _currentIndex,
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}

class ItemListView extends StatelessWidget {
  const ItemListView({Key key, this.item}) : super(key: key);
  final ListItem item;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    final double textScaleFactor = MediaQuery.textScaleFactorOf(context);
    final List<Widget> titleChildren = <Widget>[
      new Text(
        item.title,
        style: theme.textTheme.subhead
            .copyWith(color: isDark ? Colors.white : Color(0xff202124)),
      )
    ];
    if (item.subtitle != null) {
      titleChildren.add(new Text(
        item.subtitle,
        style: theme.textTheme.body1
            .copyWith(color: isDark ? Colors.white : const Color(0xff60646b)),
      ));
    }
    return new RawMaterialButton(
        padding: EdgeInsets.zero,
        splashColor: theme.primaryColor.withOpacity(0.12),
        highlightColor: Colors.transparent,
        child: new Container(
          constraints: new BoxConstraints(
            minHeight: ItemHeight * textScaleFactor,
          ),
          child: new Row(
            children: <Widget>[
              new Container(
                width: 56.0,
                height: 56.0,
                alignment: Alignment.center,
                child: new Icon(
                  item.icon,
                  size: 24.0,
                  color: isDark ? Colors.white : _kFlutterBlue,
                ),
              ),
              new Expanded(
                  child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: titleChildren,
              )),
              SizedBox(
                width: 44.0,
              )
            ],
          ),
        ),
        onPressed: () {
          Timeline.instantSync('Start Transition', arguments: <String, String>{
            'from': '/',
            'to': item.routeName,
          });
          Navigator.pushNamed(context, item.routeName);
        });
  }
}

class TabView extends StatelessWidget {
  const TabView({@required this.itemType});

  final ItemType itemType;

  @override
  Widget build(BuildContext context) {
    final double windowBottomPadding = MediaQuery.of(context).padding.bottom;

    return new Material(
      child: new Scaffold(
        body: new ListView(
          padding: new EdgeInsets.only(top: 8.0, bottom: windowBottomPadding),
          children: items
              .where((item) => item.itemType == itemType)
              .map<Widget>((ListItem item) {
            return new ItemListView(
              item: item,
            );
          }).toList(),
        ),
      ),
    );
  }
}
