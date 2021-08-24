import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kiuno_example/model/user.dart';

class JsonParsePage extends StatefulWidget {
  @override
  JsonParseState createState() => JsonParseState();
}

class JsonParseState extends State<JsonParsePage> {
  late List<User> userList;

  @override
  void initState() {
    super.initState();
    var user1 = User.fromJson(
        jsonDecode('{"name": "Kiuno", "email": "Kiuno@123.com"}'));
    var user2 = User.fromJson(jsonDecode('{"name": "Tony"}'));
    userList = [user1, user2];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildJsonParseWidget(),
    );
  }

  Widget _buildJsonParseWidget() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('name: ${userList[0].name}'),
              Container(width: 10),
              Text('email: ${userList[0].email}'),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('name: ${userList[1].name}'),
              Container(width: 10),
              Text('email: ${userList[1].email}'),
            ],
          ),
          Text('result: ${identical(userList[0], userList[1])}'),
        ],
      ),
    );
  }
}
