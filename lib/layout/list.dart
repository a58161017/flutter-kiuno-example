import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_kiuno_example/base.dart';

class ListRoute extends BaseRoute {
  @override
  Widget build(BuildContext context) {
    return buildMaterialApp(
      context,
      'Startup List',
      'Kiuno\'s list',
      _ListWidget(),
    );
  }
}

class _ListWidget extends StatefulWidget {
  @override
  _ListState createState() => _ListState();
}

class _ListState extends State<_ListWidget>
    with SingleTickerProviderStateMixin {
  static const loadingTag = "##loading##";
  var _words = <String>[loadingTag];

  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  late AnimationController _controller;
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(0.0, -1.0),
    end: Offset.zero,
  ).animate(_controller);

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    _controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    _retrieveData();
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    debugPrint('result: ${result.toString()}');
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        setState(() => _connectionStatus = result.toString());
        _controller.reverse();
        break;
      case ConnectivityResult.none:
        setState(() => _connectionStatus = result.toString());
        _controller.forward();
        break;
      default:
        setState(() => _connectionStatus = 'Failed to get connectivity.');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.separated(
          itemCount: _words.length,
          itemBuilder: (BuildContext context, int index) {
            if (_words[index] == loadingTag) {
              if (_connectionStatus == ConnectivityResult.none.toString()) {
                return Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "網路不穩定請稍後！",
                      style: TextStyle(color: Colors.red),
                    ));
              } else {
                if (_words.length - 1 < 100) {
                  _retrieveData();
                  return Container(
                    padding: const EdgeInsets.all(16.0),
                    alignment: Alignment.center,
                    child: SizedBox(
                        width: 24.0,
                        height: 24.0,
                        child: CircularProgressIndicator(strokeWidth: 2.0)),
                  );
                } else {
                  return Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "已經到底了",
                        style: TextStyle(color: Colors.grey),
                      ));
                }
              }
            } else {
              return ListTile(title: Text(_words[index]));
            }
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider();
          },
        ),
        Visibility(
            visible: _connectionStatus == ConnectivityResult.none.toString(),
            child: Center(
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 24,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Icon(
                  Icons.warning,
                  size: 75,
                  color: Colors.yellow,
                ),
              ),
            )),
        SlideTransition(
          position: _offsetAnimation,
          child: Container(
            color: Colors.yellow,
            child: Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.warning,
                  size: 20,
                  color: Colors.white,
                ),
                Text(
                  '網路不穩定！',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )
              ],
            )),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _connectivitySubscription.cancel();
    super.dispose();
  }

  void _retrieveData() {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      setState(() {
        _words.insertAll(_words.length - 1,
            generateWordPairs().take(20).map((e) => e.asPascalCase).toList());
      });
    });
  }
}
