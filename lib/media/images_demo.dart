import 'package:flutter/material.dart';
import '../demo.dart';

class ImagesDemo extends StatelessWidget {
  static const String routeName = '/images';

  @override
  Widget build(BuildContext context) {
    return TabbedComponentDemoScaffold(
      title: 'Animated images',
      demos: <ComponentDemoTabData>[
        ComponentDemoTabData(
            tabName: 'Webp',
            description: '',
            exampleCodeTag: 'animated_imgaes',
            demoWidget: Semantics(
              label: 'Example of animation WEBP',
              child: Image.asset('assets/animated_flutter_stickers.webp'),
            )),
        ComponentDemoTabData(
            tabName: 'GIF',
            description: '',
            exampleCodeTag: 'animated_imgaes',
            demoWidget: Semantics(
              label: 'Example of animation Gif',
              child: Image.asset('assets/animated_flutter_lgtm.gif'),
            ))
      ],
    );
  }
}
