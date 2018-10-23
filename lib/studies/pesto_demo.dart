import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

const String _kSmallLogoImage = 'assets/logo_small.png';
const double _kAppBarHeight = 128.0;
const double _kFabHalfSize = 28.0;
const double _kRecipePageMaxWidth = 500.0;

final Set<Recipe> _favoriteRecipes = Set<Recipe>();

final ThemeData _kTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.teal,
    accentColor: Colors.redAccent);

class PestoDemo extends StatelessWidget {
  const PestoDemo({Key key}) : super(key: key);
  static const String routeName = './pesto';

  @override
  Widget build(BuildContext context) {
    return PestoHome();
  }
}

class PestoHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RecipeGridPage();
  }
}

class RecipeGridPage extends StatefulWidget {
  const RecipeGridPage({Key key, this.recipes}) : super(key: key);
  final List<Recipe> recipes;

  @override
  State<StatefulWidget> createState() {
    return RecipeGridPageState();
  }
}

class RecipeGridPageState extends State<RecipeGridPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Widget _buildAppBar(BuildContext context, double statusBarHeight) {
    return SliverAppBar(
      pinned: true, // 滚动状态栏保持可见
      expandedHeight: _kAppBarHeight,
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              scaffoldKey.currentState
                  .showSnackBar(SnackBar(content: Text('Not supported')));
            })
      ],
      flexibleSpace: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        final Size size = constraints.biggest;
        final double appBarHeight = size.height - statusBarHeight;
        final double t =
            (appBarHeight - kToolbarHeight) / (_kAppBarHeight - 56.0);
        final double extraPadding =
            Tween<double>(begin: 10.0, end: 24.0).transform(t);
        final double logoHeight = appBarHeight - 1.5 * extraPadding;
        return Padding(
          padding: EdgeInsets.only(
              top: statusBarHeight + 0.5 * extraPadding, bottom: extraPadding),
          child: PestoLogo(
            height: logoHeight,
            t: t.clamp(0.0, 1.0),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Theme(
        data: _kTheme.copyWith(platform: Theme.of(context).platform),
        child: Scaffold(
          key: scaffoldKey,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              scaffoldKey.currentState
                  .showSnackBar(SnackBar(content: Text('not supported')));
            },
            child: Icon(Icons.edit),
          ),
          body: CustomScrollView(
            slivers: <Widget>[
              _buildAppBar(context, statusBarHeight),
            ],
          ),
        ));
  }
}

class PestoLogo extends StatefulWidget {
  const PestoLogo({this.height, this.t});

  final double height;
  final double t;

  @override
  PestoLogoState createState() => PestoLogoState();
}

class PestoLogoState extends State<PestoLogo> {
  static const double kLogoHeight = 162.0;
  static const double kLogoWidth = 220.0;
  static const double kImageHeight = 108.0;
  static const double kTextHeight = 48.0;
  final TextStyle titleStyle = const PestoStyle(
      fontSize: kTextHeight,
      fontWeight: FontWeight.w900,
      color: Colors.white,
      letterSpacing: 3.0);
  final RectTween _textRectTween = RectTween(
      begin: Rect.fromLTWH(0.0, kLogoHeight, kLogoWidth, kTextHeight),
      end: Rect.fromLTWH(0.0, kImageHeight, kLogoWidth, kTextHeight));
  final Curve _textOpacity = const Interval(0.4, 1.0, curve: Curves.easeInOut);
  final RectTween _imageRectTween = RectTween(
      begin: Rect.fromLTWH(0.0, 0.0, kLogoWidth, kLogoHeight),
      end: Rect.fromLTWH(0.0, 0.0, kLogoWidth, kImageHeight));

  @override
  Widget build(BuildContext context) {
    return Semantics(
      namesRoute: true,
      child: Transform(
        transform: Matrix4.identity()..scale(widget.height / kLogoHeight),
        alignment: Alignment.topCenter,
        child: Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            Positioned.fromRect(
                rect: _imageRectTween.lerp(widget.t),
                child: Image.asset(
                  _kSmallLogoImage,
                  fit: BoxFit.contain,
                )),
            Positioned.fromRect(
              rect: _textRectTween.lerp(widget.t),
              child: Opacity(
                opacity: _textOpacity.transform(widget.t),
                child: Text('PESTO',
                    style: titleStyle, textAlign: TextAlign.center),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Recipe {
  const Recipe(
      {this.name,
      this.author,
      this.description,
      this.imagePath,
      this.imagePackage,
      this.ingredientsImagePath,
      this.ingredientsImagePackage,
      this.ingredients,
      this.steps});

  final String name;
  final String author;
  final String description;
  final String imagePath;
  final String imagePackage;
  final String ingredientsImagePath;
  final String ingredientsImagePackage;
  final List<RecipeIngredient> ingredients;
  final List<RecipeStep> steps;
}

class RecipeIngredient {
  const RecipeIngredient({this.amount, this.description});

  final String amount;
  final String description;
}

class RecipeStep {
  const RecipeStep({this.duration, this.description});

  final String duration;
  final String description;
}

class PestoStyle extends TextStyle {
  const PestoStyle({
    double fontSize = 12.0,
    FontWeight fontWeight,
    Color color = Colors.black87,
    double letterSpacing,
    double height,
  }) : super(
          inherit: false,
          color: color,
          fontFamily: 'Raleway',
          fontSize: fontSize,
          fontWeight: fontWeight,
          textBaseline: TextBaseline.alphabetic,
          letterSpacing: letterSpacing,
          height: height,
        );
}
