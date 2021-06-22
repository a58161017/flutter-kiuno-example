import 'package:flutter/material.dart';
import 'package:flutter_kiuno_example/animation/hero_transition.dart';
import 'package:flutter_kiuno_example/base.dart';

class HeroAnimationRoute extends BaseRoute {
  @override
  Widget build(BuildContext context) {
    return buildMaterialApp(
      context,
      'Startup Animation Basic',
      'Kiuno\'s animation basic',
      HeroAnimationWidget(),
    );
  }
}

class HeroAnimationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          child: Hero(
            tag: "picture",
            child: Image.asset('assets/lake.jpeg'),
          ),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context)
              .push(_buildPageRouteBuilder(HeroTransitionRoute())),
          child: Text('AnimatedHero'),
        ),
      ],
    );
  }
}

Route _buildPageRouteBuilder(BaseRoute route) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => route,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
