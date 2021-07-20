import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_kiuno_example/base.dart';
import 'package:video_player/video_player.dart';

class PreviewPage extends BaseRoute {
  final String filePath;

  PreviewPage({required this.filePath});

  @override
  Widget build(BuildContext context) {
    return buildMaterialApp(
      context,
      'Startup Preview',
      'Kiuno\'s preview',
      _PreviewWidget(
        filePath: filePath,
      ),
    );
  }
}

class _PreviewWidget extends StatefulWidget {
  final String filePath;

  _PreviewWidget({required this.filePath});

  @override
  _PreviewState createState() => _PreviewState();
}

class _PreviewState extends State<_PreviewWidget>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _controller;

  void _playAndPauseVideo() {
    if (_controller.value.isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.filePath))
      ..initialize().then(
        (_) {
          setState(() {});
        },
      );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (_controller.value.isInitialized) {
      return Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () => _playAndPauseVideo(),
            child: ClipRect(
              child: Container(
                child: Transform.scale(
                  scale: _controller.value.aspectRatio / size.aspectRatio,
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }
}
