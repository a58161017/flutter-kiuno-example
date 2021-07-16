import 'package:flutter/material.dart';

class CountdownTextView extends StatelessWidget {
  final int seconds;

  CountdownTextView({required this.seconds});

  @override
  Widget build(BuildContext context) {
    return Text(
      seconds.toString(),
      style: TextStyle(
        fontSize: 30,
        color: Color(0xFFFAFDFF),
      ),
    );
  }
}
