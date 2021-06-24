import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kiuno_example/animation/animation_basic.dart';
import 'package:flutter_kiuno_example/animation/explicit_animations.dart';
import 'package:flutter_kiuno_example/animation/hero_animation.dart';
import 'package:flutter_kiuno_example/animation/implicit_animations.dart';
import 'package:flutter_kiuno_example/animation/switcher_animation.dart';
import 'package:flutter_kiuno_example/animation/tween_animation_builder.dart';
import 'package:flutter_kiuno_example/base.dart';
import 'package:flutter_kiuno_example/cubit/calculator_route.dart';
import 'package:flutter_kiuno_example/layout/layout_basic.dart';
import 'package:flutter_kiuno_example/layout/layout_basic2.dart';
import 'package:flutter_kiuno_example/layout/layout_ex1.dart';
import 'package:flutter_kiuno_example/layout/layout_ex2.dart';
import 'package:flutter_kiuno_example/layout/layout_ex3.dart';
import 'package:flutter_kiuno_example/state/stateful_basic.dart';
import 'package:flutter_kiuno_example/state/stateful_encapsulation.dart';
import 'package:flutter_kiuno_example/bloc/numbers_game_bloc.dart';

import 'global_bloc_observer.dart';
import 'lifecycle/lifecycle.dart';
import 'layout/list.dart';

void main() {
  Bloc.observer = GlobalBlocObserver(); // Register GlobalBlocObserver
  // Bloc.observer = BlocObserver() // Unregister GlobalBlocObserver
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Kiuno Example',
      theme: ThemeData(primaryColor: Colors.blueAccent),
      initialRoute: "/",
      routes: {
        // register route table
        "lifecycle_page": (context) => LifecycleRoute(),
        "layout_basic_page": (context) => LayoutBasicRoute(),
        "layout_basic2_page": (context) => LayoutBasic2Route(),
        "layout_example1_page": (context) => LayoutExample1Route(),
        "layout_example2_page": (context) => LayoutExample2Route(),
        "layout_example3_page": (context) => LayoutExample3Route(),
        "stateful_basic_page": (context) => StatefulBasicRoute(),
        "stateful_encapsulation_page": (context) =>
            StatefulEncapsulationRoute(),
        "list_page": (context) => ListRoute(),

        "implicit_animations_page": (context) => ImplicitAnimationsRoute(),
        "tween_animation_builder_page": (context) =>
            TweenAnimationBuilderRoute(),
        "explicit_animations_page": (context) => ExplicitAnimationsRoute(),
        "animation_basic_page": (context) => AnimationBasicRoute(),
        "hero_animation_page": (context) => HeroAnimationRoute(),
        "siwtcher_animation_page": (context) => SwitcherAnimationRoute(),

        "numbers_game_bloc_page": (context) => NumbersGameBlocRoute(),
        "calculator_cubit_page": (context) => CalculatorCubitRoute(),
        "/": (context) => MyHomeRoute(),
      },
    );
  }
}

class MyHomeRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to Kiuno\'s example'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // _buildNavigationButtonByRouteName(
            //     context, 'Lifecycle', "lifecycle_page"),
            // _buildNavigationButtonByRouteName(
            //     context, 'Layout basic', "layout_basic_page"),
            // _buildNavigationButtonByRouteName(
            //     context, 'Layout basic2', "layout_basic2_page"),
            // _buildNavigationButtonByRouteName(
            //     context, 'Layout example1', "layout_example1_page"),
            // _buildNavigationButtonByRouteName(
            //     context, 'Layout example2', "layout_example2_page"),
            // _buildNavigationButtonByRouteName(
            //     context, 'Layout example3', "layout_example3_page"),
            // _buildNavigationButtonByRouteName(
            //     context, 'Stateful basic', "stateful_basic_page"),
            // _buildNavigationButtonByRouteName(
            //     context, 'Stateful encapsulation', "stateful_encapsulation_page"),
            // _buildNavigationButtonByRouteName(context, 'List', "list_page"),
            // Divider(),
            // _buildNavigationButtonByRouteName(
            //     context, 'Implicit animations', "implicit_animations_page"),
            // _buildNavigationButtonByRouteName(
            //     context, 'Tween animation builder', "tween_animation_builder_page"),
            // _buildNavigationButtonByRouteName(
            //     context, 'Explicit animations', "explicit_animations_page"),
            // _buildNavigationButtonByRouteName(
            //     context, 'Animation basic', "animation_basic_page"),
            // _buildNavigationButtonByRouteName(
            //     context, 'Hero animation', "hero_animation_page"),
            // _buildNavigationButtonByRouteName(
            //     context, 'Switcher animation', "switcher_animation_page"),
            // Divider(),
            // _buildNavigationButtonByRouteName(
            //     context, 'Numbers game bloc', "numbers_game_bloc_page"),
            // _buildNavigationButtonByRouteName(
            //     context, 'Calculator cubit', "calculator_cubit_page"),

            _buildNavigationButton(context, 'Lifecycle', LifecycleRoute()),
            _buildNavigationButton(context, 'Layout basic', LayoutBasicRoute()),
            _buildNavigationButton(
                context, 'Layout basic2', LayoutBasic2Route()),
            _buildNavigationButton(
                context, 'Layout example1', LayoutExample1Route()),
            _buildNavigationButton(
                context, 'Layout example2', LayoutExample2Route()),
            _buildNavigationButton(
                context, 'Layout example3', LayoutExample3Route()),
            _buildNavigationButton(
                context, 'Stateful basic', StatefulBasicRoute()),
            _buildNavigationButton(context, 'Stateful encapsulation',
                StatefulEncapsulationRoute()),
            _buildNavigationButton(context, 'List', ListRoute()),
            Divider(),
            _buildNavigationButton(
                context, 'Implicit animations', ImplicitAnimationsRoute()),
            _buildNavigationButton(context, 'Tween animation builder',
                TweenAnimationBuilderRoute()),
            _buildNavigationButton(
                context, 'Explicit animations', ExplicitAnimationsRoute()),
            _buildNavigationButton(
                context, 'Animation basic', AnimationBasicRoute()),
            _buildNavigationButton(
                context, 'Hero animation', HeroAnimationRoute()),
            _buildNavigationButton(
                context, 'Switcher animation', SwitcherAnimationRoute()),
            Divider(),
            _buildNavigationButton(
                context, 'Numbers game bloc', NumbersGameBlocRoute()),
            _buildNavigationButton(
                context, 'Calculator cubit', CalculatorCubitRoute()),
          ],
        ),
      ),
    );
  }
}

ElevatedButton _buildNavigationButtonByRouteName(
    BuildContext context, String btnName, String routeName) {
  return ElevatedButton(
    child: Text(btnName),
    onPressed: () async {
      // The result may be null if the user uses navigation button to return.
      final result = await Navigator.of(context)
          .pushNamed(routeName, arguments: routeName);
      // final result = await Navigator.pushNamed(context, routeName, arguments: routeName);
      debugPrint('Navigator return value: $result');
    },
  );
}

ElevatedButton _buildNavigationButton(
    BuildContext context, String btnName, BaseRoute route) {
  return ElevatedButton(
    child: Text(btnName),
    onPressed: () async {
      final result =
          await Navigator.of(context).push(_buildPageRouteBuilder(route));
      debugPrint('Navigator return value: $result');
    },
  );
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
