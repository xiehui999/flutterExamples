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
    return RecipeGridPage(
      recipes: kPestoRecipes,
    );
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
        print("1111111");
        print(appBarHeight);
        final double t =
            (appBarHeight - kToolbarHeight) / (_kAppBarHeight - kToolbarHeight);
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

  Widget _buildBody(BuildContext context, double statusBarHeight) {
    final EdgeInsets mediaPadding = MediaQuery.of(context).padding;
    final EdgeInsets padding = EdgeInsets.only(
        top: 8.0,
        left: 8.0 + mediaPadding.left,
        right: 8.0 + mediaPadding.right,
        bottom: 8.0);
    return SliverPadding(
      padding: padding,
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          final Recipe recipe = widget.recipes[index];
          return RecipeCard(
            recipe: recipe,
            onTap: () {
              showRecipePage(context, recipe);
            },
          );
        }, childCount: widget.recipes.length),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: _kRecipePageMaxWidth,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0),
      ),
    );
  }

  void showRecipePage(BuildContext context, Recipe recipe) {
    Navigator.push(
        context,
        MaterialPageRoute(
            settings: RouteSettings(name: '/pesto/recipe'),
            builder: (BuildContext context) {
              return Theme(
                child: RecipePage(
                  recipe: recipe,
                ),
                data: _kTheme.copyWith(platform: Theme.of(context).platform),
              );
            }));
  }

  @override
  Widget build(BuildContext context) {
    //获取状态栏高度
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    print("statusBarHeight");
    print(statusBarHeight);
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
              _buildBody(context, statusBarHeight),
            ],
          ),
        ));
  }
}

class RecipeCard extends StatelessWidget {
  const RecipeCard({Key key, this.recipe, this.onTap}) : super(key: key);
  final Recipe recipe;
  final VoidCallback onTap;

  TextStyle get titleStyle =>
      const PestoStyle(fontSize: 24.0, fontWeight: FontWeight.w600);

  TextStyle get authorStyle =>
      const PestoStyle(fontWeight: FontWeight.w500, color: Colors.black54);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
                tag: 'packages/${recipe.imagePath}',
                child: AspectRatio(
                  aspectRatio: 4.0 / 3.0,
                  child: Image.asset(
                    recipe.imagePath,
                    fit: BoxFit.cover,
                    semanticLabel: recipe.name,
                  ),
                )),
            Expanded(
                child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Image.asset(
                    recipe.ingredientsImagePath,
                    width: 48.0,
                    height: 48.0,
                  ),
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      recipe.name,
                      style: titleStyle,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      recipe.author,
                      style: authorStyle,
                    )
                  ],
                ))
              ],
            ))
          ],
        ),
      ),
    );
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

const List<Recipe> kPestoRecipes = <Recipe>[
  Recipe(
    name: 'Roasted Chicken',
    author: 'Peter Carlsson',
    ingredientsImagePath: 'assets/food/icons/main.png',
    description:
        'The perfect dish to welcome your family and friends with on a crisp autumn night. Pair with roasted veggies to truly impress them.',
    imagePath: 'assets/food/roasted_chicken.png',
    ingredients: <RecipeIngredient>[
      RecipeIngredient(amount: '1 whole', description: 'Chicken'),
      RecipeIngredient(amount: '1/2 cup', description: 'Butter'),
      RecipeIngredient(amount: '1 tbsp', description: 'Onion powder'),
      RecipeIngredient(amount: '1 tbsp', description: 'Freshly ground pepper'),
      RecipeIngredient(amount: '1 tsp', description: 'Salt'),
    ],
    steps: <RecipeStep>[
      RecipeStep(duration: '1 min', description: 'Put in oven'),
      RecipeStep(duration: '1hr 45 min', description: 'Cook'),
    ],
  ),
  Recipe(
    name: 'Chopped Beet Leaves',
    author: 'Trevor Hansen',
    ingredientsImagePath: 'assets/food/icons/veggie.png',
    description:
        'This vegetable has more to offer than just its root. Beet greens can be tossed into a salad to add some variety or sauteed on its own with some oil and garlic.',
    imagePath: 'assets/food/chopped_beet_leaves.png',
    ingredients: <RecipeIngredient>[
      RecipeIngredient(amount: '3 cups', description: 'Beet greens'),
    ],
    steps: <RecipeStep>[
      RecipeStep(duration: '5 min', description: 'Chop'),
    ],
  ),
  Recipe(
    name: 'Pesto Pasta',
    author: 'Ali Connors',
    ingredientsImagePath: 'assets/food/icons/main.png',
    description:
        'With this pesto recipe, you can quickly whip up a meal to satisfy your savory needs. And if you\'re feeling festive, you can add bacon to taste.',
    imagePath: 'assets/food/pesto_pasta.png',
    ingredients: <RecipeIngredient>[
      RecipeIngredient(amount: '1/4 cup ', description: 'Pasta'),
      RecipeIngredient(amount: '2 cups', description: 'Fresh basil leaves'),
      RecipeIngredient(amount: '1/2 cup', description: 'Parmesan cheese'),
      RecipeIngredient(
          amount: '1/2 cup', description: 'Extra virgin olive oil'),
      RecipeIngredient(amount: '1/3 cup', description: 'Pine nuts'),
      RecipeIngredient(amount: '1/4 cup', description: 'Lemon juice'),
      RecipeIngredient(amount: '3 cloves', description: 'Garlic'),
      RecipeIngredient(amount: '1/4 tsp', description: 'Salt'),
      RecipeIngredient(amount: '1/8 tsp', description: 'Pepper'),
      RecipeIngredient(amount: '3 lbs', description: 'Bacon'),
    ],
    steps: <RecipeStep>[
      RecipeStep(duration: '15 min', description: 'Blend'),
    ],
  ),
  Recipe(
    name: 'Cherry Pie',
    author: 'Sandra Adams',
    ingredientsImagePath: 'assets/food/icons/main.png',
    description:
        'Sometimes when you\'re craving some cheer in your life you can jumpstart your day with some cherry pie. Dessert for breakfast is perfectly acceptable.',
    imagePath: 'assets/food/cherry_pie.png',
    ingredients: <RecipeIngredient>[
      RecipeIngredient(amount: '1', description: 'Pie crust'),
      RecipeIngredient(
          amount: '4 cups', description: 'Fresh or frozen cherries'),
      RecipeIngredient(amount: '1 cup', description: 'Granulated sugar'),
      RecipeIngredient(amount: '4 tbsp', description: 'Cornstarch'),
      RecipeIngredient(amount: '1½ tbsp', description: 'Butter'),
    ],
    steps: <RecipeStep>[
      RecipeStep(duration: '15 min', description: 'Mix'),
      RecipeStep(duration: '1hr 30 min', description: 'Bake'),
    ],
  ),
  Recipe(
    name: 'Spinach Salad',
    author: 'Peter Carlsson',
    ingredientsImagePath: 'assets/food/icons/spicy.png',
    description:
        'Everyone\'s favorite leafy green is back. Paired with fresh sliced onion, it\'s ready to tackle any dish, whether it be a salad or an egg scramble.',
    imagePath: 'assets/food/spinach_onion_salad.png',
    ingredients: <RecipeIngredient>[
      RecipeIngredient(amount: '4 cups', description: 'Spinach'),
      RecipeIngredient(amount: '1 cup', description: 'Sliced onion'),
    ],
    steps: <RecipeStep>[
      RecipeStep(duration: '5 min', description: 'Mix'),
    ],
  ),
  Recipe(
    name: 'Butternut Squash Soup',
    author: 'Ali Connors',
    ingredientsImagePath: 'assets/food/icons/healthy.png',
    description:
        'This creamy butternut squash soup will warm you on the chilliest of winter nights and bring a delightful pop of orange to the dinner table.',
    imagePath: 'assets/food/butternut_squash_soup.png',
    ingredients: <RecipeIngredient>[
      RecipeIngredient(amount: '1', description: 'Butternut squash'),
      RecipeIngredient(amount: '4 cups', description: 'Chicken stock'),
      RecipeIngredient(amount: '2', description: 'Potatoes'),
      RecipeIngredient(amount: '1', description: 'Onion'),
      RecipeIngredient(amount: '1', description: 'Carrot'),
      RecipeIngredient(amount: '1', description: 'Celery'),
      RecipeIngredient(amount: '1 tsp', description: 'Salt'),
      RecipeIngredient(amount: '1 tsp', description: 'Pepper'),
    ],
    steps: <RecipeStep>[
      RecipeStep(duration: '10 min', description: 'Prep vegetables'),
      RecipeStep(duration: '5 min', description: 'Stir'),
      RecipeStep(duration: '1 hr 10 min', description: 'Cook')
    ],
  ),
  Recipe(
    name: 'Spanakopita',
    author: 'Trevor Hansen',
    ingredientsImagePath: 'assets/food/icons/quick.png',
    description:
        'You \'feta\' believe this is a crowd-pleaser! Flaky phyllo pastry surrounds a delicious mixture of spinach and cheeses to create the perfect appetizer.',
    imagePath: 'assets/food/spanakopita.png',
    ingredients: <RecipeIngredient>[
      RecipeIngredient(amount: '1 lb', description: 'Spinach'),
      RecipeIngredient(amount: '½ cup', description: 'Feta cheese'),
      RecipeIngredient(amount: '½ cup', description: 'Cottage cheese'),
      RecipeIngredient(amount: '2', description: 'Eggs'),
      RecipeIngredient(amount: '1', description: 'Onion'),
      RecipeIngredient(amount: '½ lb', description: 'Phyllo dough'),
    ],
    steps: <RecipeStep>[
      RecipeStep(duration: '5 min', description: 'Sauté vegetables'),
      RecipeStep(
          duration: '3 min',
          description: 'Stir vegetables and other filling ingredients'),
      RecipeStep(
          duration: '10 min',
          description: 'Fill phyllo squares half-full with filling and fold.'),
      RecipeStep(duration: '40 min', description: 'Bake')
    ],
  ),
];

class RecipePage extends StatefulWidget {
  const RecipePage({Key key, this.recipe}) : super(key: key);
  final Recipe recipe;

  @override
  State<StatefulWidget> createState() {
    return RecipePageState();
  }
}

class RecipePageState extends State<RecipePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextStyle menuItemStyle =
      const PestoStyle(fontSize: 15.0, color: Colors.black54, height: 24.0);

  double _getAppBarHeight(BuildContext context) =>
      MediaQuery.of(context).size.height * 0.3;

  @override
  Widget build(BuildContext context) {
    final double appBarHeight = _getAppBarHeight(context);
    final Size screenSize = MediaQuery.of(context).size;
    final bool fullWidth = screenSize.width < _kRecipePageMaxWidth;
    final bool isFavorite = _favoriteRecipes.contains(widget.recipe);
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              height: appBarHeight + _kFabHalfSize,
              //tag实现页面共享元素过度动画
              child: Hero(
                  tag: 'packages/${widget.recipe.imagePath}',
                  child: Image.asset(widget.recipe.imagePath,
                      fit: fullWidth ? BoxFit.fitWidth : BoxFit.cover)))
        ],
      ),
    );
  }
}
