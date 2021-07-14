import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kiuno_example/main.dart';

import 'camera/frame/app_bar_frame.dart';
import 'camera/frame/action_frame.dart';

class CameraPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onBackPressed(context),
      child: MaterialApp(
        title: 'Startup Camera',
        home: Scaffold(
          appBar: AppBar(
            title: AppBarFrame(),
          ),
          body: _CameraWidget(),
        ),
      ),
    );
  }
}

class _CameraWidget extends StatefulWidget {
  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<_CameraWidget> {
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
    return Stack(
      children: [
        CameraPreview(_controller),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: ActionFrame(
            onSwitchCameraClicked: () => _onCameraSwitch(),
          ),
        ),
      ],
    );
  }
}

Future<bool> onBackPressed(BuildContext context) async {
  var args = ModalRoute.of(context)!.settings.arguments;
  Navigator.pop(context, "$args return");
  return true;
}
