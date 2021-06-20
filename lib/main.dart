import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kiuno_example/bloc/numbers_bloc.dart';
import 'package:flutter_kiuno_example/layout/layout_basic.dart';
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
        routes: { // register route table
          "lifecycle_page":(context) => LifecycleRoute(),
          "layout_basic_page":(context) => LayoutBasicRoute(),
          "layout_example1_page":(context) => LayoutExample1Route(),
          "layout_example2_page":(context) => LayoutExample2Route(),
          "layout_example3_page":(context) => LayoutExample3Route(),
          "stateful_basic_page":(context) => StatefulBasicRoute(),
          "stateful_encapsulation_page":(context) => StatefulEncapsulationRoute(),
          "list_page":(context) => ListRoute(),
          "numbers_game_bloc_page":(context) => NumbersGameBlocRoute(),
          "/":(context) => MyHomeRoute(),
        },
    );
  }
}

class MyHomeRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome to Kiuno\'s example'),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildNavigationButtonByRouteName(context, 'Lifecycle', "lifecycle_page"),
          _buildNavigationButtonByRouteName(context, 'Layout basic', "layout_basic_page"),
          _buildNavigationButtonByRouteName(context, 'Layout example1', "layout_example1_page"),
          _buildNavigationButtonByRouteName(context, 'Layout example2', "layout_example2_page"),
          _buildNavigationButtonByRouteName(context, 'Layout example3', "layout_example3_page"),
          _buildNavigationButtonByRouteName(context, 'Stateful basic', "stateful_basic_page"),
          _buildNavigationButtonByRouteName(context, 'Stateful encapsulation', "stateful_encapsulation_page"),
          _buildNavigationButtonByRouteName(context, 'List', "list_page"),
          _buildNavigationButtonByRouteName(context, 'Numbers game bloc', "numbers_game_bloc_page"),

          // _buildNavigationButton(context, 'Lifecycle', LifecycleRoute()),
          // _buildNavigationButton(context, 'Layout basic', LayoutBasicRoute()),
          // _buildNavigationButton(context, 'Layout example1', LayoutExample1Route()),
          // _buildNavigationButton(context, 'Layout example2', LayoutExample2Route()),
          // _buildNavigationButton(context, 'Layout example3', LayoutExample3Route()),
          // _buildNavigationButton(context, 'Stateful basic', StatefulBasicRoute()),
          // _buildNavigationButton(context, 'Stateful encapsulation', StatefulEncapsulationRoute()),
          // _buildNavigationButton(context, 'List', ListRoute()),
          // _buildNavigationButton(context, 'Numbers game bloc', NumbersGameBlocRoute()),
        ],
      ),
    );
  }
}

ElevatedButton _buildNavigationButtonByRouteName(BuildContext context, String btnName, String routeName) {
  return ElevatedButton(
    child: Text(btnName),
    onPressed: () async {
      // The result may be null if the user uses navigation button to return.
      final result = await Navigator.of(context).pushNamed(routeName, arguments: routeName);
      // final result = await Navigator.pushNamed(context, routeName, arguments: routeName);
      debugPrint('Navigator return value: $result');
    },
  );
}

ElevatedButton _buildNavigationButton(BuildContext context, String btnName, StatelessWidget route) {
  return ElevatedButton(
    child: Text(btnName),
    onPressed: () async {
      final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => route));
      debugPrint('Navigator return value: $result');
    },
  );
}