import 'package:flutter/material.dart';
import 'shrine_demo.dart';
import 'shrine_types.dart';
import 'package:flutter/foundation.dart';
import 'shrine_page.dart';
import 'shrine_home.dart';
import 'shrine_theme.dart';

class OrderPage extends StatefulWidget {
  OrderPage({
    Key key,
    @required this.order,
    @required this.products,
    @required this.shoppingCart,
  })  : assert(order != null),
        assert(products != null && products.isNotEmpty),
        assert(shoppingCart != null),
        super(key: key);
  final Order order;
  final List<Product> products;
  final Map<Product, Order> shoppingCart;

  @override
  State<StatefulWidget> createState() {
    return OrderPageState();
  }
}

class OrderPageState extends State<OrderPage> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Order get currentOrder => ShrineOrderRoute.of(context).order;

  set currentOrder(Order value) {
    ShrineOrderRoute.of(context).order = value;
  }

  void showSnackBarMessage(String message) {
    scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  void updateOrder({int quantity, bool inCart}) {
    final Order newOrder =
        currentOrder.copyWith(quantity: quantity, inCart: inCart);
    print("11111111111111");
    print(widget.shoppingCart);
    print(currentOrder);
    print(newOrder);
    if (currentOrder != newOrder) {
      setState(() {
        widget.shoppingCart[newOrder.product] = newOrder;
        print(widget.shoppingCart);
        currentOrder = newOrder;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ShrinePage(
        scaffoldKey: scaffoldKey,
        products: widget.products,
        shoppingCart: widget.shoppingCart,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            updateOrder(inCart: true);
            final int n = currentOrder.quantity;
            final String item = currentOrder.product.name;
            showSnackBarMessage(
                'There ${n == 1 ? "is one $item item" : "are $n $item items"} in the shopping cart.');
          },
          backgroundColor: Color(0xFF16F0F0),
          tooltip: 'Add to cart',
          child: Icon(
            Icons.add_shopping_cart,
            color: Colors.black,
          ),
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: _Heading(
                product: widget.order.product,
                quantity: currentOrder.quantity,
                quantityChanged: (int value) {
                  updateOrder(quantity: value);
                },
              ),
            ),
            SliverSafeArea(
                top: false,
                minimum: EdgeInsets.fromLTRB(8.0, 32.0, 8.0, 8.0),
                sliver: SliverGrid(
                    delegate: SliverChildListDelegate(
                        widget.products.where((Product product) {
                      return product != widget.order.product;
                    }).map((Product product) {
                      return Card(
                        elevation: 1.0,
                        child: Image.asset(product.imageAsset,
                            fit: BoxFit.contain),
                      );
                    }).toList()),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 248.0,
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 8.0)))
          ],
        ));
  }
}

class _Heading extends StatelessWidget {
  const _Heading({
    Key key,
    @required this.product,
    @required this.quantity,
    this.quantityChanged,
  })  : assert(product != null),
        assert(quantity != null && quantity >= 0 && quantity <= 5),
        super(key: key);

  final Product product;
  final int quantity;
  final ValueChanged<int> quantityChanged;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: (screenSize.height - 56.0) * 1.35,
      child: Material(
        type: MaterialType.card,
        elevation: 0.0,
        child: Padding(
            padding: EdgeInsets.only(
                left: 16.0, top: 18.0, right: 16.0, bottom: 24.0),
            child: CustomMultiChildLayout(
              delegate: _HeadingLayout(),
              children: <Widget>[
                LayoutId(
                    id: _HeadingLayout.image,
                    child: Hero(
                        tag: product.tag,
                        child: Image.asset(
                          product.imageAsset,
                          fit: BoxFit.contain,
                          alignment: Alignment.center,
                        ))),
                LayoutId(
                  id: _HeadingLayout.icon,
                  child: const Icon(
                    Icons.info_outline,
                    size: 24.0,
                    color: Color(0xFFFFE0E0),
                  ),
                ),
                LayoutId(
                    id: _HeadingLayout.product,
                    child: _ProductItem(
                        product: product,
                        quantity: quantity,
                        onChanged: quantityChanged)),
                LayoutId(
                    id: _HeadingLayout.vendor,
                    child: _VendorItem(vendor: product.vendor)),
              ],
            )),
      ),
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
    final ShrineTheme theme = ShrineTheme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          height: 24.0,
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              vendor.name,
              style: theme.vendorTitleStyle,
            ),
          ),
        ),
        SizedBox(
          height: 16.0,
        ),
        Text(
          vendor.description,
          style: theme.vendorStyle,
        )
      ],
    );
  }
}

class _ProductItem extends StatelessWidget {
  const _ProductItem(
      {Key key,
      @required this.product,
      @required this.quantity,
      @required this.onChanged})
      : assert(product != null),
        assert(quantity != null),
        assert(onChanged != null),
        super(key: key);

  final Product product;
  final int quantity;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final ShrineTheme theme = ShrineTheme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          product.name,
          style: theme.featureTitleStyle,
        ),
        SizedBox(
          height: 24.0,
        ),
        Text(product.description, style: theme.featureStyle),
        SizedBox(
          height: 16.0,
        ),
        Padding(
          padding: EdgeInsets.only(top: 8.0, bottom: 8.0, right: 88.0),
          child: DropdownButtonHideUnderline(
              child: Container(
            decoration:
                BoxDecoration(border: Border.all(color: Color(0xFFD9D9D9))),
            child: DropdownButton<int>(
                items: <int>[0, 1, 2, 3, 4, 5]
                    .map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem(
                      value: value,
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Quantity $value',
                          style: theme.quantityMenuStyle,
                        ),
                      ));
                }).toList(),
                value: quantity,
                onChanged: onChanged),
          )),
        ),
      ],
    );
  }
}

class _HeadingLayout extends MultiChildLayoutDelegate {
  _HeadingLayout();

  static const String image = 'image';
  static const String icon = 'icon';
  static const String product = 'product';
  static const String vendor = 'vendor';

  @override
  void performLayout(Size size) {
    const double margin = 56.0;
    final bool landscape = size.width > size.height;
    final double imageWidth =
        (landscape ? size.width / 2.0 : size.width) - margin * 2.0;
    final BoxConstraints imageConstraints =
        BoxConstraints(maxHeight: 224.0, maxWidth: imageWidth);
    final Size imageSize = layoutChild(image, imageConstraints);
    const double imageY = 0.0;
    positionChild(image, const Offset(margin, imageY));

    final double productWidth =
        landscape ? size.width / 2.0 : size.width - margin;
    final BoxConstraints productConstraints =
        BoxConstraints(maxWidth: productWidth);
    final Size productSize = layoutChild(product, productConstraints);
    final double productX = landscape ? size.width / 2.0 : margin;
    final double productY = landscape ? 0.0 : imageY + imageSize.height + 16.0;
    positionChild(product, Offset(productX, productY));

    final Size iconSize = layoutChild(icon, BoxConstraints.loose(size));
    positionChild(
        icon, Offset(productX - iconSize.width - 16.0, productY + 8.0));

    final double vendorWidth = landscape ? size.width - margin : productWidth;
    layoutChild(vendor, BoxConstraints(maxWidth: vendorWidth));
    final double vendorX = landscape ? margin : productX;
    final double vendorY = productY + productSize.height + 16.0;
    positionChild(vendor, Offset(vendorX, vendorY));
  }

  @override
  bool shouldRelayout(_HeadingLayout oldDelegate) => true;
}

class ShrineOrderRoute extends ShrinePageRoute<Order> {
  ShrineOrderRoute(
      {@required this.order, WidgetBuilder builder, RouteSettings settings})
      : assert(order != null),
        super(builder: builder, settings: settings);

  Order order;

  @override
  Order get currentResult => order;

  static ShrineOrderRoute of(BuildContext context) =>
      ModalRoute.of<Order>(context);
}
