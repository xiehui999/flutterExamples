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
import 'material/page_selector_demo.dart';
import 'material/progress_indicator_demo.dart';
import 'material/tooltip_demo.dart';
import 'material/snack_bar_demo.dart';
import 'material/date_and_time_picker_demo.dart';
import 'material/chip_demo.dart';
import 'material/data_table_demo.dart';
import 'material/two_level_list_demo.dart';
import 'material/overscroll_demo.dart';
import 'material/slide_demo.dart';
import 'material/tabs_demo.dart';
import 'material/scrollable_tabs_demo.dart';
import 'material/selection_controls_demo.dart';
import 'material/drawer_demo.dart';

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
    title: 'Chips',
    subtitle: 'abeled with delete buttons and avatars',
    icon: Icons.date_range,
    itemType: ItemType.MATERIAL,
    routeName: ChipDemo.routeName,
    buildRoute: (BuildContext context) => new ChipDemo(),
  ),
  new ListItem(
    title: 'Data tables',
    subtitle: 'Rows and columns',
    icon: Icons.touch_app,
    itemType: ItemType.MATERIAL,
    routeName: DataTableDemo.routeName,
    buildRoute: (BuildContext context) => new DataTableDemo(),
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
    title: 'Expand/collapse list control',
    subtitle: 'A list with one sub-list level',
    icon: Icons.lightbulb_outline,
    itemType: ItemType.MATERIAL,
    routeName: TwoLevelListDemo.routeName,
    buildRoute: (BuildContext context) => TwoLevelListDemo(),
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
  ),
  new ListItem(
    title: 'Navigation drawer',
    subtitle: 'Navigation drawer with standard header',
    icon: Icons.all_out,
    itemType: ItemType.MATERIAL,
    routeName: DrawerDemo.routeName,
    documentationUrl: 'https://docs.flutter.io/flutter/material/Drawer-class.html',
    buildRoute: (BuildContext context) => DrawerDemo(),
  ),
  new ListItem(
    title: 'Pagination',
    subtitle: 'PageView with indicator',
    icon: Icons.all_out,
    itemType: ItemType.MATERIAL,
    routeName: PageSelectorDemo.routeName,
    buildRoute: (BuildContext context) => PageSelectorDemo(),
  ),
  new ListItem(
    title: 'Pickers',
    subtitle: 'Date and time selection widgets',
    icon: Icons.all_out,
    itemType: ItemType.MATERIAL,
    routeName: DateAndTimePickerDemo.routeName,
    buildRoute: (BuildContext context) => DateAndTimePickerDemo(),
  ),
  new ListItem(
    title: 'Progress indicators',
    subtitle: 'Linear,circular,indeterminate ',
    icon: Icons.gif,
    itemType: ItemType.MATERIAL,
    routeName: ProgressIndicatorDemo.routeName,
    buildRoute: (BuildContext context) => ProgressIndicatorDemo(),
  ),
  new ListItem(
    title: 'Pull to refresh',
    subtitle: 'Refresh indicators',
    icon: Icons.refresh,
    itemType: ItemType.MATERIAL,
    routeName: OverscrollDemo.routeName,
    buildRoute: (BuildContext context) => OverscrollDemo(),
  ),
  new ListItem(
    title: 'Selection controls',
    subtitle: 'Checkboxes, radio buttons, and switches',
    icon: Icons.donut_large,
    itemType: ItemType.MATERIAL,
    routeName: SelectionControlsDemo.routeName,
    buildRoute: (BuildContext context) => SelectionControlsDemo(),
  ),
  new ListItem(
    title: 'Sliders',
    subtitle: 'Widgets for selecting a value by swiping',
    icon: Icons.pregnant_woman,
    itemType: ItemType.MATERIAL,
    routeName: SliderDemo.routeName,
    buildRoute: (BuildContext context) => SliderDemo(),
  ),
  new ListItem(
    title: 'SnackBar',
    subtitle: 'Temporary messaging',
    icon: Icons.pregnant_woman,
    itemType: ItemType.MATERIAL,
    routeName: SnackBarDemo.routeName,
    buildRoute: (BuildContext context) => SnackBarDemo(),
  ),
  new ListItem(
    title: 'Tabs',
    subtitle: 'Tabs with independently scrollable views',
    icon: Icons.http,
    itemType: ItemType.MATERIAL,
    routeName: TabsDemo.routeName,
    buildRoute: (BuildContext context) => TabsDemo(),
  ),
  new ListItem(
    title: 'Tabs: Scrolling',
    subtitle: 'Tab bar that scrolls',
    icon: Icons.http,
    itemType: ItemType.MATERIAL,
    routeName: ScrollableTabsDemo.routeName,
    buildRoute: (BuildContext context) => ScrollableTabsDemo(),
  ),
  new ListItem(
    title: 'Tooltips',
    subtitle: 'Short message displayed on long-press',
    icon: Icons.zoom_out,
    itemType: ItemType.MATERIAL,
    routeName: TooltipDemo.routeName,
    buildRoute: (BuildContext context) => TooltipDemo(),
  ),
];

class ListItem {
  const ListItem(
      {this.title,
      this.subtitle,
      this.icon,
      this.itemType,
      this.routeName,
      this.documentationUrl,
      this.buildRoute});

  final String title;
  final IconData icon;
  final String subtitle;
  final ItemType itemType;
  final String routeName;
  final WidgetBuilder buildRoute;
  final String documentationUrl;
}

final Map<String, String> kDemoDocumentationUrl =
    Map<String, String>.fromIterable(
  items.where((ListItem demo) => demo.documentationUrl != null),
  key: (dynamic demo) => demo.routeName,
  value: (dynamic demo) => demo.documentationUrl,
);
