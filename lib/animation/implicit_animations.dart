import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_kiuno_example/base.dart';

const _duration = Duration(milliseconds: 400);

double randomBorderRadius() {
  return Random().nextDouble() * 64;
}

double randomMargin() {
  return Random().nextDouble() * 64;
}

Color randomColor() {
  return Color(0xFFFFFFFF & Random().nextInt(0xFFFFFFFF));
}

class ImplicitAnimationsRoute extends BaseRoute {
  @override
  Widget build(BuildContext context) {
    return buildAppBar(
      context,
      'Kiuno\'s implicit animation',
      _ImplicitAnimationsWidget(),
    );
  }
}

class _ImplicitAnimationsWidget extends StatefulWidget {
  @override
  _ImplicitAnimationsState createState() => _ImplicitAnimationsState();
}

class _ImplicitAnimationsState extends State<_ImplicitAnimationsWidget> {
  double opacityLevel = 0.0;

  late Color color;
  late double borderRadius;
  late double margin;

  @override
  void initState() {
    super.initState();
    color = Colors.deepPurple;
    borderRadius = randomBorderRadius();
    margin = randomMargin();
  }

  void change() {
    setState(() {
      color = randomColor();
      borderRadius = randomBorderRadius();
      margin = randomMargin();
    });
  }

  void show() {
    setState(() => opacityLevel = 1.0);
  }

  void hide() {
    setState(() => opacityLevel = 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: <Widget>[
        AnimatedOpacity(
          duration: const Duration(seconds: 1),
          opacity: opacityLevel,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: SizedBox(
              width: 256,
              height: 256,
              child: AnimatedContainer(
                margin: EdgeInsets.all(margin),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                duration: _duration,
                curve: Curves.easeInOutBack,
              ),
            ),
          ),
        ),
        ElevatedButton(
          child: Text('change'),
          onPressed: () => change(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child:
                  ElevatedButton(onPressed: () => show(), child: Text('Show')),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child:
                  ElevatedButton(onPressed: () => hide(), child: Text('Hide')),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
              '注意：如果需要 show/hide 兩個動畫功能，其實不該使用 Implicit Animation，因為這個動畫屬於不連續性'),
        ),
      ]),
    );
  }
}
