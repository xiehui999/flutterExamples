import 'package:flutter/material.dart';
import 'typography_demo.dart';

enum ItemType { STYLES }

final List<ListItem> items = <ListItem>[
  new ListItem(
    title: 'Colors',
    subtitle: 'All of the predefined colors',
    icon: Icons.compare_arrows,
    itemType: ItemType.STYLES,
    routeName: TypographyDemo.routeName,
    builderRoute: (BuildContext context) => new TypographyDemo(),
  )
];

class ListItem {
  const ListItem(
      {this.title,
      this.subtitle,
      this.icon,
      this.itemType,
      this.routeName,
      this.builderRoute});

  final String title;
  final IconData icon;
  final String subtitle;
  final ItemType itemType;
  final String routeName;
  final WidgetBuilder builderRoute;
}
