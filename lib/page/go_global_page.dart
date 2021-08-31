import 'package:flutter/material.dart';
import 'package:encryptblowfish/encryptblowfish.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class GoGlobalPage extends StatefulWidget {
  @override
  GoGlobalState createState() => GoGlobalState();
}

class GoGlobalState extends State<GoGlobalPage> {
  // String _platformVersion = 'Unknown';
  // String key = '0f4e1aaabd074689b7d3ead824d1ee8e';
  String key = '338e5842'; // Native code: UserConfig.generateSecretKey(user_id)
  String userId = '!CKp!4v3Jl!';
  String originStr =
      '{"info":{"language":"en","country":"tw","platform":"android","version":"8.1.24.11079","timezone":"Asia\/Taipei","appsflyer_adid":"7d3340d0-062a-486a-9423-7054346a20da","appsflyer_id":"1630375201438-1438602206119433976","model":"LM-G810","y":"25.051587","x":"121.5201","ads":true},"action_type":"3"}';

  Future<void> _getGoGlobal() async {
    var encryptStr = await _encrypt(originStr);
    debugPrint('encryptStr: $encryptStr');
    var response = await http.post(
      Uri.parse(
          'https://srv1api-v2-framy-stage.uc.app.playsee.co/app5.0.0/home/get_go_global'),
      headers: <String, String>{
        // 'Content-Type': 'application/json; charset=UTF-8',
        'Content-Type': 'text/plain; charset=utf-8',
        'Authorization': '02DU9UXwpMiPvSCg#7418a11f09a3d755#!CKp!4v3Jl!'
      },
      body: encryptStr,
    );
    _processGetGoGlobalResponse(response);
  }

  Future<void> _processGetGoGlobalResponse(http.Response response) async {
    debugPrint('response.body: ${response.body}');
    var body = await _decrypt(response.body.substring(8));
    debugPrint('decryptStr: $body');
  }

  Future<String> _encrypt(String data) async {
    return await Encryptblowfish.getStringAfterEncrypt(key, data);
  }

  Future<String> _decrypt(String source) async {
    return await Encryptblowfish.getStringAfterDecrypt(key, source);
  }

  @override
  void initState() {
    super.initState();
    _getGoGlobal();
    // initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBlowFishWidget(),
    );
  }

  Widget _buildBlowFishWidget() {
    return Center(
      child: Text('test'),
    );
  }
}
