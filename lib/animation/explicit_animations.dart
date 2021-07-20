import 'package:flutter/material.dart';
import 'package:flutter_kiuno_example/base.dart';

class ExplicitAnimationsRoute extends BaseRoute {
  @override
  Widget build(BuildContext context) {
    return buildAppBar(
      context,
      'Kiuno\'s explicit animations',
      _ExplicitAnimationsWidget(),
    );
  }
}

class _ExplicitAnimationsWidget extends StatefulWidget {
  @override
  _ExplicitAnimationsState createState() => _ExplicitAnimationsState();
}

class _ExplicitAnimationsState extends State<_ExplicitAnimationsWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 15), vsync: this)
          ..repeat();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: Center(
          child: RotationTransition(
            alignment: Alignment.center,
            turns: _controller,
            child: Image.asset('assets/earth.jpeg'),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
