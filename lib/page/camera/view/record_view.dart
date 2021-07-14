part of '../frame/action_frame.dart';

class RecordView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: Color(0x99C3D5DC),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Container(
          width: 56,
          height: 56,
          decoration:
              BoxDecoration(color: Color(0xFFFAFDFF), shape: BoxShape.circle),
        ),
      ),
    );
  }
}
