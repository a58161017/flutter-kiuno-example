part of '../frame/app_bar_frame.dart';

class CountdownView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      child: Center(
        child: Image.asset(
          'assets/timer_off.png',
          width: 24,
          height: 24,
        ),
      ),
    );
  }
}
