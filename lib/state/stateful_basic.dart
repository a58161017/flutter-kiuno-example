import 'dart:developer';
import 'package:flutter/material.dart';

class StatefulBasicRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments;
    return MaterialApp(
      title: 'Startup Stateful Basic',
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () { Navigator.pop(context, "$args return"); },),
          title: Text('Kiuno\'s stateful basic'),
        ),
        body: _Counter(),
      ),
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
          ElevatedButton(child: Text('Show SnackBar'), onPressed: _showSnackBar),
          ElevatedButton(child: Text('increase'), onPressed: _increaseCounter),
          Text('Number:$_counter'),
        ],
      ),
    );
  }
}