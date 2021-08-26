import 'package:camera/camera.dart';
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
import 'package:flutter_kiuno_example/page/aspect_ratio_page.dart';
import 'package:flutter_kiuno_example/page/json_parse_page.dart';
import 'package:flutter_kiuno_example/page/location_page.dart';
import 'package:flutter_kiuno_example/state/stateful_basic.dart';
import 'package:flutter_kiuno_example/state/stateful_encapsulation.dart';
import 'package:flutter_kiuno_example/bloc/numbers_game_bloc.dart';

import 'gesture/small_steel_ball.dart';
import 'gesture/guesture_detector.dart';
import 'layout/list/custom_scroll_view.dart';
import 'layout/list/findable_list_view.dart';
import 'layout/list/nested_list_view.dart';
import 'layout/list/nested_list_view2.dart';
import 'layout/list/nested_list_view3.dart';
import 'layout/list/view_holder.dart';
import 'lifecycle/lifecycle.dart';
import 'layout/list/list_basic.dart';
import 'page/camera/camera_page.dart';

late List<_TitleItem> _titleList;
late List<_RouteItem> _routeList;
List<CameraDescription> cameras = [];
Size? safeAreaSize;

void main() {
  /*
   * Causes objects like RenderPointerListener to flash while they are being
   * tapped. This can be useful to see how large the hit box is, e.g.
   * when debugging buttons that are harder to hit than expected.
   */
  // debugPaintPointersEnabled = true;

  // Bloc.observer = GlobalBlocObserver(); // Register GlobalBlocObserver
  // Bloc.observer = BlocObserver() // Unregister GlobalBlocObserver

  // Fetch the available cameras before initializing the app.
  // try {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   cameras = await availableCameras();
  // } on CameraException catch (e) {
  //   debugPrint('e.code: ${e.code}, e.description: ${e.description}');
  // }

  initRouteList();
  runApp(MyApp());
}

const String TITLE_LIFECYCLE = 'Lifecycle';
const String TITLE_LAYOUT = 'Layout';
const String TITLE_SCROLLVIEW = 'ScrollView';
const String TITLE_ANIMATION = 'Animation';
const String TITLE_BLOC = 'Bloc';
const String TITLE_CAMERA = 'Camera';
const String TITLE_OTHER = 'Other';

void initRouteList() {
  _titleList = [
    _TitleItem(headerValue: TITLE_LIFECYCLE),
    _TitleItem(headerValue: TITLE_LAYOUT),
    _TitleItem(headerValue: TITLE_SCROLLVIEW),
    _TitleItem(headerValue: TITLE_ANIMATION),
    _TitleItem(headerValue: TITLE_BLOC),
    _TitleItem(headerValue: TITLE_CAMERA),
    _TitleItem(headerValue: TITLE_OTHER),
  ];

  _routeList = [
    _RouteItem(
        headerValue: TITLE_LIFECYCLE,
        routeName: 'lifecycle_page',
        route: LifecycleRoute()),
    _RouteItem(
        headerValue: TITLE_LAYOUT,
        routeName: 'lifecycle_page',
        route: LifecycleRoute()),
    _RouteItem(
        headerValue: TITLE_LAYOUT,
        routeName: 'layout_basic_page',
        route: LayoutBasicRoute()),
    _RouteItem(
        headerValue: TITLE_LAYOUT,
        routeName: 'layout_basic2_page',
        route: LayoutBasic2Route()),
    _RouteItem(
        headerValue: TITLE_LAYOUT,
        routeName: 'layout_example1_page',
        route: LayoutExample1Route()),
    _RouteItem(
        headerValue: TITLE_LAYOUT,
        routeName: 'layout_example2_page',
        route: LayoutExample2Route()),
    _RouteItem(
        headerValue: TITLE_LAYOUT,
        routeName: 'layout_example3_page',
        route: LayoutExample3Route()),
    _RouteItem(
        headerValue: TITLE_LAYOUT,
        routeName: 'stateful_basic_page',
        route: StatefulBasicRoute()),
    _RouteItem(
        headerValue: TITLE_LAYOUT,
        routeName: 'stateful_encapsulation_page',
        route: StatefulEncapsulationRoute()),
    _RouteItem(
        headerValue: TITLE_SCROLLVIEW,
        routeName: 'list_basic_page',
        route: ListBasicRoute()),
    _RouteItem(
        headerValue: TITLE_SCROLLVIEW,
        routeName: 'multi_list_page',
        route: MultiListRoute()),
    _RouteItem(
        headerValue: TITLE_SCROLLVIEW,
        routeName: 'view_holder_page',
        route: ViewHolderRoute()),
    _RouteItem(
        headerValue: TITLE_SCROLLVIEW,
        routeName: 'custom_scroll_view_page',
        route: CustomScrollViewRoute()),
    _RouteItem(
        headerValue: TITLE_SCROLLVIEW,
        routeName: 'nested_list_view_page',
        route: NestedListViewRoute()),
    _RouteItem(
        headerValue: TITLE_SCROLLVIEW,
        routeName: 'nested_list_view2_page',
        route: NestedListView2Route()),
    _RouteItem(
        headerValue: TITLE_SCROLLVIEW,
        routeName: 'nested_list_view3_page',
        route: NestedListView3Route()),
    _RouteItem(
        headerValue: TITLE_SCROLLVIEW,
        routeName: 'combination_list_page',
        route: CombinationListRoute()),
    _RouteItem(
        headerValue: TITLE_SCROLLVIEW,
        routeName: 'findable_list_view_page',
        route: FindableListViewRoute()),
    _RouteItem(
        headerValue: TITLE_ANIMATION,
        routeName: 'implicit_animations_page',
        route: ImplicitAnimationsRoute()),
    _RouteItem(
        headerValue: TITLE_ANIMATION,
        routeName: 'tween_animation_builder_page',
        route: TweenAnimationBuilderRoute()),
    _RouteItem(
        headerValue: TITLE_ANIMATION,
        routeName: 'explicit_animations_page',
        route: ExplicitAnimationsRoute()),
    _RouteItem(
        headerValue: TITLE_ANIMATION,
        routeName: 'animation_basic_page',
        route: AnimationBasicRoute()),
    _RouteItem(
        headerValue: TITLE_ANIMATION,
        routeName: 'hero_animation_page',
        route: HeroAnimationRoute()),
    _RouteItem(
        headerValue: TITLE_ANIMATION,
        routeName: 'switcher_animation_page',
        route: SwitcherAnimationRoute()),
    _RouteItem(
        headerValue: TITLE_BLOC,
        routeName: 'numbers_game_bloc_page',
        route: NumbersGameBlocRoute()),
    _RouteItem(
        headerValue: TITLE_BLOC,
        routeName: 'calculator_cubit_page',
        route: CalculatorCubitRoute()),
    _RouteItem(
      headerValue: TITLE_CAMERA,
      routeName: 'camera',
      route: CameraPage(),
    ),
    _RouteItem(
        headerValue: TITLE_OTHER,
        routeName: 'gesture_detector_page',
        route: GestureDetectorRoute()),
    _RouteItem(
        headerValue: TITLE_OTHER,
        routeName: 'small_steel_ball_page',
        route: SmallSteelBallRoute()),
    _RouteItem(
        headerValue: TITLE_OTHER,
        routeName: 'aspect_ratio_page',
        route: AspectRatioPage()),
    _RouteItem(
        headerValue: TITLE_OTHER,
        routeName: 'json_parse_page',
        route: JsonParsePage()),
    _RouteItem(
        headerValue: TITLE_OTHER,
        routeName: 'location_page',
        route: LocationPage()),
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

class MyHomeRoute extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHomeRoute> {
  bool hasExpanded = false;

  Widget _buildExpansionPanelList() {
    return ExpansionPanelList(
      dividerColor: Colors.grey,
      animationDuration: const Duration(milliseconds: 300),
      elevation: 1,
      expandedHeaderPadding: EdgeInsets.all(8),
      children: _titleList.map<ExpansionPanel>((_TitleItem titleItem) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return Center(child: Text(titleItem.headerValue));
          },
          body: ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: _routeList
                .where((routeItem) =>
                    titleItem.headerValue == routeItem.headerValue)
                .map<ListTile>((_RouteItem routeItem) {
              return ListTile(
                title: Text(routeItem.routeName),
                onTap: () async {
                  final result = await Navigator.of(context)
                      .push(_buildPageRouteBuilder(routeItem.route));
                  debugPrint('Navigator return value: $result');
                },
              );
            }).toList(),
          ),
          isExpanded: titleItem.isExpanded,
        );
      }).toList(),
      expansionCallback: (int panelIndex, bool isExpanded) {
        setState(() => _titleList[panelIndex].isExpanded = !isExpanded);
        _checkExpanded();
      },
    );
  }

  void _checkExpanded() {
    bool result = false;
    _titleList.forEach((titleItem) {
      result |= titleItem.isExpanded;
    });
    if (result != hasExpanded) {
      setState(() => hasExpanded = result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to Kiuno\'s example'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                safeAreaSize = constraints.biggest;
                return Container();
              },
            ),
          ),
          SingleChildScrollView(
            child: Container(
              child: _buildExpansionPanelList(),
            ),
          ),
          Positioned(
            right: 8,
            bottom: 8,
            child: Visibility(
              visible: hasExpanded,
              child: FloatingActionButton(
                  child: Icon(Icons.close),
                  onPressed: () => {
                        setState(() {
                          _titleList.forEach((titleItem) {
                            titleItem.isExpanded = false;
                          });
                          hasExpanded = false;
                        })
                      }),
            ),
          )
        ],
      ),
    );
  }
}

@deprecated
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

@deprecated
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

Route _buildPageRouteBuilder(Widget route) {
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

@deprecated
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

@deprecated
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

class _TitleItem {
  final String headerValue;
  bool isExpanded;

  _TitleItem({required this.headerValue, this.isExpanded = false});
}

class _RouteItem {
  final String headerValue;
  final String routeName;
  final Widget route;

  _RouteItem(
      {required this.headerValue,
      required this.routeName,
      required this.route});
}
