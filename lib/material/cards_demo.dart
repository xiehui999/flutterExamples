import 'package:flutter/material.dart';

class TravelDestination {
  const TravelDestination({this.assetName, this.title, this.description});

  final String assetName;
  final String title;
  final List<String> description;

  bool get isValid =>
      assetName != null && title != null && description?.length == 3;
}

final List<TravelDestination> destinations = <TravelDestination>[
  const TravelDestination(
      assetName: 'assets/india_chettinad_silk_market.png',
      title: 'Top 10 cities to visit in Tamil Nadu',
      description: <String>['Number 10', 'Thanjavur', 'Thanjavur,Tamil Nadu']),
  const TravelDestination(
      assetName: 'assets/india_thanjavur_market.png',
      title: 'Artisans of southern India',
      description: <String>[
        'Silk Spinners',
        'Chettinad',
        'Silvaganga, Tamil Nadu'
      ]),
];

class TravelDestinationItem extends StatelessWidget {
  TravelDestinationItem({Key key, @required this.destination, this.shape})
      : assert(destination != null && destination.isValid),
        super(key: key);

  static const double height = 366.0;
  final TravelDestination destination;
  final ShapeBorder shape;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TextStyle textStyle =
        themeData.textTheme.headline.copyWith(color: Colors.white);
    final TextStyle descriptionStyle = themeData.textTheme.subhead;
    return SafeArea(
        top: false,
        bottom: false,
        child: Container(
          padding: EdgeInsets.all(8.0),
          height: height,
          child: Card(
            shape: shape,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 184.0,
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                          child: Image.asset(
                        destination.assetName,
                        fit: BoxFit.cover,
                      )),
                      Positioned(
                        bottom: 16.0,
                        left: 16.0,
                        right: 16.0,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            destination.title,
                            style: textStyle,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                  child: DefaultTextStyle(
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: descriptionStyle,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              destination.description[0],
                              style: descriptionStyle.copyWith(
                                  color: Colors.black54),
                            ),
                          ),
                          Text(destination.description[1]),
                          Text(destination.description[2]),
                        ],
                      )),
                )),
                ButtonTheme.bar(
                  child: ButtonBar(
                    alignment: MainAxisAlignment.start,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {},
                        child: Text('Share'),
                        textColor: Colors.amber.shade500,
                      ),
                      FlatButton(
                        child: Text('Explore'),
                        textColor: Colors.amber.shade500,
                        onPressed: () {},
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class CardsDemo extends StatefulWidget {
  static const String routeName = '/material/cards';

  @override
  State<StatefulWidget> createState() {
    return CardsDemoState();
  }
}

class CardsDemoState extends State<CardsDemo> {
  ShapeBorder _shape;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Travel stream'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.sentiment_very_dissatisfied),
              onPressed: () {
                setState(() {
                  _shape = _shape != null
                      ? null
                      : const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16.0),
                              topRight: Radius.circular(16.0),
                              bottomLeft: Radius.circular(2.0),
                              bottomRight: Radius.circular(2.0)));
                });
              })
        ],
      ),
      body: ListView(
        itemExtent: TravelDestinationItem.height,
        padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
        children: destinations.map((TravelDestination destination) {
          return Container(
            margin: const EdgeInsets.only(bottom: 8.0),
            child: TravelDestinationItem(
              destination: destination,
              shape: _shape,
            ),
          );
        }).toList(),
      ),
    );
  }
}
