import 'dart:math' as Math;

import 'package:flutter/material.dart';

class SliderDemo extends StatefulWidget {
  static const String routeName = '/material/slider';

  @override
  State<StatefulWidget> createState() {
    return SliderDemoState();
  }
}

Path _triangle(double size, Offset thumbCenter, {bool invert = false}) {
  final Path thumbPath = Path();
  final double height = Math.sqrt(3.0) / 2.0;
  final double halfSide = size / 2.0;
  final double centerHeight = size * height / 3.0;
  final double sign = invert ? -1.0 : 1.0;
  thumbPath.moveTo(
      thumbCenter.dx - halfSide, thumbCenter.dy + sign * centerHeight);
  thumbPath.lineTo(thumbCenter.dx, thumbCenter.dy - 2.0 * sign * centerHeight);
  thumbPath.lineTo(
      thumbCenter.dx + halfSide, thumbCenter.dy + sign * centerHeight);
  thumbPath.close();
  return thumbPath;
}

class _CustomThumbShape extends SliderComponentShape {
  static const double _thumbSize = 4.0;
  static const double _disabledThumbSize = 3.0;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return isEnabled
        ? Size.fromRadius(_thumbSize)
        : Size.fromRadius(_disabledThumbSize);
  }

  static final Tween<double> sizeTween =
      Tween<double>(begin: _disabledThumbSize, end: _thumbSize);

  @override
  Future<void> paint(PaintingContext context, Offset thumbCenter,
      {Animation<double> activationAnimation,
      Animation<double> enableAnimation,
      bool isDiscrete,
      TextPainter labelPainter,
      RenderBox parentBox,
      SliderThemeData sliderTheme,
      TextDirection textDirection,
      double value,
      double textScaleFactor,
      Size sizeWithOverflow}) async {
    final Canvas canvas = context.canvas;
    final ColorTween colorTween = ColorTween(
        begin: sliderTheme.disabledThumbColor, end: sliderTheme.thumbColor);
    final double size = _thumbSize * sizeTween.evaluate(enableAnimation);
    final Path thumbPath = _triangle(size, thumbCenter);
    canvas.drawPath(
        thumbPath, Paint()..color = colorTween.evaluate(enableAnimation));
  }
}

class _CustomValueIndicatorShape extends SliderComponentShape {
  static const double _indicatorSize = 4.0;
  static const double _disabledIndicatorSize = 3.0;
  static const double _slideUpHeight = 40.0;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(isEnabled ? _indicatorSize : _disabledIndicatorSize);
  }

  static final Tween<double> sizeTween = Tween<double>(
    begin: _disabledIndicatorSize,
    end: _indicatorSize,
  );

  @override
  void paint(PaintingContext context, Offset thumbCenter,
      {Animation<double> activationAnimation,
      Animation<double> enableAnimation,
      bool isDiscrete,
      TextPainter labelPainter,
      RenderBox parentBox,
      SliderThemeData sliderTheme,
      TextDirection textDirection,
      double value,
      double textScaleFactor,
      Size sizeWithOverflow}) {
    final Canvas canvas = context.canvas;
    final ColorTween enableColor = ColorTween(
        begin: sliderTheme.disabledThumbColor,
        end: sliderTheme.valueIndicatorColor);
    final Tween<double> slideUpTween =
        Tween<double>(begin: 0.0, end: _slideUpHeight);
    final double size = _indicatorSize * sizeTween.evaluate(enableAnimation);
    final Offset slideUpOffset =
        Offset(0.0, -slideUpTween.evaluate(activationAnimation));
    final Path thumbPath =
        _triangle(size, thumbCenter + slideUpOffset, invert: true);
    final Color paintColor = enableColor
        .evaluate(enableAnimation)
        .withAlpha((255.0 * activationAnimation.value).round());
    canvas.drawPath(thumbPath, Paint()..color = paintColor);
    canvas.drawLine(
        thumbCenter,
        thumbCenter + slideUpOffset,
        Paint()
          ..color = paintColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0);
    labelPainter.paint(
        canvas,
        thumbCenter +
            slideUpOffset +
            Offset(-labelPainter.width / 2.0, -labelPainter.height - 4.0));
  }
}

class SliderDemoState extends State<SliderDemo> {
  double _value = 25.0;
  double _discreteValue = 20.0;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Sliders'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Slider(
                    value: _value,
                    min: 0.0,
                    max: 100.0,
                    onChanged: (double value) {
                      setState(() {
                        _value = value;
                      });
                    }),
                Text('Continuous')
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Slider(value: 0.25, onChanged: null),
                Text('Disabled'),
              ],
            ),
            // divisions 划分为几段
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Slider(
                    value: _discreteValue,
                    min: 0.0,
                    max: 200.0,
                    divisions: 5,
                    label: '${_discreteValue.round()}',
                    onChanged: (double value) {
                      setState(() {
                        _discreteValue = value;
                      });
                    })
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SliderTheme(
                    data: themeData.sliderTheme.copyWith(
                        activeTrackColor: Colors.deepPurple,
                        inactiveTrackColor: Colors.black26,
                        activeTickMarkColor: Colors.white70,
                        inactiveTickMarkColor: Colors.black,
                        overlayColor: Colors.black12,
                        thumbColor: Colors.deepPurple,
                        valueIndicatorColor: Colors.deepPurpleAccent,
                        thumbShape: _CustomThumbShape(),
                        valueIndicatorShape: _CustomValueIndicatorShape(),
                        valueIndicatorTextStyle: themeData.accentTextTheme.body2
                            .copyWith(color: Colors.black87)),
                    child: Slider(
                        value: _discreteValue,
                        min: 0.0,
                        max: 200.0,
                        divisions: 5,
                        semanticFormatterCallback: (double value) {
                          return value.round().toString();
                        },
                        label: '${_discreteValue.round()}',
                        onChanged: (double value) {
                          setState(() {
                            _discreteValue = value;
                          });
                        })),
                Text('Discrete with Custom Theme')
              ],
            )
          ],
        ),
      ),
    );
  }
}
