import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kiuno_example/cubit/camera/countdown_cubit.dart';
import 'package:flutter_kiuno_example/cubit/camera/flash_cubit.dart';
import 'package:flutter_kiuno_example/cubit/camera/record_cubit.dart';
import 'package:flutter_kiuno_example/page/camera/view/camera_tip_view.dart';
import 'package:flutter_kiuno_example/page/preview_page.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

import '../main.dart';
import 'camera/view/close_view.dart';
import 'camera/view/countdown_text_view.dart';
import 'camera/view/countdown_view.dart';
import 'camera/view/flash_view.dart';
import 'camera/view/info_view.dart';
import 'camera/view/album_view.dart';
import 'camera/view/permission_tip_view.dart';
import 'camera/view/record_view.dart';
import 'camera/view/switch_camera_view.dart';

part 'camera/frame/action_frame.dart';

part 'camera/frame/app_bar_frame.dart';

const int COUNTDOWN_SECONDS = 5;

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
          child: Scaffold(
            body: _CameraWidget(),
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
  late Future<void> _initializeControllerFuture;

  GlobalKey<ActionFrameState> _actionFrameKey = GlobalKey();
  GlobalKey<CameraTipViewState> _cameraTipViewKey = GlobalKey();

  XFile? _videoFile;
  bool _isCountdown = false;
  int _countdownSec = COUNTDOWN_SECONDS;
  Timer? _countdownTimer;
  bool _isVisibleTip = true;

  Future<void> _setStatusBarColor(Color color) async {
    await FlutterStatusbarcolor.setStatusBarColor(color);
  }

  Future<void> _setNavigationBarColor(Color color) async {
    await FlutterStatusbarcolor.setNavigationBarColor(color);
  }

  void _initCamera() {
    try {
      _initializeControllerFuture = _controller.initialize();
    } on CameraException catch (e) {
      debugPrint('Error: ${e.code}\n${e.description}');
    }

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _onCameraSwitch() async {
    final CameraDescription cameraDescription =
        (_controller.description == cameras[0]) ? cameras[1] : cameras[0];
    await _controller.dispose();
    _controller = CameraController(cameraDescription, ResolutionPreset.high);

    _initCamera();
  }

  Future<void> _setFlashMode(FlashMode mode) async {
    try {
      await _controller.setFlashMode(mode);
    } on CameraException catch (e) {
      debugPrint('Error: ${e.code}\n${e.description}');
    }

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _startVideoRecord() async {
    if (!_controller.value.isInitialized ||
        _controller.value.isRecordingVideo) {
      return;
    }
    context.read<RecordCubit>().start();
    _actionFrameKey.currentState?.startRecordAnimation();

    try {
      await _controller.startVideoRecording();
    } on CameraException catch (e) {
      debugPrint('Error: ${e.code}\n${e.description}');
    }
    return;
  }

  Future<void> _stopVideoRecord() async {
    if (!_controller.value.isRecordingVideo) {
      return null;
    }
    _actionFrameKey.currentState?.stopRecordAnimation();
    context.read<RecordCubit>().stop();

    try {
      await _controller.stopVideoRecording().then((file) => _videoFile = file);
      debugPrint('videoPath: ${_videoFile!.path}');
    } on CameraException catch (e) {
      debugPrint('Error: ${e.code}\n${e.description}');
      return null;
    }
  }

  void _startCountdownTimer() {
    if (_isCountdown) return;
    setState(() {
      _countdownSec = COUNTDOWN_SECONDS;
      _isCountdown = true;
    });
    _countdownTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (_countdownSec == 1) {
          setState(() {
            _isCountdown = false;
            timer.cancel();
          });
          _startVideoRecord();
        } else {
          setState(() {
            _countdownSec--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _setStatusBarColor(Color(0xFF202525));
    _setNavigationBarColor(Color(0xFF202525));
    _controller = CameraController(cameras[0], ResolutionPreset.high);
    _initCamera();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _controller.dispose();
    _setStatusBarColor(Color(0x00000000));
    _setNavigationBarColor(Color(0x00000000));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        return SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFF202525),
            ),
            child: (snapshot.connectionState == ConnectionState.done)
                ? (_controller.value.isInitialized)
                    ? _buildCameraWidget()
                    : _buildPermissionTipWidget()
                : _buildEmptyWidget(),
          ),
        );
      },
    );
  }

  Widget _buildEmptyWidget() {
    return Container();
  }

  Widget _buildPermissionTipWidget() {
    return Center(
      child: PermissionTipView(
        onPressedCallback: onPermissionViewCallback,
      ),
    );
  }

  Widget _buildCameraWidget() {
    return Stack(
      children: [
        Positioned.fill(
          child: CameraPreview(_controller),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: AppBarFrame(
            listener: this,
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: Visibility(
              visible: _isVisibleTip,
              child: CameraTipView(
                key: _cameraTipViewKey,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Column(
            children: [
              Visibility(
                visible: _isCountdown,
                child: CountdownTextView(
                  seconds: _countdownSec,
                ),
              ),
              ActionFrame(
                key: _actionFrameKey,
                listener: this,
              ),
            ],
          ),
        ),
        Positioned.fill(
          child: Visibility(
            visible: _isCountdown,
            child: GestureDetector(
              onTap: () => {},
              child: Container(
                decoration: BoxDecoration(color: Colors.transparent),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void onPermissionViewCallback() {
    _initCamera();
  }

  @override
  void onCloseClicked() {
    onBackPressed(context);
  }

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
  void onFlashClicked() async {
    await _initializeControllerFuture;
    switch (context.read<FlashCubit>().state) {
      case FLASH_OFF:
        context.read<FlashCubit>().on();
        _setFlashMode(FlashMode.torch);
        break;
      case FLASH_ON:
        context.read<FlashCubit>().auto();
        _setFlashMode(FlashMode.auto);
        break;
      case FLASH_AUTO:
        context.read<FlashCubit>().off();
        _setFlashMode(FlashMode.off);
        break;
    }
  }

  @override
  void onInfoClicked() {
    setState(() => _isVisibleTip = !_isVisibleTip);
  }

  @override
  void onAlbumClicked() {
    if (_videoFile != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PreviewPage(filePath: _videoFile!.path),
        ),
      );
    }
  }

  @override
  void onRecordClicked() {
    if (context.read<RecordCubit>().state) {
      _stopVideoRecord();
    } else {
      var countdownMode = context.read<CountdownCubit>().state;
      switch (countdownMode) {
        case COUNTDOWN_OFF:
          _startVideoRecord();
          break;
        case COUNTDOWN_FIVE_SECONDS:
          _startCountdownTimer();
          break;
      }
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
