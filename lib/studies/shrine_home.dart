import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'shrine_types.dart';
import 'shrine_data.dart';
import 'shrine_page.dart';
import 'shrine_theme.dart';

const double unitSize = 56.0;
final List<Product> _products = List<Product>.from(allProducts());

final Map<Product, Order> _shoppingCart = <Product, Order>{};

const int _childrenPerBlock = 8;
const int _rowsPerBlock = 5;

int _minIndexInRow(int rowIndex) {
  final int blockIndex = rowIndex ~/ _rowsPerBlock;
  return const <int>[0, 2, 4, 6, 7][rowIndex % _rowsPerBlock] +
      blockIndex * _childrenPerBlock;
}

int _maxIndexInRow(int rowIndex) {
  final int blockIndex = rowIndex ~/ _rowsPerBlock;
  return const <int>[1, 3, 5, 6, 7][rowIndex % _rowsPerBlock] +
      blockIndex * _childrenPerBlock;
}

int _rowAtIndex(int index) {
  final int blockCount = index ~/ _childrenPerBlock;
  return const <int>[
        0,
        0,
        1,
        1,
        2,
        2,
        3,
        4
      ][index - blockCount * _childrenPerBlock] +
      blockCount * _rowsPerBlock;
}

int _columnAtIndex(int index) {
  return const <int>[0, 1, 0, 1, 0, 1, 0, 0][index % _childrenPerBlock];
}

int _columnSpanAtIndex(int index) {
  return const <int>[1, 1, 1, 1, 1, 1, 2, 2][index % _childrenPerBlock];
}

class _ShrineGridLayout extends SliverGridLayout {
  const _ShrineGridLayout(
      {@required this.rowStride,
      @required this.columnStride,
      @required this.tileHeight,
      @required this.tileWidth});

  final double rowStride;
  final double columnStride;
  final double tileHeight;
  final double tileWidth;

  @override
  double computeMaxScrollOffset(int childCount) {
    if (childCount == 0) return 0.0;
    final int rowCount = _rowAtIndex(childCount - 1) + 1;
    final double rowSpacing = rowStride - tileHeight;
    return rowStride * rowCount - rowSpacing;
  }

  @override
  SliverGridGeometry getGeometryForChildIndex(int index) {
    final int row = _rowAtIndex(index);
    final int column = _columnAtIndex(index);
    final int columnSpan = _columnSpanAtIndex(index);
    return SliverGridGeometry(
        scrollOffset: row * rowStride,
        crossAxisOffset: column * columnStride,
        mainAxisExtent: tileHeight,
        crossAxisExtent: tileWidth + (columnSpan - 1) * columnStride);
  }

  @override
  int getMaxChildIndexForScrollOffset(double scrollOffset) {
    return _maxIndexInRow(scrollOffset ~/ rowStride);
  }

  @override
  int getMinChildIndexForScrollOffset(double scrollOffset) {
    return _minIndexInRow(scrollOffset ~/ rowStride);
  }
}

class _ShrineGridDelegate extends SliverGridDelegate {
  static const double _spacing = 8.0;

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    final double tileWidth = (constraints.crossAxisExtent - _spacing) / 2;
    const double tileHeight = 40.0 + 144.0 + 40.0;
    return _ShrineGridLayout(
        rowStride: tileHeight + _spacing,
        columnStride: tileWidth + _spacing,
        tileHeight: tileHeight,
        tileWidth: tileWidth);
  }

  @override
  bool shouldRelayout(SliverGridDelegate oldDelegate) {
    return false;
  }
}

class ShrineHome extends StatefulWidget {
  @override
  _ShrineHomeState createState() => _ShrineHomeState();
}

class _ShrineHomeState extends State<ShrineHome> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: 'Shrine Home');

  static final _ShrineGridDelegate gridDelegate = _ShrineGridDelegate();

  @override
  Widget build(BuildContext context) {
    final Product featured = _products
        .firstWhere((Product product) => product.featureDescription != null);
    return ShrinePage(
        scaffoldKey: _scaffoldKey,
        products: _products,
        shoppingCart: _shoppingCart,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: _Heading(product: featured),
            ),
            SliverSafeArea(
                top: false,
                bottom: false,
                sliver: SliverGrid(
                    delegate: SliverChildListDelegate(
                        _products.map<Widget>((Product product) {
                      return Text('111111111111');
                    }).toList()),
                    gridDelegate: gridDelegate))
          ],
        ));
  }
}

class _Heading extends StatelessWidget {
  _Heading({Key key, @required this.product})
      : assert(product != null),
        assert(product.featureTitle != null),
        assert(product.featureDescription != null),
        super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final ShrineTheme theme = ShrineTheme.of(context);
    return MergeSemantics(
      child: SizedBox(
        height: screenSize.width > screenSize.height
            ? (screenSize.height - 56.0) * 0.85
            : (screenSize.height - 56.0) * 0.70,
        child: Container(
          decoration: BoxDecoration(
              color: theme.cardBackgroundColor,
              border: Border(bottom: BorderSide(color: theme.dividerColor))),
          child: CustomMultiChildLayout(
            delegate: _HeadingLayout(),
            children: <Widget>[
              LayoutId(
                  id: _HeadingLayout.price,
                  child: _FeaturePriceItem(
                    product: product,
                  )),
              LayoutId(
                id: _HeadingLayout.image,
                child: Image.asset(
                  product.imageAsset,
                  fit: BoxFit.cover,
                ),
              ),
              LayoutId(
                id: _HeadingLayout.title,
                child:
                    Text(product.featureTitle, style: theme.featureTitleStyle),
              ),
              LayoutId(
                id: _HeadingLayout.description,
                child:
                    Text(product.featureDescription, style: theme.featureStyle),
              ),
              LayoutId(
                id: _HeadingLayout.vendor,
                child: _VendorItem(vendor: product.vendor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeadingLayout extends MultiChildLayoutDelegate {
  _HeadingLayout();

  static const String price = "price";
  static const String image = "image";
  static const String title = "title";
  static const String description = "description";
  static const String vendor = "vendor";

  @override
  void performLayout(Size size) {
    final Size priceSize = layoutChild(price, BoxConstraints.loose(size));
    positionChild(price, Offset(size.width - priceSize.width, 0.0));

    final double halfWidth = size.width / 2.0;
    final double halfHeight = size.height / 2.0;
    const double halfUnit = unitSize / 2.0;
    const double margin = 16.0;

    final Size imageSize = layoutChild(image, BoxConstraints.loose(size));
    final double imageX = imageSize.width < halfWidth - halfUnit
        ? halfWidth / 2.0 - imageSize.width / 2.0 - halfUnit
        : halfWidth - imageSize.width;
    positionChild(image, Offset(imageX, halfHeight - imageSize.height / 2.0));

    final double maxTitleWidth = halfWidth + unitSize - margin;
    final BoxConstraints titleBoxConstraints =
        BoxConstraints(maxWidth: maxTitleWidth);
    final Size titleSize = layoutChild(title, titleBoxConstraints);
    final double titleX = halfWidth - unitSize;
    final double titleY = halfHeight - titleSize.height;
    positionChild(title, Offset(titleX, titleY));

    final Size descriptionSize = layoutChild(description, titleBoxConstraints);
    final double descriptionY = titleY + titleSize.height + margin;
    positionChild(description, Offset(titleX, descriptionY));

    layoutChild(vendor, titleBoxConstraints);
    final double vendorY = descriptionY + descriptionSize.height + margin;
    positionChild(vendor, Offset(titleX, vendorY));
  }

  @override
  bool shouldRelayout(MultiChildLayoutDelegate oldDelegate) {
    return false;
  }
}

abstract class _PriceItem extends StatelessWidget {
  const _PriceItem({Key key, @required this.product})
      : assert(product != null),
        super(key: key);

  final Product product;

  Widget buildItem(BuildContext context, TextStyle style, EdgeInsets padding) {
    BoxDecoration decoration;
    if (_shoppingCart[product] != null)
      decoration =
          BoxDecoration(color: ShrineTheme.of(context).priceHighlightColor);

    return Container(
      padding: padding,
      decoration: decoration,
      child: Text(product.priceString, style: style),
    );
  }
}

class _ProductPriceItem extends _PriceItem {
  const _ProductPriceItem({Key key, Product product})
      : super(key: key, product: product);

  @override
  Widget build(BuildContext context) {
    return buildItem(
      context,
      ShrineTheme.of(context).priceStyle,
      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    );
  }
}

class _FeaturePriceItem extends _PriceItem {
  const _FeaturePriceItem({Key key, Product product})
      : super(key: key, product: product);

  @override
  Widget build(BuildContext context) {
    return buildItem(
      context,
      ShrineTheme.of(context).featurePriceStyle,
      const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
    );
  }
}
class _VendorItem extends StatelessWidget {
  const _VendorItem({Key key, @required this.vendor})
      : assert(vendor != null),
        super(key: key);

  final Vendor vendor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24.0,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 24.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.asset(
                vendor.avatarAsset,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(vendor.name,
                style: ShrineTheme.of(context).vendorItemStyle),
          ),
        ],
      ),
    );
  }
}
