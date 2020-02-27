import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:devtobe/front/welcome/values.dart';
import 'package:supernova_flutter_ui_toolkit/keyframes.dart';

Animation<double> _createTranslationYProperty(AnimationController animationController) => Interpolation<double>(keyframes: [
  Keyframe<double>(fraction: 0, value: 0),
  Keyframe<double>(fraction: 0.00001, value: 300),
  Keyframe<double>(fraction: 1, value: 0),
]).animate(CurvedAnimation(
  curve: Interval(0, 1, curve: Cubic(0.29, 0.87235, 1, 1)),
  parent: animationController,
));

Animation<double> _createOpacityProperty(AnimationController animationController) => Interpolation<double>(keyframes: [
  Keyframe<double>(fraction: 0, value: 1),
  Keyframe<double>(fraction: 0.00001, value: 0),
  Keyframe<double>(fraction: 1, value: 1),
]).animate(CurvedAnimation(
  curve: Interval(0, 1, curve: Cubic(0.42, 0, 0.58, 1)),
  parent: animationController,
));

Animation<double> _createRotationZProperty(AnimationController animationController) => Interpolation<double>(keyframes: [
  Keyframe<double>(fraction: 0, value: 0),
  Keyframe<double>(fraction: 0.00001, value: -45),
  Keyframe<double>(fraction: 0.7, value: -45),
  Keyframe<double>(fraction: 1, value: 0),
]).animate(CurvedAnimation(
  curve: Interval(0, 1, curve: Cubic(0.42, 0, 0.58, 1)),
  parent: animationController,
));


class WelcomeWidgetAnimation1 extends StatelessWidget {

  WelcomeWidgetAnimation1({
    Key key,
    this.child,
    @required AnimationController animationController
  }) : assert(animationController != null),
        this.translationY = _createTranslationYProperty(animationController),
        this.opacity = _createOpacityProperty(animationController),
        this.rotationZ = _createRotationZProperty(animationController),
        super(key: key);

  final Animation<double> translationY;
  final Animation<double> opacity;
  final Animation<double> rotationZ;
  final Widget child;


  @override
  Widget build(BuildContext context) {

    return AnimatedBuilder(
      animation: Listenable.merge([
        this.translationY,
        this.opacity,
        this.rotationZ,
      ]),
      child: this.child,
      builder: (context, widget) {

        return Opacity(
          opacity: this.opacity.value,
          child: Transform.translate(
            offset: Offset(0, this.translationY.value),
            child: Transform.rotate(
              angle: this.rotationZ.value / 180 * pi,
              alignment: Alignment.center,
              child: widget,
            ),
          ),
        );
      },
    );
  }
}