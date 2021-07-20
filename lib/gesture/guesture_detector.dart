import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kiuno_example/base.dart';

class GestureDetectorRoute extends BaseRoute {
  @override
  Widget build(BuildContext context) {
    return buildAppBar(
      context,
      'Kiuno\'s gesture detector',
      _GestureDetectorWidget(),
      // _Drag(),
      // _ScalePictureWidget(),
      // _GestureRecognizerWidget(),
      // _BothDirectionWidget(),
      // _GestureConflictTestRouteWidget(),
    );
  }
}

class _GestureDetectorWidget extends StatelessWidget {
  void updateText(BuildContext context, String clickEvent) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(clickEvent)));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        child: Container(
          alignment: Alignment.center,
          color: Colors.blue,
          width: 200.0,
          height: 100.0,
          child: Text(
            'Click me',
            style: TextStyle(color: Colors.white),
          ),
        ),
        onTap: () => updateText(context, 'SingleTap'),
        onDoubleTap: () => updateText(context, 'DoubleTap'),
        onLongPress: () => updateText(context, 'LongPress'),
      ),
    );
  }
}

class _Drag extends StatefulWidget {
  @override
  _DragState createState() => new _DragState();
}

class _DragState extends State<_Drag> with SingleTickerProviderStateMixin {
  double _top = 0.0;
  double _left = 0.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: _top,
          left: _left,
          child: GestureDetector(
            child: CircleAvatar(child: Text('A')),
            // onScaleUpdate: (ScaleUpdateDetails details) => {}, // gesture_detector.dart -> line: 280
            onPanDown: (DragDownDetails e) {
              debugPrint('使用者手指按下：${e.globalPosition}');
            },
            onPanUpdate: (DragUpdateDetails e) {
              setState(() {
                _left += e.delta.dx;
                _top += e.delta.dy;
              });
            },
            onPanEnd: (DragEndDetails e) {
              debugPrint(e.velocity.toString());
            },
          ),
        )
      ],
    );
  }
}

class _ScalePictureWidget extends StatefulWidget {
  @override
  _ScalePictureState createState() => _ScalePictureState();
}

class _ScalePictureState extends State<_ScalePictureWidget> {
  double _width = 200.0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        child: Image.asset('assets/lake.jpeg', width: _width),
        onScaleUpdate: (ScaleUpdateDetails details) {
          setState(() {
            _width = 200 * details.scale.clamp(.8, 10.0);
          });
        },
      ),
    );
  }
}

class _GestureRecognizerWidget extends StatefulWidget {
  @override
  _GestureRecognizerState createState() => _GestureRecognizerState();
}

class _GestureRecognizerState extends State<_GestureRecognizerWidget> {
  TapGestureRecognizer _tapGestureRecognizer = new TapGestureRecognizer();
  bool _toggle = false;

  @override
  void dispose() {
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(TextSpan(children: [
        TextSpan(text: '你好世界'),
        TextSpan(
          text: '點我變色',
          style: TextStyle(
              fontSize: 30.0, color: _toggle ? Colors.blue : Colors.red),
          recognizer: _tapGestureRecognizer
            ..onTap = () {
              setState(() {
                _toggle = !_toggle;
              });
            },
        ),
        TextSpan(text: '你好世界'),
      ])),
    );
  }
}

class _BothDirectionWidget extends StatefulWidget {
  @override
  _BothDirectionState createState() => _BothDirectionState();
}

class _BothDirectionState extends State<_BothDirectionWidget> {
  double _top = 0.0;
  double _left = 0.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: _top,
          left: _left,
          child: GestureDetector(
            child: CircleAvatar(child: Text('A')),
            onVerticalDragUpdate: (DragUpdateDetails details) {
              setState(() {
                _top += details.delta.dy;
              });
            },
            onHorizontalDragUpdate: (DragUpdateDetails details) {
              setState(() {
                _left += details.delta.dx;
              });
            },
          ),
        )
      ],
    );
  }
}

class _GestureConflictTestRouteWidget extends StatefulWidget {
  @override
  _GestureConflictTestRouteState createState() =>
      _GestureConflictTestRouteState();
}

class _GestureConflictTestRouteState
    extends State<_GestureConflictTestRouteWidget> {
  double _left = 0.0;
  double _leftB = 0.0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          left: _left,
          child: GestureDetector(
            child: CircleAvatar(child: Text('A')),
            onHorizontalDragUpdate: (DragUpdateDetails details) {
              setState(() {
                _left += details.delta.dx;
              });
            },
            onHorizontalDragEnd: (details) {
              debugPrint('onHorizontalDragEnd');
            },
            onTapDown: (details) {
              debugPrint('down');
            },
            onTapUp: (details) {
              debugPrint('up');
            },
          ),
        ),
        Positioned(
          top: 80.0,
          left: _leftB,
          child: Listener(
            onPointerDown: (details) {
              print('down');
            },
            onPointerUp: (details) {
              print('up');
            },
            child: GestureDetector(
              child: CircleAvatar(child: Text('B')),
              onHorizontalDragUpdate: (DragUpdateDetails details) {
                setState(() {
                  _leftB += details.delta.dx;
                });
              },
              onHorizontalDragEnd: (details) {
                print('onHorizontalDragEnd');
              },
            ),
          ),
        )
      ],
    );
  }
}
