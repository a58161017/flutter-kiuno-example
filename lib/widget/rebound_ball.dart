import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kiuno_example/util/widget_util.dart';

const String DEFAULT_RESOURCE = 'assets/small_steel_ball.png';

class ReboundBall extends StatefulWidget {
  const ReboundBall({
    Key? key,
    required this.size,
    required this.hasAppBar,
    this.resource,
    this.left,
    this.top,
    this.onBallTap,
    this.onBallMoved,
  }) : super(key: key);

  final int size;
  final bool hasAppBar;
  final String? resource;
  final double? left;
  final double? top;
  final VoidCallback? onBallTap;
  final Function(double dx, double dy, Size size)? onBallMoved;

  @override
  ReboundBallState createState() => ReboundBallState();
}

class ReboundBallState extends State<ReboundBall>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller;

  late final _screenWidth;
  late final _screenHeight;
  late final _appBarHeight;
  late final _navigationBarHeight;

  String _resource = DEFAULT_RESOURCE;
  double _size = 50.0;

  double _oldTop = 0.0;
  double _oldLeft = 0.0;
  double _newTop = 0.0;
  double _newLeft = 0.0;
  double _velocityX = 0.0;
  double _velocityY = 0.0;

  double _tempAnimationValue = 0.0;

  void changeBall(String resource) {
    setState(() => _resource = resource);
  }

  void changeDirection(bool horizontal, bool vertical) {
    if (horizontal) _velocityX = -_velocityX;
    if (vertical) _velocityY = -_velocityY;
  }

  @override
  void initState() {
    super.initState();
    _initParams();
    _initAnimation();

    Future.delayed(Duration.zero, () {
      _initScreenSize(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: _newTop,
      left: _newLeft,
      child: GestureDetector(
        child: Image.asset(
          _resource,
          width: _size,
          height: _size,
        ),
        onTap: () {
          if (widget.onBallTap != null) {
            widget.onBallTap!();
          }
        },
        onPanDown: (DragDownDetails e) {
          debugPrint('onPageDown： ${e.globalPosition}');
        },
        onPanUpdate: (DragUpdateDetails e) {
          _moveBall(e.delta.dx, e.delta.dy, false);
        },
        onPanEnd: (DragEndDetails e) {
          _tempAnimationValue = 0.0;
          double tempVelocityX = e.velocity.pixelsPerSecond.dx;
          double tempVelocityY = e.velocity.pixelsPerSecond.dy;
          debugPrint('onPanEnd： ${e.velocity}');
          if (tempVelocityX.abs() >= 50 || tempVelocityY.abs() >= 50) {
            _velocityX = tempVelocityX;
            _velocityY = tempVelocityY;
            final maxVelocity = max(_velocityX.abs(), _velocityY.abs());
            _animation = Tween(begin: 0.0, end: maxVelocity).animate(
                CurvedAnimation(
                    parent: _controller, curve: Curves.easeOutQuint));
            _controller.reset();
            _controller.duration =
                Duration(milliseconds: max(1000, maxVelocity.toInt()));
            _controller.forward();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _initParams() {
    if (widget.resource != null) changeBall(widget.resource!);
    _size = widget.size.toDouble();
    _newLeft = (widget.left != null) ? widget.left! : 0.0;
    _newTop = (widget.top != null) ? widget.top! : 0.0;
  }

  void _initAnimation() {
    _controller = _controller = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    _animation = Tween(begin: 0.0, end: max(_velocityX.abs(), _velocityY.abs()))
        .animate(
            CurvedAnimation(parent: _controller, curve: Curves.decelerate));
    _animation.addListener(() {
      double maxValue = max(_velocityX.abs(), _velocityY.abs());
      double offsetRatio = (_animation.value - _tempAnimationValue) / maxValue;
      debugPrint('AnimationController.listener => '
          'animation.value: ${_animation.value}, '
          'maxValue: $maxValue, '
          'offsetRatio: $offsetRatio');
      if (widget.onBallMoved != null)
        widget.onBallMoved!(_newLeft, _newTop, Size(_size, _size));
      _moveBall(
          offsetRatio * _velocityX / 2, offsetRatio * _velocityY / 2, true);
      _tempAnimationValue = _animation.value;
    });
    // _animation.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     _controller.reverse();
    //   } else if (status == AnimationStatus.dismissed) {
    //     _controller.forward();
    //   }
    // });
  }

  void _initScreenSize(BuildContext context) {
    final Size _screenSize = WidgetUtil.getScreenSize(context);
    _screenWidth = _screenSize.width;
    _screenHeight = _screenSize.height;
    _appBarHeight = widget.hasAppBar ? kToolbarHeight : 0.0;
    _navigationBarHeight = WidgetUtil.getNavigatorHeight(context);
    debugPrint('_SmallSteelBallWidget._initScreenSize() => '
        '_screenWidth: $_screenWidth, '
        '_screenHeight: $_screenHeight, '
        '_appBarHeight: $_appBarHeight, '
        '_navigationBarHeight: $_navigationBarHeight');
  }

  void _moveBall(double offsetX, double offsetY, bool rebound) {
    setState(() {
      _oldLeft = _newLeft;
      _oldTop = _newTop;

      double tempLeft = _oldLeft + offsetX;
      double tempTop = _oldTop + offsetY;
      if (tempLeft < 0.0) {
        tempLeft = 0.0;
        changeDirection(true, false);
      } else if (tempLeft > _screenWidth - _size) {
        tempLeft = _screenWidth - _size;
        changeDirection(true, false);
      }
      if (tempTop < 0.0) {
        tempTop = 0.0;
        changeDirection(false, true);
      } else if (tempTop >
          _screenHeight - _size - _appBarHeight - _navigationBarHeight) {
        tempTop = _screenHeight - _size - _appBarHeight - _navigationBarHeight;
        changeDirection(false, true);
      }
      _newLeft = tempLeft;
      _newTop = tempTop;
    });
  }
}
