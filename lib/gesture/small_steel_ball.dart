import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_kiuno_example/base.dart';

class SmallSteelBallRoute extends BaseRoute {
  @override
  Widget build(BuildContext context) {
    return buildMaterialApp(context, 'Startup Small Steel Ball',
        'Kiuno\'s small steel ball', _SmallSteelBallWidget());
  }
}

class _SmallSteelBallWidget extends StatefulWidget {
  @override
  _SmallSteelBallState createState() => _SmallSteelBallState();
}

class _SmallSteelBallState extends State<_SmallSteelBallWidget>
    with SingleTickerProviderStateMixin {
  final List<String> ballList = [
    'assets/ball1.png',
    'assets/ball2.png',
    'assets/ball3.png',
  ];

  int ballIndex = 0;

  late final _screenWidth;
  late final _screenHeight;
  late final _appBarHeight;
  late final _navigationBarHeight;

  late Animation<double> _animation;
  late AnimationController _controller;

  double _oldTop = 0.0;
  double _oldLeft = 0.0;
  double _newTop = 0.0;
  double _newLeft = 0.0;
  double _velocityX = 0.0;
  double _velocityY = 0.0;

  double _ballSize = 50.0;

  double _tempAnimationValue = 0.0;

  void _initScreenSize(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
    _appBarHeight = kToolbarHeight;
    _navigationBarHeight = MediaQueryData.fromWindow(window).padding.top;
    debugPrint(
        '_screenWidth: $_screenWidth, _screenHeight: $_screenHeight, _appBarHeight: $_appBarHeight, _navigationBarHeight: $_navigationBarHeight');
  }

  void _changeBall() {
    setState(() {
      int tempIndex = ballIndex;
      tempIndex++;
      if (tempIndex >= ballList.length) {
        ballIndex = 0;
      } else {
        ballIndex = tempIndex;
      }
    });
  }

  void _moveBall(double offsetX, double offsetY, bool rebound) {
    setState(() {
      _oldLeft = _newLeft;
      _oldTop = _newTop;

      double tempLeft = _oldLeft + offsetX;
      double tempTop = _oldTop + offsetY;
      if (tempLeft < 0.0) {
        tempLeft = 0.0;
        _velocityX = -_velocityX;
      } else if (tempLeft > _screenWidth - _ballSize) {
        tempLeft = _screenWidth - _ballSize;
        _velocityX = -_velocityX;
      }
      if (tempTop < 0.0) {
        tempTop = 0.0;
        _velocityY = -_velocityY;
      } else if (tempTop >
          _screenHeight - _ballSize - _appBarHeight - _navigationBarHeight) {
        tempTop =
            _screenHeight - _ballSize - _appBarHeight - _navigationBarHeight;
        _velocityY = -_velocityY;
      }
      _newLeft = tempLeft;
      _newTop = tempTop;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = _controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    _animation = Tween(begin: 0.0, end: max(_velocityX.abs(), _velocityY.abs()))
        .animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeOutQuint));
    _animation.addListener(() {
      double maxValue = max(_velocityX.abs(), _velocityY.abs());
      double offsetRatio = (_animation.value - _tempAnimationValue) / maxValue;
      debugPrint(
          'AnimationController.listener => animation.value: ${_animation.value}, maxValue: $maxValue, offsetRatio: $offsetRatio');
      _moveBall(
          offsetRatio * _velocityX / 10, offsetRatio * _velocityY / , true);
      _tempAnimationValue = _animation.value;
    });
    // _animation.addStatusListener((status) {
    // if (status == AnimationStatus.completed) {
    //   _controller.reverse();
    // } else if (status == AnimationStatus.dismissed) {
    //   _controller.forward();
    // }
    // });
    Future.delayed(Duration.zero, () {
      _initScreenSize(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: _newTop,
          left: _newLeft,
          child: GestureDetector(
            child: Image.asset(
              ballList[ballIndex],
              width: _ballSize,
              height: _ballSize,
            ),
            onTap: () => _changeBall(),
            onPanDown: (DragDownDetails e) {
              debugPrint("onPageDown： ${e.globalPosition}");
            },
            onPanUpdate: (DragUpdateDetails e) {
              _moveBall(e.delta.dx, e.delta.dy, false);
            },
            onPanEnd: (DragEndDetails e) {
              _tempAnimationValue = 0.0;
              _velocityX = e.velocity.pixelsPerSecond.dx;
              _velocityY = e.velocity.pixelsPerSecond.dy;
              debugPrint(
                  "onPanEnd： ${e.velocity}, _velocityX: $_velocityX, _velocityY: $_velocityY");
              _animation = Tween(
                      begin: 0.0, end: max(_velocityX.abs(), _velocityY.abs()))
                  .animate(CurvedAnimation(
                      parent: _controller, curve: Curves.easeOutQuint));
              _controller.reset();
              _controller.forward();
            },
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
