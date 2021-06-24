import 'package:flutter/material.dart';

import '../base.dart';

class TweenAnimationBuilderRoute extends BaseRoute {
  @override
  Widget build(BuildContext context) {
    return buildMaterialApp(
      context,
      'Startup Tween Animation Builder',
      'Kiuno\'s tween animation builder',
      _TweenAnimationBuilderWidget(),
    );
  }
}

class _TweenAnimationBuilderWidget extends StatefulWidget {
  @override
  _TweenAnimationBuilderState createState() => _TweenAnimationBuilderState();
}

class _TweenAnimationBuilderState extends State<_TweenAnimationBuilderWidget> {
  double targetValue = 32.0;

  void scale() {
    setState(() => targetValue = (targetValue == 32.0) ? 64.0 : 32.0);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(24),
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: targetValue),
            duration: const Duration(seconds: 1),
            builder: (BuildContext context, double size, Widget? child) {
              return Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: child,
              );
            },
            child: Icon(
              Icons.wifi,
              color: Colors.white,
            ),
          ),
        ),
        ElevatedButton(
          child: Text('scale'),
          onPressed: () => scale(),
        ),
      ]),
    );
  }
}
