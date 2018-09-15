import 'package:flutter/material.dart';
import 'typography_demo.dart';
import 'colors_demo.dart';

enum ItemType { STYLES }

final List<ListItem> items = <ListItem>[
  new ListItem(
    title: 'Colors',
    subtitle: 'All of the predefined colors',
    icon: Icons.compare_arrows,
    itemType: ItemType.STYLES,
    routeName: ColorsDemo.routeName,
    buildRoute: (BuildContext context) => new ColorsDemo(),
  ),
  new ListItem(
    title: 'Typography',
    subtitle: 'All of the predefined text styles',
    icon: Icons.accessible,
    itemType: ItemType.STYLES,
    routeName: TypographyDemo.routeName,
    buildRoute: (BuildContext context) => new TypographyDemo(),
  )
];



class ListItem {
  const ListItem(
      {this.title,
      this.subtitle,
      this.icon,
      this.itemType,
      this.routeName,
      this.buildRoute});

  final String title;
  final IconData icon;
  final String subtitle;
  final ItemType itemType;
  final String routeName;
  final WidgetBuilder buildRoute;
}
