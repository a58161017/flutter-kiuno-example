import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

import '../main.dart';

const int FULL_SCREEN_MODE = 0;
const int CROPPED_FULL_SCREEN_MODE = 1;
const int OVER_APP_BAR_MODE = 2;
const int OVER_STATUS_BAR_MODE = 3;

const double APP_BAR_HEIGHT = 48.0;
const double RATIO = 16.0 / 9.0;

class AspectRatioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _AspectRatioWidget(),
    );
  }
}

class _AspectRatioWidget extends StatefulWidget {
  @override
  _AspectRatioState createState() => _AspectRatioState();
}

class _AspectRatioState extends State<_AspectRatioWidget> {
  late Future<void> _initMediaQueryParams;
  late double _screenWidth = 1.0;
  late double _screenHeight = 1.0;
  late double _statusBarHeight = 0.0;
  late int _displayMode = FULL_SCREEN_MODE;
  late double _previewPaddingTop = 0.0;
  late Alignment _previewAlignment = Alignment.center;

  Future<void> _getMediaQueryParams() async {
    await Future.delayed(Duration.zero);
    var screenSize = MediaQuery.of(context).size;
    var safeAreaWidth = 0.0;
    var safeAreaHeight = 0.0;
    if (safeAreaSize != null) {
      safeAreaWidth = safeAreaSize!.width;
      safeAreaHeight = safeAreaSize!.height;
    }
    if (safeAreaSize != null) {
      _screenWidth = safeAreaSize!.width;
      _screenHeight = safeAreaSize!.height;
    } else {
      _screenWidth = screenSize.width;
      _screenHeight = screenSize.height;
    }
    _statusBarHeight = MediaQuery.of(context).padding.top;
    if (_screenHeight / _screenWidth >= RATIO) {
      _displayMode = FULL_SCREEN_MODE;
      _previewPaddingTop = APP_BAR_HEIGHT + _statusBarHeight;
      _previewAlignment = Alignment.center;
    } else if ((_screenHeight + APP_BAR_HEIGHT) / _screenWidth >= RATIO) {
      _displayMode = CROPPED_FULL_SCREEN_MODE;
      _previewPaddingTop = APP_BAR_HEIGHT + _statusBarHeight;
      _previewAlignment = Alignment.topCenter;
    } else if ((_screenHeight + APP_BAR_HEIGHT + _statusBarHeight) /
            _screenWidth >=
        RATIO) {
      _displayMode = OVER_APP_BAR_MODE;
      _previewPaddingTop = _statusBarHeight;
      _previewAlignment = Alignment.topCenter;
    } else {
      _displayMode = OVER_STATUS_BAR_MODE;
      _previewPaddingTop = 0.0;
      _previewAlignment = Alignment.topCenter;
    }

    debugPrint('aspect_ratio_page -> _getMediaQueryParams() -> '
        '_screenWidth: ${screenSize.width}, _screenHeight: ${screenSize.height}, '
        '_safeAreaWidth: $safeAreaWidth, _safeAreaHeight: $safeAreaHeight, '
        '_statusBarHeight: $_statusBarHeight, _displayMode: $_displayMode');

    _setStatusBarColor(_displayMode >= OVER_STATUS_BAR_MODE
        ? Colors.transparent
        : Color(0xFF202525));
    // _setNavigationBarColor(_displayMode == OVER_STATUS_BAR_MODE
    //     ? Colors.transparent
    //     : Color(0xFF202525));

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _setStatusBarColor(Color color) async {
    await FlutterStatusbarcolor.setStatusBarColor(color);
    if (useWhiteForeground(color)) {
      FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    } else {
      FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    }
  }

  Future<void> _setNavigationBarColor(Color color) async {
    await FlutterStatusbarcolor.setNavigationBarColor(color);
    if (useWhiteForeground(color)) {
      FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
    } else {
      FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
    }
  }

  @override
  void initState() {
    super.initState();
    _initMediaQueryParams = _getMediaQueryParams();
  }

  @override
  void dispose() {
    _setStatusBarColor(Color(0x00000000));
    _setNavigationBarColor(Color(0x00000000));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(color: Color(0xFF202525)),
        ),
        FutureBuilder<void>(
          future: _initMediaQueryParams,
          builder: (context, snapshot) {
            return Padding(
              padding: EdgeInsets.only(top: _previewPaddingTop),
              child: Container(
                width: _screenWidth,
                height: _screenWidth * RATIO,
                child: Stack(
                  children: [
                    _buildPreviewView(_screenWidth, _previewAlignment),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: _buildActionFrame(),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        FutureBuilder<void>(
          future: _initMediaQueryParams,
          builder: (context, snapshot) {
            return Padding(
              padding: EdgeInsets.only(
                top: _statusBarHeight,
              ),
              child: _buildAppBarFrame(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildAppBarFrame() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
      child: Container(
        width: double.infinity,
        height: APP_BAR_HEIGHT,
        decoration: BoxDecoration(color: Colors.transparent),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 36,
              height: 36,
              child: Center(
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  child: Center(
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 36,
                  height: 36,
                  child: Center(
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 36,
                  height: 36,
                  child: Center(
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPreviewView(double size, Alignment alignment) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: ClipRect(
        child: OverflowBox(
          child: FittedBox(
            alignment: alignment,
            fit: BoxFit.fitWidth,
            child: Container(
              child: Image.asset(
                  'assets/preview_pic.png'), // this is my CameraPreview
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionFrame() {
    return Container(
      width: double.infinity,
      height: 128,
      decoration: BoxDecoration(
        color: Color(0x4D000505),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
