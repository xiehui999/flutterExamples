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
import 'material/backdrop_demo.dart';
import 'material/leave_behind_demo.dart';
import 'material/list_demo.dart';
import 'material/grid_list_demo.dart';
import 'material/expansion_panels_demo.dart';
import 'material/text_form_field_demo.dart';
import 'material/recorderable_demo.dart';

import 'cupertino/cupertino_activity_indicator_demo.dart';
import 'cupertino/cupertino_alert_demo.dart';
import 'cupertino/cupertino_buttons_demo.dart';
import 'cupertino/cupertino_navigation.dart';
import 'cupertino/cupertino_switch_demo.dart';
import 'cupertino/cupertino_slider_demo.dart';
import 'cupertino/cupertino_segmented_control_demo.dart';
import 'cupertino/cupertino_refresh_demo.dart';
import 'cupertino/cupertino_picker_demo.dart';
import 'media/images_demo.dart';

enum ItemType { STYLESANDMEDIA, MATERIAL, CUPERTINO }

final List<ListItem> cupertinoItems = <ListItem>[
  new ListItem(
    title: 'Activity Indicator',
    icon: Icons.rounded_corner,
    itemType: ItemType.CUPERTINO,
    routeName: CupertinoProgressIndicatorDemo.routeName,
    documentationUrl:
        'https://docs.flutter.io/flutter/cupertino/CupertinoActivityIndicator-class.html',
    buildRoute: (BuildContext context) => new CupertinoProgressIndicatorDemo(),
  ),
  new ListItem(
    title: 'Alerts',
    icon: Icons.important_devices,
    itemType: ItemType.CUPERTINO,
    routeName: CupertinoAlertDemo.routeName,
    documentationUrl:
        'https://docs.flutter.io/flutter/cupertino/showCupertinoDialog.html',
    buildRoute: (BuildContext context) => CupertinoAlertDemo(),
  ),
  new ListItem(
    title: 'Buttons',
    icon: Icons.update,
    itemType: ItemType.CUPERTINO,
    routeName: CupertinoButtonsDemo.routeName,
    documentationUrl:
        'https://docs.flutter.io/flutter/cupertino/CupertinoButton-class.html',
    buildRoute: (BuildContext context) => CupertinoButtonsDemo(),
  ),
  new ListItem(
    title: 'Navigation',
    icon: Icons.update,
    itemType: ItemType.CUPERTINO,
    routeName: CupertinoNavigation.routeName,
    documentationUrl:
        'https://docs.flutter.io/flutter/cupertino/CupertinoTabScaffold-class.html',
    buildRoute: (BuildContext context) => CupertinoNavigation(),
  ),
  new ListItem(
    title: 'Pickers',
    icon: Icons.transform,
    itemType: ItemType.CUPERTINO,
    routeName: CupertinoPickerDemo.routeName,
    documentationUrl:
        'https://docs.flutter.io/flutter/cupertino/CupertinoPicker-class.html',
    buildRoute: (BuildContext context) => CupertinoPickerDemo(),
  ),
  new ListItem(
    title: 'Pull to refresh',
    icon: Icons.rowing,
    itemType: ItemType.CUPERTINO,
    routeName: CupertinoRefreshControlDemo.routeName,
    documentationUrl:
        'https://docs.flutter.io/flutter/cupertino/CupertinoSliverRefreshControl-class.html',
    buildRoute: (BuildContext context) => CupertinoRefreshControlDemo(),
  ),
  new ListItem(
    title: 'Segmented Control',
    icon: Icons.http,
    itemType: ItemType.CUPERTINO,
    routeName: CupertinoSegmentedControlDemo.routeName,
    documentationUrl:
        'https://docs.flutter.io/flutter/cupertino/CupertinoSegmentedControl-class.html',
    buildRoute: (BuildContext context) => CupertinoSegmentedControlDemo(),
  ),
  new ListItem(
    title: 'Sliders',
    icon: Icons.flight_land,
    itemType: ItemType.CUPERTINO,
    routeName: CupertinoSliderDemo.routeName,
    documentationUrl:
        'https://docs.flutter.io/flutter/cupertino/CupertinoSlider-class.html',
    buildRoute: (BuildContext context) => CupertinoSliderDemo(),
  ),
  new ListItem(
    title: 'Switches',
    icon: Icons.timeline,
    itemType: ItemType.CUPERTINO,
    routeName: CupertinoSwitchDemo.routeName,
    documentationUrl:
        'https://docs.flutter.io/flutter/cupertino/CupertinoSwitch-class.html',
    buildRoute: (BuildContext context) => CupertinoSwitchDemo(),
  )
];

final List<ListItem> items = <ListItem>[
  new ListItem(
    title: 'Colors',
    subtitle: 'All of the predefined colors',
    icon: Icons.compare_arrows,
    itemType: ItemType.STYLESANDMEDIA,
    routeName: ColorsDemo.routeName,
    buildRoute: (BuildContext context) => new ColorsDemo(),
  ),
  new ListItem(
    title: 'Typography',
    subtitle: 'All of the predefined text styles',
    icon: Icons.accessible,
    itemType: ItemType.STYLESANDMEDIA,
    routeName: TypographyDemo.routeName,
    buildRoute: (BuildContext context) => new TypographyDemo(),
  ),
  new ListItem(
    title: 'Animated images',
    subtitle: 'GIF and WebP animations',
    icon: Icons.opacity,
    itemType: ItemType.STYLESANDMEDIA,
    routeName: ImagesDemo.routeName,
    buildRoute: (BuildContext context) => new ImagesDemo(),
  ),
  new ListItem(
    title: 'Backdrop',
    subtitle: 'Select a front layer from back layer',
    icon: Icons.watch_later,
    itemType: ItemType.MATERIAL,
    routeName: BackdropDemo.routeName,
    buildRoute: (BuildContext context) => new BackdropDemo(),
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
    title: 'Expansion panels',
    subtitle: 'List of expanding panels',
    icon: Icons.lightbulb_outline,
    itemType: ItemType.MATERIAL,
    routeName: ExpansionPanelsDemo.routeName,
    documentationUrl:
        'https://docs.flutter.io/flutter/material/ExpansionPanel-class.html',
    buildRoute: (BuildContext context) => ExpansionPanelsDemo(),
  ),
  new ListItem(
    title: 'Grid',
    subtitle: 'Row and column layout',
    icon: Icons.gavel,
    itemType: ItemType.MATERIAL,
    routeName: GridListDemo.routeName,
    documentationUrl:
        'https://docs.flutter.io/flutter/widgets/GridView-class.html',
    buildRoute: (BuildContext context) => GridListDemo(),
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
    title: 'Lists',
    subtitle: 'Scrolling list layouts',
    icon: Icons.fingerprint,
    itemType: ItemType.MATERIAL,
    routeName: ListDemo.routeName,
    documentationUrl:
        'https://docs.flutter.io/flutter/material/ListTile-class.html',
    buildRoute: (BuildContext context) => ListDemo(),
  ),
  new ListItem(
    title: 'Lists: leave-behind list items',
    subtitle: 'List items with hidden actions',
    icon: Icons.g_translate,
    itemType: ItemType.MATERIAL,
    routeName: LeaveBehindDemo.routeName,
    documentationUrl:
        'https://docs.flutter.io/flutter/widgets/Dismissible-class.html',
    buildRoute: (BuildContext context) => const LeaveBehindDemo(),
  ),
  new ListItem(
    title: 'Lists: reorderable',
    subtitle: 'Reorderable lists',
    icon: Icons.g_translate,
    itemType: ItemType.MATERIAL,
    routeName: ReorderableListDemo.routeName,
    documentationUrl:
        'https://docs.flutter.io/flutter/material/ReorderableListView-class.html',
    buildRoute: (BuildContext context) => const ReorderableListDemo(),
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
    documentationUrl:
        'https://docs.flutter.io/flutter/material/Drawer-class.html',
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
    title: 'Text fields',
    subtitle: 'Single line of editable text and numbers',
    icon: IconData(0xe901, fontFamily: 'MaterialIcons'),
    itemType: ItemType.MATERIAL,
    routeName: TextFormFieldDemo.routeName,
    documentationUrl:
        'https://docs.flutter.io/flutter/material/TextFormField-class.html',
    buildRoute: (BuildContext context) => TextFormFieldDemo(),
  ),
  new ListItem(
    title: 'Tooltips',
    subtitle: 'Short message displayed on long-press',
    icon: Icons.zoom_out,
    itemType: ItemType.MATERIAL,
    routeName: TooltipDemo.routeName,
    buildRoute: (BuildContext context) => TooltipDemo(),
  ),
]..addAll(cupertinoItems);

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
