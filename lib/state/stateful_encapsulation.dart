import 'package:flutter/material.dart';

/*
Decide which Widgets the state belongs to:
(1) If the state is user data, such as the selected state of a check box and
    the position of a slider, the state is best managed by the parent Widget.
(2) If the state is related to the appearance of the interface, such as color
    and animation, the state is best managed by the Widget itself.
(3) If a certain state is shared by different Widgets, it is better to be
    managed by their common parent Widget.
*/
class StatefulEncapsulationRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments;
    return MaterialApp(
      title: 'Startup Stateful Encapsulation',
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, "$args return");
            },
          ),
          title: Text('Kiuno\'s stateful encapsulation'),
        ),
        body: _Counter(),
      ),
    );
  }
}

// It is recommended that these states be managed by higher-level widget.
class _Counter extends StatefulWidget {
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<_Counter> {
  int _counter = 0;

  void _increaseCounter() {
    setState(() => _counter++);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _CounterIncreasementor(count: _counter, onPressed: _increaseCounter),
          _CounterDisplay(
            count: _counter,
          ),
          Container(
            width: 250,
            child: Text(
              'The button will change color when pressed for a long time.',
              style: TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

// The count state is already managed by the parent widget _Counter, so this widget can be stateless.
class _CounterDisplay extends StatelessWidget {
  _CounterDisplay({@required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Text('Number:$count');
  }
}

// The count state is already managed by the parent widget _Counter, so this widget can be stateless.
class _CounterIncreasementor extends StatefulWidget {
  _CounterIncreasementor({@required this.count, @required this.onPressed});

  final int count;
  final VoidCallback onPressed;

  @override
  State createState() => _CounterIncreasementorState();
}

class _CounterIncreasementorState extends State<_CounterIncreasementor> {
  bool _highlight = false;

  void _onHighlightChanged(bool needHighLight) {
    setState(() => _highlight = needHighLight);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => () => _onHighlightChanged(true),
      onTapDown: (TapDownDetails details) => _onHighlightChanged(true),
      onTapUp: (TapUpDetails details) => _onHighlightChanged(false),
      onTapCancel: () => _onHighlightChanged(false),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: _highlight ? Colors.black : Colors.blue[600],
        ),
        child: Text('Increasement'),
        onPressed: widget.onPressed,
      ),
    );
  }
}
