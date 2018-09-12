import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as Math;
import 'dart:async';

const List<Color> coolColors = <Color>[
  Color.fromARGB(255, 255, 59, 48),
  Color.fromARGB(255, 255, 149, 0),
  Color.fromARGB(255, 255, 204, 0),
  Color.fromARGB(255, 76, 217, 100),
  Color.fromARGB(255, 90, 200, 250),
  Color.fromARGB(255, 0, 122, 255),
  Color.fromARGB(255, 88, 86, 214),
  Color.fromARGB(255, 255, 45, 85),
];
const List<String> coolColorNames = <String>[
  'Sarcoline',
  'Coquelicot',
  'Smaragdine',
  'Mikado',
  'Glaucous',
  'Wenge',
  'Fulvous',
  'Xanadu',
  'Falu',
  'Eburnean',
  'Amaranth',
  'Australien',
  'Banan',
  'Falu',
  'Gingerline',
  'Incarnadine',
  'Labrador',
  'Nattier',
  'Pervenche',
  'Sinoper',
  'Verditer',
  'Watchet',
  'Zaffre',
];

class CupertinoNavigation extends StatelessWidget {
  CupertinoNavigation()
      : colorItems = new List<Color>.generate(50, (int index) {
          return coolColors[new Math.Random().nextInt(coolColors.length)];
        }),
        colorNameItems = new List<String>.generate(50, (int index) {
          return coolColorNames[
              new Math.Random().nextInt(coolColorNames.length)];
        });

  final List<Color> colorItems;
  final List<String> colorNameItems;
  static const String routeName = '/cupertino/navigation';

//  WillPopScope 可以用于监听，键盘返回，（页面pop），
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () => new Future<bool>.value(true),
      child: new DefaultTextStyle(
        style: const TextStyle(
          fontSize: 17.0,
//              fontFamily: '.SF UI Text',
          color: CupertinoColors.black,
        ),
        child: new CupertinoTabScaffold(
          tabBar: new CupertinoTabBar(items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.conversation_bubble),
              title: Text('Support'),
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.profile_circled),
              title: Text('Profile'),
            )
          ]),
          tabBuilder: (BuildContext context, int index) {
            assert(index >= 0 && index <= 2);
            switch (index) {
              case 0:
                return new CupertinoTabView(
                  builder: (BuildContext context) {
                    return new CupertinoDemoTab1(
                      colorItems: colorItems,
                      colorNameItems: colorNameItems,
                    );
                  },
                  defaultTitle: 'Colors',
                );
                break;
              case 1:
                return new CupertinoTabView(
                  builder: (BuildContext context) {
                    return new CupertinoDemoTab2();
                  },
                  defaultTitle: 'Support Chat',
                );
                break;
              case 2:
                return new CupertinoTabView(
                  builder: (BuildContext context) {
                    return new CupertinoDemoTab3();
                  },
                  defaultTitle: 'Account',
                );
                break;
            }
            return null;
          },
        ),
      ),
    );
  }
}

class CupertinoDemoTab1 extends StatelessWidget {
  const CupertinoDemoTab1({this.colorItems, this.colorNameItems});

  final List<Color> colorItems;
  final List<String> colorNameItems;

  @override
  Widget build(BuildContext context) {
    return new CupertinoPageScaffold(
        child: new CustomScrollView(
      slivers: <Widget>[
        const CupertinoSliverNavigationBar(
          trailing: ExitButton(),
        ),
        new SliverPadding(
          padding: MediaQuery.of(context)
              .removePadding(
                  removeTop: true, removeLeft: true, removeRight: true)
              .padding,
          sliver: new SliverList(
            delegate: new SliverChildBuilderDelegate(
              (BuildContext contex, int index) {
                return new Tab1RowItem(
                  index: index,
                  lastItem: index == 49,
                  color: colorItems[index],
                  colorName: colorNameItems[index],
                );
              },
              childCount: 50,
            ),
          ),
        )
      ],
    ));
  }
}

class Tab1RowItem extends StatelessWidget {
  const Tab1RowItem({this.index, this.lastItem, this.color, this.colorName});

  final int index;
  final bool lastItem;
  final Color color;
  final String colorName;

  @override
  Widget build(BuildContext context) {
    final Widget row = new GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.of(context).push(
          new CupertinoPageRoute<void>(
              title: colorName,
              builder: (BuildContext context) {
                return new Tab1ItemPage(
                  color: color,
                  colorName: colorName,
                  index: index,
                );
              }),
        );
      },
      child: new SafeArea(
          top: false,
          bottom: false,
          child: new Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 8.0, right: 8.0,bottom: 8.0),
            child: new Row(
              children: <Widget>[
                new Container(
                  height: 60.0,
                  width: 60.0,
                  decoration: new BoxDecoration(
                      color: color,
                      borderRadius: new BorderRadius.circular(8.0)),
                ),
                new Expanded(
                  child: new Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(colorName),
                        const Padding(padding: EdgeInsets.only(top: 8.0)),
                        const Text(
                          'Buy this cool color',
                          style: TextStyle(
                            color: Color(0xFF8E8E93),
                            fontSize: 13.0,
                            fontWeight: FontWeight.w300,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                new CupertinoButton(
                    child: const Icon(
                      CupertinoIcons.plus_circled,
                      color: CupertinoColors.activeBlue,
                      semanticLabel: 'Add',
                    ),
                    onPressed: () {}),
                new CupertinoButton(
                    child: const Icon(
                      CupertinoIcons.share,
                      color: CupertinoColors.activeBlue,
                      semanticLabel: 'SHARE',
                    ),
                    onPressed: () {})
              ],
            ),
          )),
    );
    if (lastItem) {
      return row;
    }
    return new Column(
      children: <Widget>[
        row,
        new Container(
          height: 1.0,
          color: const Color(0xFFD9D9D9),
        )
      ],
    );
  }
}

class Tab1ItemPage extends StatefulWidget {
  const Tab1ItemPage({this.color, this.colorName, this.index});

  final Color color;
  final String colorName;
  final int index;

  @override
  State<StatefulWidget> createState() {
    return new Tab1ItemPageState();
  }
}

class Tab1ItemPageState extends State<Tab1ItemPage> {
  List<Color> relatedColors;

  @override
  void initState() {
    super.initState();
    relatedColors = new List<Color>.generate(10, (int index) {
      final Math.Random random = new Math.Random();
      return new Color.fromARGB(
        255,
        (widget.color.red + random.nextInt(100) - 50).clamp(0, 255),
        (widget.color.green + random.nextInt(100) - 50).clamp(0, 255),
        (widget.color.blue + random.nextInt(100) - 50).clamp(0, 255),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return new CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          trailing: ExitButton(),
        ),
        child: new SafeArea(
            top: false,
            bottom: false,
            child: new ListView(
              children: <Widget>[
                const Padding(padding: EdgeInsets.only(top: 16.0)),
                new Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: new Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      new Container(
                        height: 128.0,
                        width: 128.0,
                        decoration: new BoxDecoration(
                            color: widget.color,
                            borderRadius: new BorderRadius.circular(24.0)),
                      ),
                      const Padding(padding: EdgeInsets.only(left: 18.0)),
                      new Expanded(
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new Text(
                              widget.colorName,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24.0),
                            ),
                            new Padding(padding: EdgeInsets.only(top: 6.0)),
                            new Text(
                              'Item index:${widget.index}',
                              style: const TextStyle(
                                  color: Color(0xff8e8e93),
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w100),
                            ),
                            const Padding(padding: EdgeInsets.only(top: 20.0)),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new CupertinoButton(
                                    color: CupertinoColors.activeBlue,
                                    minSize: 30.0,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24.0),
                                    borderRadius:
                                        new BorderRadius.circular(32.0),
                                    child: const Text(
                                      'GET',
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: -0.28),
                                    ),
                                    onPressed: () {}),
                                new CupertinoButton(
                                  color: CupertinoColors.activeBlue,
                                  minSize: 30.0,
                                  padding: EdgeInsets.zero,
                                  borderRadius: new BorderRadius.circular(32.0),
                                  child: const Icon(CupertinoIcons.ellipsis,
                                      color: CupertinoColors.white),
                                  onPressed: () {},
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 16.0, top: 20.0, bottom: 8.0),
                  child: Text(
                    'USER ALSO LIKED',
                    style: TextStyle(
                      color: Color(0xFF646464),
                      letterSpacing: -0.60,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                new SizedBox(
                  height: 200.0,
                  child: new ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemExtent: 160.0,
                      itemBuilder: (BuildContext context, int index) {
                        return new Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: new Container(
                            decoration: new BoxDecoration(
                                borderRadius: new BorderRadius.circular(8.0),
                                color: relatedColors[index]),
                            child: new Center(
                              child: new CupertinoButton(
                                  child: const Icon(
                                    CupertinoIcons.plus_circled,
                                    color: CupertinoColors.white,
                                    size: 36.0,
                                  ),
                                  onPressed: () {}),
                            ),
                          ),
                        );
                      }),
                )
              ],
            )));
  }
}

class CupertinoDemoTab2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          trailing: ExitButton(),
        ),
        child: new ListView(
          children: <Widget>[
            new Tab2Header(),
          ]..addAll(buildTab2Conversation()),
        ));
  }
}

class ExitButton extends StatelessWidget {
  const ExitButton();

  @override
  Widget build(BuildContext context) {
    return new CupertinoButton(
        padding: EdgeInsets.zero,
        child: const Tooltip(
          message: 'Back',
          child: Text('Exit'),
          excludeFromSemantics: true,
        ),
        onPressed: () {
//          Navigator.of(context, rootNavigator: true).pop();
        });
  }
}

class Tab2Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(16.0),
      child: new SafeArea(
          top: false,
          bottom: false,
          child: new ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Container(
                  decoration: const BoxDecoration(
                    color: Color(0xffe5e5e5),
                  ),
                  child: new Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 12.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'SUPPORT TICKET',
                          style: TextStyle(
                              color: Color(0xff656565),
                              letterSpacing: -0.9,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'Show More',
                          style: TextStyle(
                              color: Color(0xFF656565),
                              letterSpacing: -0.6,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ),
                new Container(
                  decoration: const BoxDecoration(
                    color: Color(0xfff3f3f3),
                  ),
                  child: new Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 12.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'Product or product packaging damaged during transit',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.46),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 16.0),
                        ),
                        const Text(
                          'REVIEWERS',
                          style: TextStyle(
                              color: Color(0xFF656565),
                              fontSize: 12.0,
                              letterSpacing: -0.6,
                              fontWeight: FontWeight.w500),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 8.0),
                        ),
                        new Row(
                          children: <Widget>[
                            new Container(
                              width: 44.0,
                              height: 44.0,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/flutter-mark-square-64.png')),
                                  shape: BoxShape.circle),
                            ),
                            const Padding(padding: EdgeInsets.only(left: 8.0)),
                            new Container(
                              width: 44.0,
                              height: 44.0,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    'passets/flutter-mark-square-64.png',
                                  ),
                                ),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 2.0),
                            ),
                            const Icon(
                              CupertinoIcons.check_mark_circled,
                              color: Color(0xff656565),
                              size: 20.0,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}

List<Widget> buildTab2Conversation() {
  return <Widget>[
    const Tab2ConversationRow(
      text: "My Xanadu doesn't look right",
    ),
    const Tab2ConversationRow(
      avatar: Tab2ConversationAvatar(
        text: 'KL',
        color: Color(0xFFFD5015),
      ),
      text: "We'll rush you a new one.\nIt's gonna be incredible",
    ),
    const Tab2ConversationRow(
      text: 'Awesome thanks!',
    ),
    const Tab2ConversationRow(
      avatar: Tab2ConversationAvatar(
        text: 'SJ',
        color: Color(0xFF34CAD6),
      ),
      text: "We'll send you our\nnewest Labrador too!",
    ),
    const Tab2ConversationRow(
      text: 'Yay',
    ),
    const Tab2ConversationRow(
      avatar: Tab2ConversationAvatar(
        text: 'KL',
        color: Color(0xFFFD5015),
      ),
      text: "Actually there's one more thing...",
    ),
    const Tab2ConversationRow(
      text: "What's that?",
    ),
  ];
}

class Tab2ConversationRow extends StatelessWidget {
  const Tab2ConversationRow({this.avatar, this.text});

  final Tab2ConversationAvatar avatar;
  final String text;

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[];
    if (avatar != null) children.add(avatar);
    final bool isSelf = avatar == null;
    children.add(new Tab2ConversationBubble(
      text: text,
      color: isSelf
          ? Tab2ConversationBubbleColor.blue
          : Tab2ConversationBubbleColor.gray,
    ));
    return new SafeArea(
      child: new Row(
        mainAxisAlignment:
            isSelf ? MainAxisAlignment.end : MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment:
            isSelf ? CrossAxisAlignment.center : CrossAxisAlignment.end,
        children: children,
      ),
    );
  }
}

class Tab2ConversationAvatar extends StatelessWidget {
  const Tab2ConversationAvatar({this.text, this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
          shape: BoxShape.circle,
          gradient: new LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: <Color>[
                color,
                new Color.fromARGB(
                    color.alpha,
                    (color.red - 60).clamp(0, 255),
                    (color.green - 60).clamp(0, 255),
                    (color.blue - 60).clamp(0, 255))
              ])),
      margin: const EdgeInsets.only(left: 8.0, bottom: 8.0),
      padding:const EdgeInsets.all(12.0),
      child: new Text(
        text,
        style: TextStyle(
            color: CupertinoColors.white,
            fontSize: 13.0,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}

enum Tab2ConversationBubbleColor {
  blue,
  gray,
}

class Tab2ConversationBubble extends StatelessWidget {
  Tab2ConversationBubble({this.text, this.color});

  final String text;
  final Tab2ConversationBubbleColor color;

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(18.0)),
        color: color == Tab2ConversationBubbleColor.blue
            ? CupertinoColors.activeBlue
            : CupertinoColors.lightBackgroundGray,
      ),
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
      child: new Text(
        text,
        style: new TextStyle(
            color: color == Tab2ConversationBubbleColor.blue
                ? CupertinoColors.white
                : CupertinoColors.black,
            letterSpacing: -0.4,
            fontSize: 15.0,
            fontWeight: FontWeight.w400),
      ),
    );
  }
}

class CupertinoDemoTab3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        trailing: ExitButton(),
      ),
      child: new DecoratedBox(
        decoration: const BoxDecoration(color: Color(0xFFEFEFF4)),
        child: new ListView(
          children: <Widget>[
            const Padding(padding: EdgeInsets.only(top: 32.0)),
            new GestureDetector(
              onTap: () {
                Navigator.of(context, rootNavigator: true).push(
                  new CupertinoPageRoute<bool>(
                    fullscreenDialog: true,
                    builder: (BuildContext context) => new Tab3Dialog(),
                  ),
                );
              },
              child: new Container(
                decoration: const BoxDecoration(
                  color: CupertinoColors.white,
                  border: Border(
                    top: BorderSide(color: Color(0xFFBCBBC1), width: 0.0),
                    bottom: BorderSide(color: Color(0xFFBCBBC1), width: 0.0),
                  ),
                ),
                height: 44.0,
                child: new Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: new SafeArea(
                    top: false,
                    bottom: false,
                    child: new Row(
                      children: const <Widget>[
                        Text(
                          'Sign in',
                          style: TextStyle(color: CupertinoColors.activeBlue),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Tab3Dialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new CupertinoPageScaffold(
      navigationBar: new CupertinoNavigationBar(
        leading: new CupertinoButton(
          child: const Text('Cancel'),
          padding: EdgeInsets.zero,
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
      ),
      child: new Center(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Icon(
              CupertinoIcons.profile_circled,
              size: 160.0,
              color: Color(0xFF646464),
            ),
            const Padding(padding: EdgeInsets.only(top: 18.0)),
            new CupertinoButton(
              color: CupertinoColors.activeBlue,
              child: const Text('Sign in'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(new MaterialApp(home: new CupertinoNavigation(),));
}
