import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SwitchCameraView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: Color(0x99C3D5DC),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: SvgPicture.asset(
          'assets/camera/switch_camera.svg',
          width: 24,
          height: 24,
          color: Color(0xFFFAFDFF),
        ),
      ),
    );
  }
}
