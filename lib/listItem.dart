import 'package:flutter/material.dart';
import 'typography_demo.dart';
import 'colors_demo.dart';
import 'material/modal_bottom_sheet_demo.dart';
import 'material/persistent_bottom_sheet.dart';
import 'material/buttons_demo.dart';
import 'material/tabs_fab_demo.dart';
import 'material/cards_demo.dart';
import 'material/elevation_demo.dart';
import 'material/dialog_demo.dart';
import 'material/icons_demo.dart';
import 'material/menu_demo.dart';
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
    title: 'buttons',
    subtitle: 'Flat, raised, dropdown, and more',
    icon: Icons.update,
    itemType: ItemType.MATERIAL,
    routeName: ButtonsDemo.routeName,
    buildRoute: (BuildContext context) => new ButtonsDemo(),
  ),
  new ListItem(
    title: 'Buttons: Floating Action Button',
    subtitle: 'FAB with transitions',
    icon: Icons.line_style,
    itemType: ItemType.MATERIAL,
    routeName: TabsFabDemo.routeName,
    buildRoute: (BuildContext context) => new TabsFabDemo(),
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
    icon: Icons.euro_symbol,
    itemType: ItemType.MATERIAL,
    routeName: PersistentBottomSheet.routeName,
    buildRoute: (BuildContext context) => new PersistentBottomSheet(),
  ),
  new ListItem(
    title: 'Cards',
    subtitle: 'Baseline cards with rounded corners',
    icon: Icons.donut_small,
    itemType: ItemType.MATERIAL,
    routeName: CardsDemo.routeName,
    buildRoute: (BuildContext context) => new CardsDemo(),
  ),
  new ListItem(
    title: 'Dialog',
    subtitle: 'dialog',
    icon: Icons.important_devices,
    itemType: ItemType.MATERIAL,
    routeName: DialogDemo.routeName,
    buildRoute: (BuildContext context) => new DialogDemo(),
  ),
  new ListItem(
    title: 'Elevations',
    subtitle: 'Shadow values on Cards',
    icon: Icons.rounded_corner,
    itemType: ItemType.MATERIAL,
    routeName: ElevationDemo.routeName,
    buildRoute: (BuildContext context) => ElevationDemo(),
  ),
  new ListItem(
    title: 'Icons',
    subtitle: 'Enabled and disabled icons with opacity',
    icon: Icons.play_for_work,
    itemType: ItemType.MATERIAL,
    routeName: IconsDemo.routeName,
    buildRoute: (BuildContext context) => IconsDemo(),
  ),
  new ListItem(
    title: 'Menus',
    subtitle: 'Menu buttons and simple menus',
    icon: Icons.all_out,
    itemType: ItemType.MATERIAL,
    routeName: MenuDemo.routeName,
    buildRoute: (BuildContext context) => MenuDemo(),
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
