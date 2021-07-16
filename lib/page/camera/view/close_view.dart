part of '../frame/app_bar_frame.dart';

class CloseView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      child: Center(
        child: SvgPicture.asset(
          'assets/general/close.svg',
          width: 24,
          height: 24,
          color: Color(0xFFFAFDFF),
        ),
      ),
    );
  }
}
