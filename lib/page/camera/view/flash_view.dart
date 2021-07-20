import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

const int FLASH_OFF = 0;
const int FLASH_ON = 1;
const int FLASH_AUTO = 2;

class FlashView extends StatelessWidget {
  final int mode;
  FlashView({required this.mode});

  final icons = [
    'assets/camera/flash_off_s.svg',
    'assets/camera/flash_on_s.svg',
    'assets/camera/flash_auto_s.svg',
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
