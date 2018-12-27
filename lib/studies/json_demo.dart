import 'package:flutter/material.dart';
import 'package:flutter_app/model/User.dart';
import 'dart:convert';

class JsonDemo extends StatefulWidget {
  static const String routeName = '/json'; // Used by the Gallery app.
  @override
  State<StatefulWidget> createState() {
    return new JsonDemoState();
  }
}

class JsonDemoState extends State<JsonDemo> {
  String _jsonText = '';
  bool isObj = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Json Parse"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          Text(_jsonText),
          RaisedButton(
            onPressed: () {
              if (!isObj) {
                var obj = new User("测试名字", "xiehui0902@163.com");
                setState(() {
                  isObj = true;
                  _jsonText = json.encode(obj);
                });
              } else {
                //decode返回时一个Map<String, dynamic>对象，这意味着只有运行时才知道类型，我们失去了大部分静态类型语言特性：类型安全、自动补全和最重要的编译时异常。这样一来，我们的代码可能会变得非常容易出错。
                setState(() {
                  isObj = false;
                  var user = User.fromJson(json.decode(_jsonText));
                  _jsonText = user.name + json.decode(_jsonText)["email"];
                });
              }
            },
            child: Text("Json"),
          )
        ],
      ),
    );
  }
}
