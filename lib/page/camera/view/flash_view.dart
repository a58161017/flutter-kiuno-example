part of '../frame/app_bar_frame.dart';

class FlashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      child: Center(
        child: Image.asset(
          'assets/flash_off_s.png',
          width: 24,
          height: 24,
        ),
      ),
    );
  }
}
