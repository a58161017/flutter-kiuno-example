import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_kiuno_example/base.dart';

class LifecycleRoute extends BaseRoute {
  @override
  Widget build(BuildContext context) {
    return buildAppBar(
      context,
      'Kiuno\'s lifecycle',
      _Lifecycle(),
    );
  }
}

class _Lifecycle extends StatefulWidget {
  @override
  _LifecycleState createState() => _LifecycleState();
}

class _LifecycleState extends State<_Lifecycle> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  AppLifecycleState? _notification;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _notification = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Last notification: $_notification');
    return Center(
      child: Text('Last notification: $_notification'),
    );
  }
}
