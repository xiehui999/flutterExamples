import 'dart:math' as Math;
import 'package:flutter/material.dart';

class Category {
  const Category({this.title, this.assets});

  final String title;
  final List<String> assets;

  @override
  String toString() {
    return '$runtimeType($title)';
  }
}

const List<Category> allCategories = <Category>[
  Category(
    title: 'Accessories',
    assets: <String>[
      'assets/products/belt.png',
      'assets/products/earrings.png',
      'assets/products/backpack.png',
      'assets/products/hat.png',
      'assets/products/scarf.png',
      'assets/products/sunnies.png',
    ],
  ),
  Category(
    title: 'Blue',
    assets: <String>[
      'assets/products/backpack.png',
      'assets/products/cup.png',
      'assets/products/napkins.png',
      'assets/products/top.png',
    ],
  ),
  Category(
    title: 'Cold Weather',
    assets: <String>[
      'assets/products/jacket.png',
      'assets/products/jumper.png',
      'assets/products/scarf.png',
      'assets/products/sweater.png',
      'assets/products/sweats.png',
    ],
  ),
  Category(
    title: 'Home',
    assets: <String>[
      'assets/products/cup.png',
      'assets/products/napkins.png',
      'assets/products/planters.png',
      'assets/products/table.png',
      'assets/products/teaset.png',
    ],
  ),
  Category(
    title: 'Tops',
    assets: <String>[
      'assets/products/jumper.png',
      'assets/products/shirt.png',
      'assets/products/sweater.png',
      'assets/products/top.png',
    ],
  ),
  Category(
    title: 'Everything',
    assets: <String>[
      'assets/products/backpack.png',
      'assets/products/belt.png',
      'assets/products/cup.png',
      'assets/products/dress.png',
      'assets/products/earrings.png',
      'assets/products/flatwear.png',
      'assets/products/hat.png',
      'assets/products/jacket.png',
      'assets/products/jumper.png',
      'assets/products/napkins.png',
      'assets/products/planters.png',
      'assets/products/scarf.png',
      'assets/products/shirt.png',
      'assets/products/sunnies.png',
      'assets/products/sweater.png',
      'assets/products/sweats.png',
      'assets/products/table.png',
      'assets/products/teaset.png',
      'assets/products/top.png',
    ],
  ),
];

class CategoryView extends StatelessWidget {
  const CategoryView({Key key, this.category}) : super(key: key);
  final Category category;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return ListView(
      key: PageStorageKey<Category>(category),
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 64.0),
      children: category.assets.map<Widget>((String asset) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
              child: Container(
                width: 144.0,
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      asset,
                      fit: BoxFit.contain,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 16.0),
                      alignment: AlignmentDirectional.center,
                      child: Text(
                        asset,
                        style: themeData.textTheme.caption,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 24.0,
            )
          ],
        );
      }).toList(),
    );
  }
}

class BackdropPanel extends StatelessWidget {
  const BackdropPanel({
    Key key,
    this.onTap,
    this.onVerticalDragUpdate,
    this.onVerticalDragEnd,
    this.title,
    this.child,
  }) : super(key: key);

  final VoidCallback onTap;
  final GestureDragUpdateCallback onVerticalDragUpdate;
  final GestureDragEndCallback onVerticalDragEnd;
  final Widget title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Material(
      elevation: 2.0,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onVerticalDragUpdate: onVerticalDragUpdate,
            onVerticalDragEnd: onVerticalDragEnd,
            onTap: onTap,
            child: Container(
              height: 48.0,
              padding: EdgeInsetsDirectional.only(start: 16.0),
              alignment: AlignmentDirectional.centerStart,
              child: DefaultTextStyle(
                  style: themeData.textTheme.subhead,
                  child: Tooltip(
                    message: 'Tap to dismiss',
                    child: title,
                  )),
            ),
          ),
          Divider(
            height: 1.0,
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class BackdropTitle extends AnimatedWidget {
  const BackdropTitle({
    Key key,
    Listenable listenable,
  }) : super(key: key, listenable: listenable);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return DefaultTextStyle(
        style: Theme.of(context).primaryTextTheme.title,
        softWrap: false,
        overflow: TextOverflow.ellipsis,
        child: Stack(
          children: <Widget>[
            Opacity(
              opacity: CurvedAnimation(
                      parent: ReverseAnimation(animation),
                      curve: Interval(0.5, 1.0))
                  .value,
              child: Text('Select a Category'),
            ),
            Opacity(
              opacity:
                  CurvedAnimation(parent: animation, curve: Interval(0.5, 1.0))
                      .value,
              child: Text('Asset Viewer'),
            )
          ],
        ));
  }
}

class BackdropDemo extends StatefulWidget {
  static const String routeName = '/material/backdrop';

  @override
  BackdropDemoState createState() => BackdropDemoState();
}

class BackdropDemoState extends State<BackdropDemo>
    with SingleTickerProviderStateMixin {
  final GlobalKey _backdropkey = GlobalKey(debugLabel: 'Backdrop');
  AnimationController _controller;
  Category _category = allCategories[0];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 300), value: 1.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void changeCategory(Category category) {
    setState(() {
      _category = category;
      _controller.fling(velocity: 2.0);
    });
  }

  bool get _backdropPanelVisible {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  void _toggleBackdropPanelVisibility() {
    _controller.fling(velocity: _backdropPanelVisible ? -2.0 : 2.0);
  }

  double get _backdropHeight {
    final RenderBox renderBox = _backdropkey.currentContext.findRenderObject();
    return renderBox.size.height;
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (_controller.isAnimating ||
        _controller.status == AnimationStatus.completed) return;
    _controller.value -=
        details.primaryDelta / (_backdropHeight ?? details.primaryDelta);
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_controller.isAnimating ||
        _controller.status == AnimationStatus.completed) return;
    final double flingVelocity =
        details.velocity.pixelsPerSecond.dy / _backdropHeight;
    if (flingVelocity < 0.0)
      _controller.fling(velocity: Math.max(2.0, -flingVelocity));
    else if (flingVelocity > 0.0)
      _controller.fling(velocity: Math.min(-2.0, -flingVelocity));
    else
      _controller.fling(velocity: _controller.value < 0.5 ? -2.0 : 2.0);
  }

  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    const double panelTitleHeight = 48.0;
    final Size panelSize = constraints.biggest;
    final double panelTop = panelSize.height - panelTitleHeight;
    final Animation<RelativeRect> panelAnimation = _controller.drive(
        RelativeRectTween(
            begin: RelativeRect.fromLTRB(
                0.0,
                panelTop - MediaQuery.of(context).padding.bottom,
                0.0,
                panelTop - panelSize.height),
            end: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0)));
    final ThemeData themeData = Theme.of(context);
    final List<Widget> backdropItems =
        allCategories.map<Widget>((Category category) {
      final bool selected = category == _category;
      return Material(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4.0))),
        color: selected ? Colors.white.withOpacity(0.25) : Colors.transparent,
        child: ListTile(
          title: Text(category.title),
          selected: selected,
          onTap: () {
            changeCategory(category);
          },
        ),
      );
    }).toList();
    return Container(
      key: _backdropkey,
      color: themeData.primaryColor,
      child: Stack(
        children: <Widget>[
          ListTileTheme(
            iconColor: themeData.primaryIconTheme.color,
            textColor: themeData.primaryTextTheme.title.color.withOpacity(0.6),
            selectedColor: themeData.primaryTextTheme.title.color,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: backdropItems,
              ),
            ),
          ),
          PositionedTransition(
              rect: panelAnimation,
              child: BackdropPanel(
                onTap: _toggleBackdropPanelVisibility,
                onVerticalDragUpdate: _handleDragUpdate,
                onVerticalDragEnd: _handleDragEnd,
                title: Text(_category.title),
                child: CategoryView(
                  category: _category,
                ),
              ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: BackdropTitle(
          listenable: _controller.view,
        ),
        actions: <Widget>[
          IconButton(
              icon: AnimatedIcon(
                  icon: AnimatedIcons.close_menu, progress: _controller.view),
              onPressed: _toggleBackdropPanelVisibility)
        ],
      ),
      body: LayoutBuilder(builder: _buildStack),
    );
  }
}
