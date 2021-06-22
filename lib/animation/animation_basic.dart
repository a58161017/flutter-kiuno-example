import 'package:flutter/material.dart';
import 'package:flutter_kiuno_example/base.dart';

class AnimationBasicRoute extends BaseRoute {
  @override
  Widget build(BuildContext context) {
    return buildMaterialApp(
      context,
      'Startup Animation Basic',
      'Kiuno\'s animation basic',
      AnimationBasicWidget(),
    );
  }
}

class AnimationBasicWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ScaleAnimationWidget(),
      ],
    );
  }
}

class ScaleAnimationWidget extends StatefulWidget {
  @override
  ScaleAnimationState createState() => ScaleAnimationState();
}

class ScaleAnimationState extends State<ScaleAnimationWidget>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceIn);
    animation = Tween(begin: 0.0, end: 300.0).animate(animation);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return GrowTransition(
        child: Image.asset("assets/lake.jpeg"), animation: animation);
  }

  @override
  void dispose() {
    // Don't forget
    controller.dispose();
    super.dispose();
  }
}

class GrowTransition extends StatelessWidget {
  const GrowTransition({required this.child, required this.animation});

  final Widget child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        return Center(
          child: Container(
            width: animation.value,
            height: animation.value,
            child: this.child,
          ),
        );
      },
    );
  }
}
