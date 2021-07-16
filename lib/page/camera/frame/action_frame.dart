import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kiuno_example/cubit/camera/record_cubit.dart';
import 'package:flutter_svg/svg.dart';

part '../view/album_view.dart';

part '../view/record_view.dart';

part '../view/switch_camera_view.dart';

abstract class OnActionFrameListener {
  void onAlbumClicked();

  void onRecordClicked();

  void onSwitchCameraClicked();
}

class ActionFrame extends StatelessWidget {
  final OnActionFrameListener? listener;

  ActionFrame({this.listener});

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
              onTap: () => listener?.onAlbumClicked(),
              child: AlbumView(),
            ),
          ),
          BlocBuilder<RecordCubit, bool>(builder: (context, state) {
            return GestureDetector(
              onTap: () => listener?.onRecordClicked(),
              child: RecordView(isRecording: state),
            );
          }),
          Padding(
            padding: const EdgeInsets.only(right: 40),
            child: GestureDetector(
              onTap: () => listener?.onSwitchCameraClicked(),
              child: SwitchCameraView(),
            ),
          ),
        ],
      ),
    );
  }
}
