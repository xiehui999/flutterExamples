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
              fontFamily: '.SF UI Text',
              color: CupertinoColors.black),
          child: new CupertinoTabScaffold(
              tabBar:
                  new CupertinoTabBar(items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.home), title: Text('Home')),
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.conversation_bubble),
                    title: Text('Support')),
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.profile_circled),
                    title: Text('Profile'))
              ]),
              tabBuilder: (BuildContext context, int index) {
                assert(index >= 0 && index <= 2);
                switch (index) {
                  case 0:
                    return new CupertinoTabView(
                      builder: (BuildContext context) {
                        return new CupertinoDemoTab2();
                      },
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
                        return new CupertinoDemoTab2();
                      },
                    );
                    break;
                }
                return null;
              })),
    );
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
  ExitButton();

  @override
  Widget build(BuildContext context) {
    return new CupertinoButton(
        padding: EdgeInsets.zero,
        child: Tooltip(
          message: 'Back',
          child: Text('Exit'),
          excludeFromSemantics: true,
        ),
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pop();
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  decoration: const BoxDecoration(
                    color: Color(0xffe5e5e5),
                  ),
                  child: new Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 12.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Product or product packaging damaged during transit',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.46),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 16.0),
                        ),
                        Text(
                          'REVIEWERS',
                          style: TextStyle(
                              color: Color(0xFF656565),
                              fontSize: 12.0,
                              letterSpacing: -0.6,
                              fontWeight: FontWeight.w500),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8.0),
                        ),
                        new Row(
                          children: <Widget>[
                            new Container(
                              width: 44.0,
                              height: 44.0,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/flutter-mark-square-64.png')),
                                  shape: BoxShape.circle),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 3.0),
                            ),
                            Icon(
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
      margin: EdgeInsets.only(left: 8.0, bottom: 8.0),
      padding: EdgeInsets.all(12.0),
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

void main(){
  runApp(new CupertinoNavigation());
}