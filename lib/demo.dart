import 'package:flutter/material.dart';
import 'example_code_parser.dart';
import 'syntax_highlighter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_app/listItem.dart';

class ComponentDemoTabData {
  ComponentDemoTabData(
      {this.demoWidget,
      this.exampleCodeTag,
      this.description,
      this.tabName,
      this.documentationUrl});

  final Widget demoWidget;
  final String exampleCodeTag;
  final String description;
  final String tabName;
  final String documentationUrl;

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    final ComponentDemoTabData typeOther = other;
    return typeOther.tabName == tabName &&
        typeOther.description == description &&
        typeOther.documentationUrl == documentationUrl;
  }

  @override
  int get hashCode => hashValues(tabName, description, documentationUrl);
}

class TabbedComponentDemoScaffold extends StatelessWidget {
  const TabbedComponentDemoScaffold({this.demos, this.title, this.actions});

  final List<ComponentDemoTabData> demos;
  final String title;
  final List<Widget> actions;

  void _showExampleCode(BuildContext context) {
    final String tag =
        demos[DefaultTabController.of(context).index].exampleCodeTag;
    if (tag != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => FullScreenCodeDialog(
                    exampleCodeTag: tag,
                  )));
    }
  }

  void _showApiDocumentation(BuildContext context) {
    final String url =
        demos[DefaultTabController.of(context).index].documentationUrl;
    if (url != null) {
      launch(url, forceWebView: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: demos.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text(title),
            actions: (actions ?? <Widget>[])
              ..addAll(
                <Widget>[
                  Builder(builder: (BuildContext context) {
                    return IconButton(
                        icon: Icon(Icons.library_books),
                        onPressed: () {
                          _showApiDocumentation(context);
                        });
                  }),
                  Builder(builder: (BuildContext context) {
                    return IconButton(
                        icon: Icon(Icons.code),
                        tooltip: 'show example code',
                        onPressed: () {
                          _showExampleCode(context);
                        });
                  })
                ],
              ),
            bottom: TabBar(
              isScrollable: true,
              tabs: demos
                  .map((ComponentDemoTabData data) => Tab(text: data.tabName))
                  .toList(),
            ),
          ),
          body: TabBarView(
            children: demos.map((ComponentDemoTabData demo) {
              return SafeArea(
                  top: false,
                  bottom: false,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          demo.description,
                          style: Theme.of(context).textTheme.subhead,
                        ),
                      ),
                      Expanded(child: demo.demoWidget)
                    ],
                  ));
            }).toList(),
          ),
        ));
  }
}

class FullScreenCodeDialog extends StatefulWidget {
  const FullScreenCodeDialog({this.exampleCodeTag});

  final String exampleCodeTag;

  @override
  State<StatefulWidget> createState() {
    return FullScreenCodeDialogState();
  }
}

class FullScreenCodeDialogState extends State<FullScreenCodeDialog> {
  String exampleCode;

  //widget  生命周期，在initState之后执行，只执行一次
  @override
  void didChangeDependencies() {
    print('exampleCodeTag');
    print(widget.exampleCodeTag);
    getExampleCode(widget.exampleCodeTag, DefaultAssetBundle.of(context))
        .then<Null>((String code) {
      if (mounted) {
        setState(() {
          exampleCode = code ?? 'Example code not fount';
        });
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final SyntaxHighlighterStyle style =
        Theme.of(context).brightness == Brightness.dark
            ? SyntaxHighlighterStyle.darkThemeStyle()
            : SyntaxHighlighterStyle.lightThemeStyle();
    Widget body;
    if (exampleCode == null) {
      body = const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      body = SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: RichText(
              text: TextSpan(
                  style: TextStyle(fontFamily: 'monospace', fontSize: 10.0),
                  children: <TextSpan>[
                DartSyntaxHighlighter(style).format(exampleCode)
              ])),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.clear,
            semanticLabel: 'Close',
          ),
        ),
        title: Text('Example code'),
      ),
      body: body,
    );
  }
}

class MaterialDemoDocumentationButton extends StatelessWidget {
  MaterialDemoDocumentationButton(String routeName, {Key key})
      : documentationUrl = kDemoDocumentationUrl[routeName],
        assert(kDemoDocumentationUrl[routeName] != null,
            'A documentation URL was not specified for demo route $routeName in kAllGalleryDemos',),
        super(key: key);
  final String documentationUrl;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.library_books),
        onPressed: () {
          launch(documentationUrl, forceWebView: true);
        });
  }
}
