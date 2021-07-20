import 'package:flutter/material.dart';
import 'package:flutter_kiuno_example/base.dart';

class SwitcherAnimationRoute extends BaseRoute {
  @override
  Widget build(BuildContext context) {
    return buildAppBar(
      context,
      'Kiuno\'s switcher animation',
      _SwitcherAnimationWidget(),
    );
  }
}

class _SwitcherAnimationWidget extends StatefulWidget {
  @override
  _SwitcherAnimationState createState() => _SwitcherAnimationState();
}

class _SwitcherAnimationState extends State<_SwitcherAnimationWidget> {
  int _index = 0;

  var _colors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(child: child, scale: animation);
            },
            child: Container(
              width: 150,
              height: 150,
              key: ValueKey<int>(_index),
              decoration: BoxDecoration(color: _colors[_index]),
            ),
          ),
          ElevatedButton(
            child: const Text(
              'Change color',
            ),
            onPressed: () {
              setState(() {
                _index = (_index == _colors.length - 1) ? 0 : _index + 1;
              });
            },
          ),
        ],
      ),
    );
  }
}
