import 'package:flutter/material.dart';

class NavigationIconView {
  NavigationIconView({
    Widget icon,
    Widget activeIcon,
    String title,
    Color color,
    TickerProvider vsync,
  })
      : _icon = icon,
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

  FadeTransition treansition(BottomNavigationBarType type,
      BuildContext context) {
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
  @override
  State<StatefulWidget> createState() {
    return new HomeTabState();
  }
}

class HomeTabState extends State<HomeTab>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  int _currentIndex = 0;
  BottomNavigationBarType _type = BottomNavigationBarType.shifting;
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
          title: 'Box',
          color: Colors.deepOrange,
          vsync: this),
      new NavigationIconView(
          activeIcon: const Icon(Icons.favorite),
          icon: const Icon(Icons.favorite_border),
          title: 'Favorites',
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
            child: new Tab1View(),
          ),
          new Center(
            child: new Text('2222222'),
          ),
          new Center(
            child: new Text('33333333'),
          ),
          new Center(
            child: new Text('444444'),
          ),
        ],
        index: _currentIndex,
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}

class Tab1View extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Scaffold(
      ),
    );
  }

}

void main() {
  runApp(new MaterialApp(
    title: 'HomeTab',
    home: new HomeTab(),
  ));
}
