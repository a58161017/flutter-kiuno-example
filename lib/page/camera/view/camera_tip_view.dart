import 'package:flutter/material.dart';

class CameraTipView extends StatefulWidget {
  CameraTipView({Key? key}) : super(key: key);

  @override
  CameraTipViewState createState() => CameraTipViewState();
}

class CameraTipViewState extends State<CameraTipView> {
  void refresh() {
    if (mounted) {
      setState(() => {});
    }
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
              Positioned.fill(child: Image.asset('assets/studio_tip.webp')),
            ],
          ),
        ),
      ],
    );
  }
}
