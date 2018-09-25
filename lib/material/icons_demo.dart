import 'package:flutter/material.dart';

class IconsDemo extends StatefulWidget {
  static const String routeName = '/material/icons';

  @override
  State<StatefulWidget> createState() {
    return IconsDemoState();
  }
}

class IconsDemoState extends State<IconsDemo> {
  static final List<MaterialColor> iconColors = <MaterialColor>[
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey,
  ];
  int iconColorIndex = 8; // teal

  Color get iconColor => iconColors[iconColorIndex];

  void handleIconButtonsPress() {
    setState(() {
      iconColorIndex = (iconColorIndex + 1) % iconColors.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Icons'),
      ),
      body: IconTheme(
          data: IconThemeData(color: iconColor),
          child: SafeArea(
              child: ListView(
            padding: EdgeInsets.all(24.0),
            children: <Widget>[
              _IconsDemoCard(handleIconButtonsPress,Icons.face),
              const SizedBox(height: 24.0,),
              _IconsDemoCard(handleIconButtonsPress, Icons.battery_unknown)
            ],
          ))),
    );
  }
}

class _IconsDemoCard extends StatelessWidget {
  const _IconsDemoCard(this.handleIconButtonPress, this.icon);

  final VoidCallback handleIconButtonPress;
  final IconData icon;

  Widget _buildIconButton(double iconSize, IconData icon, bool enabled) {
    return IconButton(
        icon: Icon(icon),
        iconSize: iconSize,
        tooltip: "${enabled ? 'Enabled' : 'Diabled'} icon button",
        onPressed: enabled ? handleIconButtonPress : null);
  }

  Widget _centeredText(String label) => Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          label,
          textAlign: TextAlign.center,
        ),
      );

  TableRow _buildIconRow(double size) {
    return TableRow(children: <Widget>[
      _centeredText(size.floor().toString()),
      _buildIconButton(size, icon, true),
      _buildIconButton(size, icon, false),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle textStyle =
        theme.textTheme.subhead.copyWith(color: theme.textTheme.caption.color);
    return Card(
      child: DefaultTextStyle(
        style: textStyle,
        child: Semantics(
          explicitChildNodes: true,
          child: Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: <TableRow>[
              TableRow(children: <Widget>[
                _centeredText('Size'),
                _centeredText('Enabled'),
                _centeredText('Disabled'),
              ]),
              _buildIconRow(18.0),
              _buildIconRow(24.0),
              _buildIconRow(36.0),
              _buildIconRow(48.0),
            ],
          ),
        ),
      ),
    );
  }
}
