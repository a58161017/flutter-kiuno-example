import 'package:flutter/material.dart';
import 'package:flutter_kiuno_example/base.dart';
import 'package:flutter_kiuno_example/widget/rebound_ball.dart';

const int BALL_SIZE = 50;

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

class _SmallSteelBallState extends State<_SmallSteelBallWidget> {
  GlobalKey<ReboundBallState> _reboundBallGlobalKey = GlobalKey();
  GlobalKey _stackGlobalKey = GlobalKey();
  List<GlobalKey> _obstacleGlobalKeyList = [GlobalKey(), GlobalKey()];
  List<_ObjectInfo?> _obstacleObjList = [];
  List<int> _obstacleHealthList = [10, 10];

  final List<String> ballList = [
    'assets/small_steel_ball.png',
    'assets/ball1.png',
    'assets/ball2.png',
    'assets/ball3.png',
  ];

  int _ballIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      key: _stackGlobalKey,
      children: <Widget>[
        Positioned(
          key: _obstacleGlobalKeyList[0],
          left: 100.0,
          top: 150.0,
          child: Container(
            width: 100,
            height: 100,
            child: Stack(
              children: [
                Image.asset(_obstacleHealthList[0] > 0
                    ? 'assets/bricks.png'
                    : 'assets/bricks_broken.png'),
                Center(
                  child: Text(
                    'HP:${_obstacleHealthList[0]}',
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          key: _obstacleGlobalKeyList[1],
          right: 100.0,
          bottom: 150.0,
          child: Container(
            width: 100,
            height: 100,
            child: Stack(
              children: [
                Image.asset(_obstacleHealthList[1] > 0
                    ? 'assets/bricks.png'
                    : 'assets/bricks_broken.png'),
                Center(
                  child: Text(
                    'HP:${_obstacleHealthList[1]}',
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
        ReboundBall(
          key: _reboundBallGlobalKey,
          size: BALL_SIZE,
          hasAppBar: true,
          resource: ballList[_ballIndex],
          left: 30.0,
          top: 30.0,
          onBallTap: _onBallTap,
          onBallMoved: _onBallMoved,
        )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onBallTap() {
    int tempIndex = _ballIndex;
    _ballIndex = (++tempIndex >= ballList.length) ? 0 : tempIndex;
    _reboundBallGlobalKey.currentState?.changeBall(ballList[_ballIndex]);
  }

  void _onBallMoved(double dx, double dy, Size size) {
    var results = _checkCollision(_ObjectInfo(dx: dx, dy: dy, size: size));
    _reboundBallGlobalKey.currentState
        ?.changeDirection(results[0] || results[2], results[1] || results[3]);
  }

  // List<bool>[left, top, right, bottom]
  List<bool> _checkCollision(_ObjectInfo ball) {
    var results = [false, false, false, false];
    if (_obstacleObjList.length == 0) {
      _obstacleGlobalKeyList.forEach((obstacleGlobalKey) {
        var obstacleObj =
            _getObjectInfoFromGlobalKey(_stackGlobalKey, obstacleGlobalKey);
        _obstacleObjList.add(obstacleObj);
      });
    }
    for (var i = 0; i < _obstacleObjList.length; i++) {
      if (_obstacleObjList[i] != null && _obstacleHealthList[i] > 0) {
        final tempResults = ball.compareCollisionPoint(_obstacleObjList[i]!);
        final hasCollision = tempResults[0] ||
            tempResults[1] ||
            tempResults[2] ||
            tempResults[3];
        if (hasCollision) {
          setState(() => _obstacleHealthList[i]--);
        }
        results[0] |= tempResults[0];
        results[1] |= tempResults[1];
        results[2] |= tempResults[2];
        results[3] |= tempResults[3];
      }
    }
    return results;
  }

  _ObjectInfo? _getObjectInfoFromGlobalKey(
      GlobalKey parentKey, GlobalKey childKey) {
    RenderBox? childRenderBox =
        childKey.currentContext?.findRenderObject() as RenderBox?;
    RenderBox? parentRenderBox =
        parentKey.currentContext?.findRenderObject() as RenderBox?;
    if (childRenderBox != null && parentRenderBox != null) {
      Offset childOffset = childRenderBox.localToGlobal(Offset.zero);
      Offset childRelativeToParent = parentRenderBox.globalToLocal(childOffset);
      // debugPrint(
      //     'Obstacle._getObjectInfoFromGlobalKey() => dx: ${childRelativeToParent.dx}, dy: ${childRelativeToParent.dy}, size: ${childRenderBox.size}');
      return _ObjectInfo(
          dx: childRelativeToParent.dx,
          dy: childRelativeToParent.dy,
          size: childRenderBox.size);
    } else {
      return null;
    }
  }
}

class _ObjectInfo {
  const _ObjectInfo({required this.dx, required this.dy, required this.size});

  final double dx;
  final double dy;
  final Size size;

  Rect getRect() {
    return Rect.fromLTRB(dx, dy, dx + size.width, dy + size.height);
  }

  // List<bool>[left, top, right, bottom]
  List<bool> compareCollisionPoint(_ObjectInfo otherObj) {
    var results = [false, false, false, false];
    var rect = getRect();
    var otherRect = otherObj.getRect();
    var corners = [
      // [leftTop, rightTop, leftBottom, rightBottom]
      (rect.left >= otherRect.left && rect.left <= otherRect.right) &&
          (rect.top >= otherRect.top && rect.top <= otherRect.bottom),
      (rect.right >= otherRect.left && rect.right <= otherRect.right) &&
          (rect.top >= otherRect.top && rect.top <= otherRect.bottom),
      (rect.left >= otherRect.left && rect.left <= otherRect.right) &&
          (rect.bottom >= otherRect.top && rect.bottom <= otherRect.bottom),
      (rect.right >= otherRect.left && rect.right <= otherRect.right) &&
          (rect.bottom >= otherRect.top && rect.bottom <= otherRect.bottom),
    ];
    if (corners[0] && corners[2]) {
      results[0] = true;
    } else if (corners[0] && corners[1]) {
      results[1] = true;
    } else if (corners[1] && corners[3]) {
      results[2] = true;
    } else if (corners[2] && corners[3]) {
      results[3] = true;
    } else if (corners[0]) {
      double topOffset =
          _getOffset(rect.left, rect.right, otherRect.left, otherRect.right);
      double leftOffset =
          _getOffset(rect.top, rect.bottom, otherRect.top, otherRect.bottom);
      if (topOffset == leftOffset) {
        results[0] = true;
        results[1] = true;
      } else if (topOffset > leftOffset) {
        results[1] = true;
      } else {
        results[0] = true;
      }
    } else if (corners[1]) {
      double topOffset =
          _getOffset(rect.left, rect.right, otherRect.left, otherRect.right);
      double rightOffset =
          _getOffset(rect.top, rect.bottom, otherRect.top, otherRect.bottom);
      if (topOffset == rightOffset) {
        results[1] = true;
        results[2] = true;
      } else if (topOffset > rightOffset) {
        results[1] = true;
      } else {
        results[2] = true;
      }
    } else if (corners[2]) {
      double bottomOffset =
          _getOffset(rect.left, rect.right, otherRect.left, otherRect.right);
      double leftOffset =
          _getOffset(rect.top, rect.bottom, otherRect.top, otherRect.bottom);
      if (bottomOffset == leftOffset) {
        results[0] = true;
        results[3] = true;
      } else if (bottomOffset > leftOffset) {
        results[3] = true;
      } else {
        results[0] = true;
      }
    } else if (corners[3]) {
      double bottomOffset =
          _getOffset(rect.left, rect.right, otherRect.left, otherRect.right);
      double rightOffset =
          _getOffset(rect.top, rect.bottom, otherRect.top, otherRect.bottom);
      if (bottomOffset == rightOffset) {
        results[2] = true;
        results[3] = true;
      } else if (bottomOffset > rightOffset) {
        results[3] = true;
      } else {
        results[2] = true;
      }
    }
    return results;
  }

  double _getOffset(
      double obj1Val1, double obj1Val2, double obj2Val1, double obj2Val2) {
    return (obj2Val1 >= obj1Val1 && obj2Val1 <= obj1Val2)
        ? (obj1Val2 - obj2Val1).abs()
        : (obj1Val1 - obj2Val2).abs();
  }
}
