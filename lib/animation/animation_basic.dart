import 'package:flutter/material.dart';
import 'package:flutter_kiuno_example/base.dart';

class AnimationBasicRoute extends BaseRoute {
  @override
  Widget build(BuildContext context) {
    return buildMaterialApp(
      context,
      'Startup Animation Basic',
      'Kiuno\'s animation basic',
      _AnimationBasicWidget(),
    );
  }
}

class _AnimationBasicWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          child: _ScaleAnimationWidget(),
          flex: 1,
        ),
        Flexible(
          child: _StaggerAnimationWidget(),
          flex: 1,
        ),
      ],
    );
  }
}

class _ScaleAnimationWidget extends StatefulWidget {
  @override
  _ScaleAnimationState createState() => _ScaleAnimationState();
}

class _ScaleAnimationState extends State<_ScaleAnimationWidget>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.bounceIn);
    _animation = Tween(begin: 0.0, end: 300.0).animate(_animation);
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return _GrowTransition(
        child: Image.asset("assets/lake.jpeg"), animation: _animation);
  }

  @override
  void dispose() {
    // Don't forget
    _controller.dispose();
    super.dispose();
  }
}

class _GrowTransition extends StatelessWidget {
  const _GrowTransition({required this.child, required this.animation});

  final Widget child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (BuildContext context, Widget? child) {
        return Center(
          child: Container(
            width: animation.value,
            height: animation.value,
            child: child,
          ),
        );
      },
    );
  }
}

class _StaggerAnimationWidget extends StatefulWidget {
  @override
  _StaggerAnimationState createState() => _StaggerAnimationState();
}

class _StaggerAnimationState extends State<_StaggerAnimationWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
  }

  Future<Null> _startAnimation() async {
    try {
      await _controller.forward().orCancel;
      await _controller.reverse().orCancel;
    } on TickerCanceled {
      // the animation got canceled, probably because we were disposed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
            onPressed: () => _startAnimation(), child: Text('Start Animation')),
        _StaggerAnimation(
          controller: _controller,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _StaggerAnimation extends StatelessWidget {
  _StaggerAnimation({Key? key, required this.controller}) : super(key: key) {
    _height = Tween<double>(begin: 0.0, end: 300.0).animate(CurvedAnimation(
        parent: controller, curve: Interval(0.0, 0.6, curve: Curves.ease)));
    _color = ColorTween(begin: Colors.green, end: Colors.red).animate(
        CurvedAnimation(
            parent: controller, curve: Interval(0.0, 0.6, curve: Curves.ease)));
    _padding = Tween<EdgeInsets>(
            begin: EdgeInsets.only(left: 0.0),
            end: EdgeInsets.only(left: 100.0))
        .animate(CurvedAnimation(
            parent: controller, curve: Interval(0.6, 1.0, curve: Curves.ease)));
  }

  final AnimationController controller;
  late Animation<double> _height;
  late Animation<EdgeInsets> _padding;
  late Animation<Color?> _color;

  Widget _buildAnimation(BuildContext context, Widget? child) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: _padding.value,
      child: Container(
        color: _color.value,
        width: 50,
        height: _height.value,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: controller, builder: _buildAnimation);
  }
}
