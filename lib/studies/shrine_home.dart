import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'shrine_types.dart';
import 'shrine_data.dart';
import 'shrine_page.dart';

const double unitSize = 56.0;
final List<Product> _products = List<Product>.from(allProducts());

final Map<Product, Order> _shopingCar = <Product, Order>{};

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
        shoppingCart: _shopingCar,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Text('Head'),
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
