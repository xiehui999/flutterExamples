import 'package:flutter/material.dart';

class _Page {
  _Page({this.label});

  final String label;

  String get id => label[0];

  @override
  String toString() {
    return '$runtimeType("$label")';
  }
}

class _CardData {
  const _CardData({this.title, this.imageAsset});

  final String title;
  final String imageAsset;
}

final Map<_Page, List<_CardData>> _allPages = <_Page, List<_CardData>>{
  _Page(label: 'Home'): <_CardData>[
    const _CardData(
      title: 'Flatwear',
      imageAsset: 'assets/products/flatwear.png',
    ),
    const _CardData(
      title: 'Pine Table',
      imageAsset: 'assets/products/table.png',
    ),
    const _CardData(
      title: 'Blue Cup',
      imageAsset: 'assets/products/cup.png',
    ),
    const _CardData(
      title: 'Tea Set',
      imageAsset: 'assets/products/teaset.png',
    ),
    const _CardData(
      title: 'Desk Set',
      imageAsset: 'assets/products/deskset.png',
    ),
    const _CardData(
      title: 'Blue Linen Napkins',
      imageAsset: 'assets/products/napkins.png',
    ),
    const _CardData(
      title: 'Planters',
      imageAsset: 'assets/products/planters.png',
    ),
    const _CardData(
      title: 'Kitchen Quattro',
      imageAsset: 'assets/products/kitchen_quattro.png',
    ),
    const _CardData(
      title: 'Platter',
      imageAsset: 'assets/products/platter.png',
    ),
  ],
  _Page(label: 'APPAREL'): <_CardData>[
    const _CardData(
      title: 'Cloud-White Dress',
      imageAsset: 'assets/products/dress.png',
    ),
    const _CardData(
      title: 'Ginger Scarf',
      imageAsset: 'assets/products/scarf.png',
    ),
    const _CardData(
      title: 'Blush Sweats',
      imageAsset: 'assets/products/sweats.png',
    ),
  ]
};

class _CardDataItem extends StatelessWidget {
  const _CardDataItem({this.page, this.data});

  static const double height = 272.0;
  final _Page page;
  final _CardData data;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Align(
              alignment:
                  page.id == 'H' ? Alignment.centerLeft : Alignment.centerRight,
              child: CircleAvatar(
                child: Text('${page.id}'),
              ),
            ),
            SizedBox(
              width: 144.0,
              height: 144.0,
              child: Image.asset(
                data.imageAsset,
                fit: BoxFit.contain,
              ),
            ),
            Center(
              child: Text(
                data.title,
                style: Theme.of(context).textTheme.title,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TabsDemo extends StatelessWidget {
  static const String routeName = '/material/tabs';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: _allPages.length,
        child: Scaffold(
          body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                    sliver: SliverAppBar(
                      title: Text('Tabs and scrolling'),
                      pinned: true,
                      expandedHeight: 150.0,
                      forceElevated: innerBoxIsScrolled,
                      bottom: TabBar(
                          tabs: _allPages.keys.map((_Page page) {
                        return Tab(
                          text: page.label,
                        );
                      }).toList()),
                    ),
                  )
                ];
              },
              body: TabBarView(
                  children: _allPages.keys.map((_Page page) {
                return SafeArea(
                    top: false,
                    bottom: false,
                    child: Builder(builder: (BuildContext context) {
                      return CustomScrollView(
                        key: PageStorageKey(page),
                        slivers: <Widget>[
                          SliverOverlapInjector(
                              handle: NestedScrollView
                                  .sliverOverlapAbsorberHandleFor(context)),
                          SliverPadding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            sliver: SliverFixedExtentList(
                                delegate: SliverChildBuilderDelegate(
                                    (BuildContext context, int index) {
                                  final _CardData data = _allPages[page][index];
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 8.0),
                                    child: _CardDataItem(
                                      page: page,
                                      data: data,
                                    ),
                                  );
                                }, childCount: _allPages[page].length),
                                itemExtent: _CardDataItem.height),
                          )
                        ],
                      );
                    }));
              }).toList())),
        ));
  }
}
