import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_kiuno_example/base.dart';

class StatefulBasicRoute extends BaseRoute {
  @override
  Widget build(BuildContext context) {
    return buildAppBar(
      context,
      'Kiuno\'s stateful basic',
      _Counter(),
    );
  }
}

class _Counter extends StatefulWidget {
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<_Counter> {
  int _counter = 0;

  void _showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("當前數量：$_counter"),
    ));
  }

  void _increaseCounter() {
    // debugDumpApp();
    setState(() => _counter++);
    // setState(() {
    // _counter++;
    // debugger(when: _counter > 3); // Break point
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
              child: Text('Show SnackBar'), onPressed: _showSnackBar),
          ElevatedButton(child: Text('increase'), onPressed: _increaseCounter),
          Text('Number:$_counter'),
        ],
      ),
    );
  }
}
