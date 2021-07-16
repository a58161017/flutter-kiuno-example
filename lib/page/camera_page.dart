import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kiuno_example/cubit/camera/countdown_cubit.dart';
import 'package:flutter_kiuno_example/cubit/camera/flash_cubit.dart';
import 'package:flutter_kiuno_example/cubit/camera/record_cubit.dart';
import 'package:flutter_kiuno_example/main.dart';

import 'camera/frame/app_bar_frame.dart';
import 'camera/frame/action_frame.dart';

class CameraPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => CountdownCubit()),
          BlocProvider(create: (context) => FlashCubit()),
          BlocProvider(create: (context) => RecordCubit()),
        ],
        child: WillPopScope(
          onWillPop: () => onBackPressed(context),
          child: MaterialApp(
            title: 'Startup Camera',
            home: Scaffold(
              body: _CameraWidget(),
            ),
          ),
        ));
  }
}

class _CameraWidget extends StatefulWidget {
  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<_CameraWidget>
    implements OnAppBarFrameListener, OnActionFrameListener {
  late CameraController _controller;

  void _initCamera() {
    _controller = CameraController(cameras[0], ResolutionPreset.high);
    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  Future<void> _onCameraSwitch() async {
    final CameraDescription cameraDescription =
        (_controller.description == cameras[0]) ? cameras[1] : cameras[0];
    await _controller.dispose();
    _controller = CameraController(cameraDescription, ResolutionPreset.high);
    _controller.addListener(() {
      if (mounted) setState(() {});
      if (_controller.value.hasError) {
        debugPrint('Camera error ${_controller.value.errorDescription}');
      }
    });

    try {
      await _controller.initialize();
    } on CameraException catch (e) {
      debugPrint('Error: ${e.code}\n${e.description}');
    }

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> setFlashMode(FlashMode mode) async {
    try {
      await _controller.setFlashMode(mode);
    } on CameraException catch (e) {
      debugPrint('Error: ${e.code}\n${e.description}');
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Stack(
      children: [
        Positioned.fill(
          child: CameraPreview(_controller),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: EdgeInsets.only(
              top: statusBarHeight,
            ),
            child: AppBarFrame(
              listener: this,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: ActionFrame(
            listener: this,
          ),
        ),
      ],
    );
  }

  @override
  void onCloseClicked() {}

  @override
  void onCountdownClicked() {
    switch (context.read<CountdownCubit>().state) {
      case COUNTDOWN_OFF:
        context.read<CountdownCubit>().on();
        break;
      case COUNTDOWN_FIVE_SECONDS:
        context.read<CountdownCubit>().off();
        break;
    }
  }

  @override
  void onFlashClicked() {
    switch (context.read<FlashCubit>().state) {
      case FLASH_OFF:
        context.read<FlashCubit>().on();
        setFlashMode(FlashMode.torch);
        break;
      case FLASH_ON:
        context.read<FlashCubit>().auto();
        setFlashMode(FlashMode.auto);
        break;
      case FLASH_AUTO:
        context.read<FlashCubit>().off();
        setFlashMode(FlashMode.off);
        break;
    }
  }

  @override
  void onInfoClicked() {}

  @override
  void onAlbumClicked() {}

  @override
  void onRecordClicked() {
    if (context.read<RecordCubit>().state) {
      context.read<RecordCubit>().stop();
    } else {
      context.read<RecordCubit>().start();
    }
  }

  @override
  void onSwitchCameraClicked() {
    _onCameraSwitch();
  }
}

Future<bool> onBackPressed(BuildContext context) async {
  var args = ModalRoute.of(context)!.settings.arguments;
  Navigator.pop(context, "$args return");
  return true;
}
