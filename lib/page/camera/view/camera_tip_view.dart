import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CameraTipView extends StatefulWidget {
  CameraTipView({Key? key}) : super(key: key);

  @override
  CameraTipViewState createState() => CameraTipViewState();
}

class CameraTipViewState extends State<CameraTipView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
          child: Text(
            'Share what\'s interesting around you',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFFFAFDFF),
            ),
          ),
        ),
        Container(
          width: 300,
          height: 120,
          child: Stack(
            children: [
              Positioned.fill(child: Image.asset('assets/pic/pano.png')),
              // Positioned.fill(child: Image.asset('assets/studio_tip.webp')),
              Positioned.fill(
                child: Lottie.asset(
                  'assets/phone_pano.json',
                  controller: _controller,
                  onLoaded: (composition) {
                    // Configure the AnimationController with the duration of the
                    // Lottie file and start the animation.
                    _controller
                      ..duration = composition.duration
                      ..forward();
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
