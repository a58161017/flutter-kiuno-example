import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

const int COUNTDOWN_OFF = 0;
const int COUNTDOWN_FIVE_SECONDS = 1;

class CountdownView extends StatelessWidget {
  final int mode;
  CountdownView({required this.mode});

  final icons = [
    'assets/camera/timer_off.svg',
    'assets/camera/timer_5s.svg',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      child: Center(
        child: SvgPicture.asset(
          icons[mode],
          width: 24,
          height: 24,
          color: Color(0xFFFAFDFF),
        ),
      ),
    );
  }
}
