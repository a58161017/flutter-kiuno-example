import 'package:flutter/material.dart';

abstract class BaseRoute extends StatelessWidget {
  Widget buildMaterialApp(BuildContext context, String appTitle, String appBarTitle, Widget child) {
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: MaterialApp(
        title: appTitle,
        home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => _onBackPressed(context),
            ),
            title: Text(appBarTitle),
          ),
          body: child,
        ),
      ),
    );
  }

  Future<bool> _onBackPressed(BuildContext context) async {
    var args = ModalRoute.of(context)!.settings.arguments;
    Navigator.pop(context, "$args return");
    return true;
  }
}