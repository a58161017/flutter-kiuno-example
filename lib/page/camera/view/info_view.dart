import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class InfoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      child: Center(
        child: SvgPicture.asset(
          'assets/general/info_s.svg',
          width: 24,
          height: 24,
          color: Color(0xFFFAFDFF),
        ),
      ),
    );
  }
}
