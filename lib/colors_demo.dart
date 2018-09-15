import 'package:flutter/material.dart';

const double ItemHeight = 48.0;

class Palette {
  Palette({this.name, this.primary, this.accent, this.thrshold = 900});

  final String name;
  final MaterialColor primary;
  final MaterialAccentColor accent;
  final int thrshold;

  bool get isValid => name != null && primary != null && thrshold != null;
}

final List<Palette> allPalettes = <Palette>[
  Palette(
      name: 'red',
      primary: Colors.red,
      accent: Colors.redAccent,
      thrshold: 300),
  Palette(
      name: 'pink',
      primary: Colors.pink,
      accent: Colors.pinkAccent,
      thrshold: 200),
  Palette(
      name: 'purple',
      primary: Colors.purple,
      accent: Colors.purpleAccent,
      thrshold: 200),
  Palette(
      name: 'deepPurple',
      primary: Colors.deepPurple,
      accent: Colors.deepPurpleAccent,
      thrshold: 200),
  Palette(
      name: 'indigo',
      primary: Colors.indigo,
      accent: Colors.indigoAccent,
      thrshold: 200),
  Palette(
      name: 'blue',
      primary: Colors.blue,
      accent: Colors.blueAccent,
      thrshold: 400),
  Palette(
      name: 'lightBlue',
      primary: Colors.lightBlue,
      accent: Colors.lightBlueAccent,
      thrshold: 500),
  Palette(
      name: 'cyan',
      primary: Colors.cyan,
      accent: Colors.cyanAccent,
      thrshold: 600),
  Palette(
      name: 'teal',
      primary: Colors.teal,
      accent: Colors.tealAccent,
      thrshold: 400),
  Palette(
      name: 'green',
      primary: Colors.green,
      accent: Colors.greenAccent,
      thrshold: 500),
  Palette(
      name: 'lightGreen',
      primary: Colors.lightGreen,
      accent: Colors.lightGreenAccent,
      thrshold: 600),
  Palette(
      name: 'lime',
      primary: Colors.lime,
      accent: Colors.limeAccent,
      thrshold: 800),
  Palette(name: 'yellow', primary: Colors.yellow, accent: Colors.yellowAccent),
  Palette(name: 'amber', primary: Colors.amber, accent: Colors.amberAccent),
  Palette(
      name: 'orange',
      primary: Colors.orange,
      accent: Colors.orangeAccent,
      thrshold: 700),
  Palette(
      name: 'deepOrange',
      primary: Colors.deepOrange,
      accent: Colors.deepOrangeAccent,
      thrshold: 400),
  Palette(name: 'brown', primary: Colors.brown, thrshold: 200),
  Palette(name: 'grey', primary: Colors.grey, thrshold: 500),
  Palette(name: 'blueGrey', primary: Colors.blueGrey, thrshold: 500),
];

class ColorItem extends StatelessWidget {
  const ColorItem(
      {Key key, @required this.index, @required this.color, this.prefix = ''})
      : assert(index != null),
        assert(color != null),
        assert(prefix != null),
        super(key: key);

  final int index;
  final Color color;
  final String prefix;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      child: Container(
        height: ItemHeight,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        color: color,
        child: SafeArea(
            top: false,
            bottom: false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[Text('$prefix$index'), Text(colorString())],
            )),
      ),
    );
  }

  String colorString() {
    return "#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
  }
}

class PaletteTabView extends StatelessWidget {
  static const List<int> primaryKeys = <int>[
    50,
    100,
    200,
    300,
    400,
    500,
    600,
    700,
    800,
    900,
  ];
  static const List<int> accentKeys = <int>[100, 200, 400, 700];

  PaletteTabView({Key key, @required this.palette})
      : assert(palette != null && palette.isValid),
        super(key: key);

  final Palette palette;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final TextStyle whiteTextStyle =
        textTheme.body1.copyWith(color: Colors.white);
    final TextStyle blackTextStyle =
        textTheme.body1.copyWith(color: Colors.black);
    final List<Widget> colorItems = primaryKeys.map((int index) {
      return DefaultTextStyle(
          style: index > palette.thrshold ? whiteTextStyle : blackTextStyle,
          child: ColorItem(index: index, color: palette.primary[index]));
    }).toList();
    if (palette.accent != null) {
      colorItems.addAll(accentKeys.map((int index) {
        return DefaultTextStyle(
            style: index > palette.thrshold ? whiteTextStyle : blackTextStyle,
            child: ColorItem(index: index, color: palette.primary[index]));
      }).toList());
    }
    return ListView(
      itemExtent: ItemHeight,
      children: colorItems,
    );
  }
}

class ColorsDemo extends StatelessWidget {
  static const String routeName = '/colors';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: allPalettes.length,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: Text('Color'),
            bottom: TabBar(
                isScrollable: true,
                tabs: allPalettes.map((Palette swatch) {
                  return Tab(
                    text: swatch.name,
                  );
                }).toList()),
          ),
          body: TabBarView(
              children: allPalettes.map((Palette colors) {
            return PaletteTabView(palette: colors);
          }).toList()),
        ));
  }
}
