part of '../frame/action_frame.dart';

class AlbumView extends StatelessWidget {
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
          'assets/album_s.png',
          width: 24,
          height: 24,
        ),
      ),
    );
  }
}
