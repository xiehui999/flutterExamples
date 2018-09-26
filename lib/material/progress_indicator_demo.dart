import 'package:flutter/material.dart';

class ProgressIndicatorDemo extends StatefulWidget {
  static const String routeName = '/material/progress-indicator';

  @override
  State<StatefulWidget> createState() {
    return ProgressIndicatorDemoState();
  }
}

class ProgressIndicatorDemoState extends State<ProgressIndicatorDemo>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: Duration(milliseconds: 3500),
        vsync: this,
        animationBehavior: AnimationBehavior.preserve)
      ..forward();
    _animation = CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.9, curve: Curves.fastOutSlowIn))
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.dismissed)
          _controller.forward();
        else if (status == AnimationStatus.completed) _controller.reverse();
      });
  }

  void handleTap() {
    setState(() {
      if (_controller.isAnimating)
        _controller.stop();
      else {
        switch (_controller.status) {
          case AnimationStatus.dismissed:
          case AnimationStatus.forward:
            _controller.forward();
            break;
          case AnimationStatus.reverse:
          case AnimationStatus.completed:
            _controller.reverse();
            break;
        }
      }
    });
  }

  Widget _buildIndicators(BuildContext context, Widget child) {
    final List<Widget> indicators = <Widget>[
      SizedBox(
        width: 200.0,
        child: LinearProgressIndicator(),
      ),
      LinearProgressIndicator(),
      LinearProgressIndicator(valueColor: new AlwaysStoppedAnimation(Colors.green),),
      LinearProgressIndicator(
        value: _animation.value,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(
            width: 20.0,
            height: 20.0,
            child: CircularProgressIndicator(
              value: _animation.value,
            ),
          ),
          SizedBox(
            width: 100.0,
            height: 20.0,
            child: Text('${(_animation.value * 100).toStringAsFixed(1)}%',textAlign: TextAlign.right,),
          )
        ],
      )
    ];
    return Column(
      children: indicators.map((Widget widget) {
        return Container(
          child: widget,
          margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        );
      }).toList(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Progress indicators'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: DefaultTextStyle(
              style: Theme.of(context).textTheme.title,
              child: GestureDetector(
                onTap: handleTap,
                behavior: HitTestBehavior.opaque,
                child: SafeArea(
                    top: false,
                    bottom: false,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                      child: AnimatedBuilder(
                          animation: _animation, builder: _buildIndicators),
                    )),
              )),
        ),
      ),
    );
  }
}
