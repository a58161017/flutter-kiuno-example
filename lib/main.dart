import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
import 'package:flutter_kiuno_example/layout/list/combination_list.dart';
import 'package:flutter_kiuno_example/layout/list/mutil_list.dart';
import 'package:flutter_kiuno_example/state/stateful_basic.dart';
import 'package:flutter_kiuno_example/state/stateful_encapsulation.dart';
import 'package:flutter_kiuno_example/bloc/numbers_game_bloc.dart';

import 'gesture/small_steel_ball.dart';
import 'global_bloc_observer.dart';
import 'gesture/guesture_detector.dart';
import 'layout/list/custom_scroll_view.dart';
import 'layout/list/nested_list_view.dart';
import 'layout/list/nested_list_view2.dart';
import 'layout/list/nested_list_view3.dart';
import 'layout/list/view_holder.dart';
import 'lifecycle/lifecycle.dart';
import 'layout/list/list_basic.dart';

late List<Widget> list;

void main() {
  /*
   * Causes objects like RenderPointerListener to flash while they are being
   * tapped. This can be useful to see how large the hit box is, e.g.
   * when debugging buttons that are harder to hit than expected.
   */
  // debugPaintPointersEnabled = true;

  // Bloc.observer = GlobalBlocObserver(); // Register GlobalBlocObserver
  // Bloc.observer = BlocObserver() // Unregister GlobalBlocObserver

  initRouteList();
  runApp(MyApp());
}

void initRouteList() {
  list = [
    TitleWidget(title: "Lifecycle"),
    NavigateButtonWidget(name: "lifecycle_page", route: LifecycleRoute()),
    TitleWidget(title: "Layout"),
    NavigateButtonWidget(name: "layout_basic_page", route: LayoutBasicRoute()),
    NavigateButtonWidget(
        name: "layout_basic2_page", route: LayoutBasic2Route()),
    NavigateButtonWidget(
        name: "layout_example1_page", route: LayoutExample1Route()),
    NavigateButtonWidget(
        name: "layout_example2_page", route: LayoutExample2Route()),
    NavigateButtonWidget(
        name: "layout_example3_page", route: LayoutExample3Route()),
    NavigateButtonWidget(
        name: "stateful_basic_page", route: StatefulBasicRoute()),
    NavigateButtonWidget(
        name: "stateful_encapsulation_page",
        route: StatefulEncapsulationRoute()),
    TitleWidget(title: "ScrollView"),
    NavigateButtonWidget(name: "list_basic_page", route: ListBasicRoute()),
    NavigateButtonWidget(name: "multi_list_page", route: MultiListRoute()),
    NavigateButtonWidget(name: "view_holder_page", route: ViewHolderRoute()),
    NavigateButtonWidget(
        name: "custom_scroll_view_page", route: CustomScrollViewRoute()),
    NavigateButtonWidget(
        name: "nested_list_view_page", route: NestedListViewRoute()),
    NavigateButtonWidget(
        name: "nested_list_view2_page", route: NestedListView2Route()),
    NavigateButtonWidget(
        name: "nested_list_view3_page", route: NestedListView3Route()),
    NavigateButtonWidget(
        name: "combination_list_page", route: CombinationListRoute()),
    TitleWidget(title: "Animation"),
    NavigateButtonWidget(
        name: "implicit_animations_page", route: ImplicitAnimationsRoute()),
    NavigateButtonWidget(
        name: "tween_animation_builder_page",
        route: TweenAnimationBuilderRoute()),
    NavigateButtonWidget(
        name: "explicit_animations_page", route: ExplicitAnimationsRoute()),
    NavigateButtonWidget(
        name: "animation_basic_page", route: AnimationBasicRoute()),
    NavigateButtonWidget(
        name: "hero_animation_page", route: HeroAnimationRoute()),
    NavigateButtonWidget(
        name: "siwtcher_animation_page", route: SwitcherAnimationRoute()),
    TitleWidget(title: "Bloc"),
    NavigateButtonWidget(
        name: "numbers_game_bloc_page", route: NumbersGameBlocRoute()),
    NavigateButtonWidget(
        name: "calculator_cubit_page", route: CalculatorCubitRoute()),
    TitleWidget(title: "Other"),
    NavigateButtonWidget(
        name: "gesture_detector_page", route: GestureDetectorRoute()),
    NavigateButtonWidget(
        name: "small_steel_ball_page", route: SmallSteelBallRoute()),
  ];
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
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return list[index];
        },
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

class TitleWidget extends StatelessWidget {
  const TitleWidget({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}

class NavigateButtonWidget extends StatelessWidget {
  const NavigateButtonWidget({required this.name, required this.route});

  final String name;
  final BaseRoute route;

  void navigateRoute(BuildContext context, BaseRoute route) async {
    final result =
        await Navigator.of(context).push(_buildPageRouteBuilder(route));
    debugPrint('Navigator return value: $result');
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: ElevatedButton(
            onPressed: () => navigateRoute(context, route),
            child: Text(name),
          ),
        )
      ],
    );
  }
}
