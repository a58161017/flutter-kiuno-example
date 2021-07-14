import 'package:flutter/material.dart';

part '../view/album_view.dart';

part '../view/record_view.dart';

part '../view/switch_camera_view.dart';

class ActionFrame extends StatelessWidget {
  final VoidCallback? onSwitchCameraClicked;

  ActionFrame({this.onSwitchCameraClicked});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 128,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: GestureDetector(
              onTap: () => {},
              child: AlbumView(),
            ),
          ),
          GestureDetector(
            onTap: () => {},
            child: RecordView(),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 40),
            child: GestureDetector(
              onTap: () {
                if (onSwitchCameraClicked != null) {
                  onSwitchCameraClicked!();
                }
              },
              child: SwitchCameraView(),
            ),
          ),
        ],
      ),
    );
  }
}
