import 'package:flutter/material.dart';

import '../base.dart';

class HeroTransitionRoute extends BaseRoute {
  @override
  Widget build(BuildContext context) {
    return buildMaterialApp(
      context,
      'Startup Hero transition',
      'Kiuno\'s hero transition',
      HeroTransitionWidget(),
    );
  }
}

class HeroTransitionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 500,
          height: 400,
          child: Hero(
            tag: 'picture',
            child: Image.asset('assets/lake.jpeg'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
              '嘉明湖(又稱：上帝的眼淚)位於台灣台東縣海端鄉，是個 Kiuno 推薦的知名登山景點，據說盤古時代開天闢地，夏商周王朝三國鼎立，中間地帶就是人們俗稱的天使眼淚，現代人將它正名為嘉明湖，以上純屬虛構，如有不實，阿就虛構當然不實啊！'),
        ),
      ],
    );
  }
}
