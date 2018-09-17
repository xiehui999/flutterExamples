import 'package:flutter/material.dart';
import 'example_code_parser.dart';

class ComponentDemoTabData {
  ComponentDemoTabData(
      {this.demoWidget, this.exampleCodeTag, this.description, this.tabName});

  final Widget demoWidget;
  final String exampleCodeTag;
  final String description;
  final String tabName;

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    final ComponentDemoTabData typeOther = other;
    return typeOther.tabName == tabName && typeOther.description == description;
  }

  @override
  int get hashCode => hashValues(tabName.hashCode, description.hashCode);
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
      Navigator.push(context, MaterialPageRoute(builder: null));
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
  String  exampleCode;
  //widget  生命周期，在initState之后执行，只执行一次
  @override
  void didChangeDependencies() {

    getExampleCode(widget.exampleCodeTag, DefaultAssetBundle.of(context)).then<Null>((String code){
      if(mounted){
        setState(() {
          exampleCode=code??'Example code not fount';
        });
      }
    });
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {

  }
}
