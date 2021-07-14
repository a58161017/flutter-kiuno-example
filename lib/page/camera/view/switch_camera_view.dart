part of '../frame/action_frame.dart';

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
        child: Image.asset(
          'assets/switch_camera.png',
          width: 24,
          height: 24,
        ),
      ),
    );
  }
}
