import 'package:flutter/material.dart';

class StatefulEncapsulationRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments;
    return MaterialApp(
      title: 'Startup Stateful Encapsulation',
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () { Navigator.pop(context, "$args return"); },),
          title: Text('Kiuno\'s stateful encapsulation'),
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

  void _increaseCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _CounterIncrementor(onPressed: _increaseCounter),
          _CounterDisplay(count: _counter,),
        ],
      ),
    );
  }
}

class _CounterDisplay extends StatelessWidget {
  _CounterDisplay({@required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Text('Number:$count');
  }
}

class _CounterIncrementor extends StatelessWidget {
  _CounterIncrementor({@required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        child: Text('increase'),
        onPressed: onPressed
    );
  }
}