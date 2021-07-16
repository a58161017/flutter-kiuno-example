import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kiuno_example/cubit/camera/record_cubit.dart';
import 'package:flutter_svg/svg.dart';

part '../view/album_view.dart';

part '../view/record_view.dart';

part '../view/switch_camera_view.dart';

const int RECORD_SECONDS = 60;

abstract class OnActionFrameListener {
  void onAlbumClicked();

  void onRecordClicked();

  void onSwitchCameraClicked();
}

class ActionFrame extends StatefulWidget {
  final OnActionFrameListener? listener;

  ActionFrame({Key? key, this.listener}) : super(key: key);

  @override
  ActionFrameState createState() => ActionFrameState();
}

class ActionFrameState extends State<ActionFrame>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  void startRecordAnimation() {
    _animationController.reset();
    _animationController.forward();
  }

  void stopRecordAnimation() {
    _animationController.stop();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: RECORD_SECONDS),
      vsync: this,
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.listener?.onRecordClicked();
        }
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

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
              onTap: () => widget.listener?.onAlbumClicked(),
              child: AlbumView(),
            ),
          ),
          BlocBuilder<RecordCubit, bool>(builder: (context, state) {
            return GestureDetector(
              onTap: () {
                widget.listener?.onRecordClicked();
              },
              child: RecordView(
                isRecording: state,
                progress: _animationController.value,
                max: 1.0,
              ),
            );
          }),
          Padding(
            padding: const EdgeInsets.only(right: 40),
            child: GestureDetector(
              onTap: () => widget.listener?.onSwitchCameraClicked(),
              child: SwitchCameraView(),
            ),
          ),
        ],
      ),
    );
  }
}
