import 'package:flutter/material.dart';
import 'package:flutter_app/demo.dart';

enum GridDemoTileStyle { imageOnly, oneLine, twoLine }

typedef BannerTapCallback = void Function(Photo photo);

const double _kMinFlingVelocity = 800.0;

class Photo {
  Photo({this.assetName, this.title, this.caption,this.isFavorite=false});

  final String assetName;
  final String title;
  final String caption;
  bool isFavorite;

  String get tag => assetName;

  bool get isValid =>
      assetName != null &&
      title != null &&
      caption != null &&
      isFavorite != null;
}

class _GridTitleText extends StatelessWidget {
  const _GridTitleText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: Text(text),
    );
  }
}

class GridPhotoViewer extends StatefulWidget {
  const GridPhotoViewer({Key key, this.photo}) : super(key: key);
  final Photo photo;

  @override
  State<StatefulWidget> createState() {
    return GridPhotoViewerState();
  }
}

class GridPhotoViewerState extends State<GridPhotoViewer>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _flingAnimation;
  Offset _offset = Offset.zero;
  double _scale = 1.0;
  Offset _normalizedOffset;
  double _previousScale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this)
      ..addListener(_handleFlingAnimation);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Offset _clampOffset(Offset offset) {
    final Size size = context.size;
    final Offset minOffset = Offset(size.width, size.height) * (1.0 - _scale);
    return Offset(
        offset.dx.clamp(minOffset.dx, 0.0), offset.dy.clamp(minOffset.dy, 0.0));
  }

  void _handleFlingAnimation() {
    setState(() {
      _offset = _flingAnimation.value;
    });
  }

  void _handleOnScaleStart(ScaleStartDetails details) {
    setState(() {
      _previousScale = _scale;
      _normalizedOffset = (details.focalPoint - _offset) / _scale;
      _controller.stop();
    });
  }

  void _handleOnScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      _scale = (_previousScale * details.scale).clamp(1.0, 4.0);
      _offset = _clampOffset(details.focalPoint - _normalizedOffset * _scale);
    });
  }

  void _handleOnScaleEnd(ScaleEndDetails details) {
    final double magnitude = details.velocity.pixelsPerSecond.distance;
    if (magnitude < _kMinFlingVelocity) return;
    final Offset direction = details.velocity.pixelsPerSecond / magnitude;
    final double distance = (Offset.zero & context.size).shortestSide;
    _flingAnimation = _controller.drive(Tween<Offset>(
        begin: _offset, end: _clampOffset(_offset + direction * distance)));
    _controller
      ..value = 0.0
      ..fling(velocity: magnitude / 1000.0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleStart: _handleOnScaleStart,
      onScaleUpdate: _handleOnScaleUpdate,
      onScaleEnd: _handleOnScaleEnd,
      child: ClipRect(
        child: Transform(
          transform: Matrix4.identity()
            ..translate(_offset.dx, _offset.dy)
            ..scale(_scale),
          child: Image.asset(
            widget.photo.assetName,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class GridDemoPhotoItem extends StatelessWidget {
  GridDemoPhotoItem(
      {Key key,
      @required this.photo,
      @required this.tileStyle,
      @required this.onBannerTap})
      : assert(photo != null && photo.isValid),
        assert(tileStyle != null),
        assert(onBannerTap != null),
        super(key: key);

  final Photo photo;
  final GridDemoTileStyle tileStyle;
  final BannerTapCallback onBannerTap; // User taps

  void showPhoto(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute<void>(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(photo.title),
        ),
        body: SizedBox.expand(
          child: Hero(
              tag: photo.tag,
              child: GridPhotoViewer(
                photo: photo,
              )),
        ),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    final Widget image = GestureDetector(
      onTap: () {
        showPhoto(context);
      },
      child: Hero(
          key: Key(photo.assetName),
          tag: photo.tag,
          child: Image.asset(
            photo.assetName,
            fit: BoxFit.cover,
          )),
    );
    final IconData icon = photo.isFavorite ? Icons.star : Icons.star_border;
    switch (tileStyle) {
      case GridDemoTileStyle.imageOnly:
        return image;
      case GridDemoTileStyle.oneLine:
        return GridTile(
          header: GestureDetector(
              onTap: () {
                onBannerTap(photo);
              },
              child: GridTileBar(
                title: _GridTitleText(photo.title),
                backgroundColor: Colors.black45,
                leading: Icon(icon, color: Colors.white),
              )),
          child: image,
        );
      case GridDemoTileStyle.twoLine:
        return GridTile(
          footer: GestureDetector(
            onTap: () {
              onBannerTap(photo);
            },
            child: GridTileBar(
              backgroundColor: Colors.black45,
              title: _GridTitleText(photo.title),
              subtitle: _GridTitleText(photo.caption),
              trailing: Icon(
                icon,
                color: Colors.white,
              ),
            ),
          ),
          child: image,
        );
    }
    assert(tileStyle != null);
    return null;
  }
}

class GridListDemo extends StatefulWidget {
  const GridListDemo({Key key}) : super(key: key);

  static const String routeName = '/material/grid-list';

  @override
  GridListDemoState createState() => GridListDemoState();
}

class GridListDemoState extends State<GridListDemo> {
  GridDemoTileStyle _tileStyle = GridDemoTileStyle.twoLine;
  List<Photo> photos = <Photo>[
    Photo(
      assetName: 'assets/places/india_chennai_flower_market.png',
      title: 'Chennai',
      caption: 'Flower Market',
    ),
    Photo(
      assetName: 'assets/places/india_tanjore_bronze_works.png',
      title: 'Tanjore',
      caption: 'Bronze Works',
    ),
    Photo(
      assetName: 'assets/places/india_tanjore_market_merchant.png',
      title: 'Tanjore',
      caption: 'Market',
    ),
    Photo(
      assetName: 'assets/places/india_tanjore_thanjavur_temple.png',
      title: 'Tanjore',
      caption: 'Thanjavur Temple',
    ),
    Photo(
      assetName: 'assets/places/india_tanjore_thanjavur_temple_carvings.png',
      title: 'Tanjore',
      caption: 'Thanjavur Temple',
    ),
    Photo(
      assetName: 'assets/places/india_pondicherry_salt_farm.png',
      title: 'Pondicherry',
      caption: 'Salt Farm',
    ),
    Photo(
      assetName: 'assets/places/india_chennai_highway.png',
      title: 'Chennai',
      caption: 'Scooters',
    ),
    Photo(
      assetName: 'assets/places/india_chettinad_silk_maker.png',
      title: 'Chettinad',
      caption: 'Silk Maker',
    ),
    Photo(
      assetName: 'assets/places/india_chettinad_produce.png',
      title: 'Chettinad',
      caption: 'Lunch Prep',
    ),
    Photo(
      assetName: 'assets/places/india_tanjore_market_technology.png',
      title: 'Tanjore',
      caption: 'Market',
    ),
    Photo(
      assetName: 'assets/places/india_pondicherry_beach.png',
      title: 'Pondicherry',
      caption: 'Beach',
    ),
    Photo(
      assetName: 'assets/places/india_pondicherry_fisherman.png',
      title: 'Pondicherry',
      caption: 'Fisherman',
    ),
  ];

  void changeTileStyle(GridDemoTileStyle value) {
    setState(() {
      _tileStyle = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        title: Text('Grid list'),
        actions: <Widget>[
          MaterialDemoDocumentationButton(GridListDemo.routeName),
          PopupMenuButton<GridDemoTileStyle>(
            onSelected: changeTileStyle,
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<GridDemoTileStyle>>[
                PopupMenuItem<GridDemoTileStyle>(
                  value: GridDemoTileStyle.imageOnly,
                  child: Text('Image only'),
                ),
                PopupMenuItem<GridDemoTileStyle>(
                  value: GridDemoTileStyle.oneLine,
                  child: Text('One line'),
                ),
                PopupMenuItem<GridDemoTileStyle>(
                  value: GridDemoTileStyle.twoLine,
                  child: Text('Two line'),
                )
              ];
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: SafeArea(
                  top: false,
                  bottom: false,
//                  scrollDirection:滚动方向  ，crossAxisCount：显示数量,childAspectRatio:主轴（滚动方向轴）交叉轴比率
                  child: GridView.count(
                      scrollDirection:Axis.vertical,
                    crossAxisCount:
                        (orientation == Orientation.portrait) ? 3 : 3,
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                    padding: EdgeInsets.all(4.0),
                    childAspectRatio:
                        (orientation == Orientation.portrait) ? 1.0 : 1.3,
                    children: photos.map((Photo photo) {
                      print("11111111111111");
                      print(photo);
                      return GridDemoPhotoItem(
                          photo: photo,
                          tileStyle: _tileStyle,
                          onBannerTap: (Photo photo) {
                            setState(() {
                              photo.isFavorite = !photo.isFavorite;
                            });
                          });
                    }).toList(),
                  )))
        ],
      ),
    );
  }
}
