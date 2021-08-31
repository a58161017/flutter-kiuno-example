import 'package:flutter/material.dart';
import 'package:encryptblowfish/encryptblowfish.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class FastLoginPage extends StatefulWidget {
  @override
  FastLoginState createState() => FastLoginState();
}

class FastLoginState extends State<FastLoginPage> {
  // String _platformVersion = 'Unknown';
  String key = '0f4e1aaabd074689b7d3ead824d1ee8e';
  String originStr =
      '{"info":{"language":"en","country":"tw","platform":"android","version":"8.1.24.11079","timezone":"Asia\/Taipei","appsflyer_adid":"7d3340d0-062a-486a-9423-7054346a20da","appsflyer_id":"1630375201438-1438602206119433976","model":"LM-G810","y":"25.051587","x":"121.5201","ads":true},"device":{"id":"7418a11f09a3d755","platform":"android","model":"LGE_LM-G810","token":"e4waFif2SpuuA38CzkxQ3t:APA91bGRpvM9CMihuqH4aMqN1RM7s3813n43rrM2UbGiWdeO-weZFsjqlBbkJPJV8wFzZoOhqXPq1SqUMAB0cX5B6oJWADdYlbT1P3COUwqnanl6x5ooBz-72TpWGTaic4Y10XEQRuTD","version":"8.1.24.11079"}}';

  Future<void> _fastLogin() async {
    var encryptStr = await _encrypt(originStr);
    debugPrint('encryptStr: $encryptStr');
    var response = await http.post(
      Uri.parse(
          'https://srv0api-v2-framy-stage.uc.app.playsee.co/app5.0.0/accounts/fast_login'),
      headers: <String, String>{
        // 'Content-Type': 'application/json; charset=UTF-8',
        'Content-Type': 'text/plain; charset=utf-8',
      },
      body: encryptStr,
    );
    _processFastLoginResponse(response);
  }

  Future<void> _processFastLoginResponse(http.Response response) async {
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
    _fastLogin();
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
