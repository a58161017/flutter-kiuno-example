import 'package:flutter/material.dart';

abstract class BaseRoute extends StatelessWidget {
  Widget buildAppBar(BuildContext context, String appBarTitle, Widget child) {
    return WillPopScope(
      onWillPop: () => onBackPressed(context),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => onBackPressed(context),
          ),
          title: Text(appBarTitle),
        ),
        body: child,
      ),
    );
  }

  Future<bool> onBackPressed(BuildContext context) async {
    var args = ModalRoute.of(context)!.settings.arguments;
    Navigator.pop(context, "$args return");
    return true;
  }
}
