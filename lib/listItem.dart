import 'package:flutter/material.dart';
import 'typography_demo.dart';
import 'colors_demo.dart';
import 'material/modal_bottom_sheet_demo.dart';
import 'material/persistent_bottom_sheet.dart';

enum ItemType { STYLES, MATERIAL }

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
  ),
  new ListItem(
    title: 'Bottom sheet:Modal',
    subtitle: 'A dismissable bottom sheet',
    icon: Icons.line_weight,
    itemType: ItemType.MATERIAL,
    routeName: ModalBottomSheet.routeName,
    buildRoute: (BuildContext context) => new ModalBottomSheet(),
  ),
  new ListItem(
    title: 'Bottom sheet:Persistent',
    subtitle: 'A bottom sheet that sticks around',
    icon: Icons.line_weight,
    itemType: ItemType.MATERIAL,
    routeName: PersistentBottomSheet.routeName,
    buildRoute: (BuildContext context) => new PersistentBottomSheet(),
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
