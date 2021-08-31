import 'package:flutter/material.dart';
import 'package:encryptblowfish/encryptblowfish.dart';
import 'package:flutter/services.dart';

class BlowFishPage extends StatefulWidget {
  @override
  BlowFishState createState() => BlowFishState();
}

class BlowFishState extends State<BlowFishPage> {
  String _platformVersion = 'Unknown';
  String key = '0f4e1aaabd074689b7d3ead824d1ee8e';
  String originStr =
      '{"info":{"language":"en","country":"tw","platform":"android","version":"8.1.24.11079","timezone":"Asia\/Taipei","appsflyer_adid":"7d3340d0-062a-486a-9423-7054346a20da","appsflyer_id":"1630375201438-1438602206119433976","model":"LM-G810","y":"25.051587","x":"121.5201","ads":true},"device":{"id":"7418a11f09a3d755","platform":"android","model":"LGE_LM-G810","token":"e4waFif2SpuuA38CzkxQ3t:APA91bGRpvM9CMihuqH4aMqN1RM7s3813n43rrM2UbGiWdeO-weZFsjqlBbkJPJV8wFzZoOhqXPq1SqUMAB0cX5B6oJWADdYlbT1P3COUwqnanl6x5ooBz-72TpWGTaic4Y10XEQRuTD","version":"8.1.24.11079"}}';
  String decryptStr =
      '/ZWkHwqHOraTpmenm/ogBNjD1THHOMWryoRzSMXcW08tFvlR+sBdbYxjFYZnzvxwvPy7lZcXShMH/syBNCHjat2GCk/aubb8bECFjXm8zRelq5Hbpicn/VJ/icE8cG/jI5CvVZvn2oA6kLscD3ffbJAIHAj5ZxlkFpWL3iRUMb1mHeLzrPli4zFB2VyyKRWoBUMVdGUCXEsg8tzCigsIuKX1efrjImTOa+9oReTjn23/hVD5edH6DJbE6/N301B4oBYiiVawREYn0LB866fVnK1H38VW/t9KXAgIIppbpInXsffXa9nUJ7JBonRCUEBiT1TP9PKas92Z9+IybxUUH6ijNMi3L8ShbUjnzCISoMlg2aXL0JjDuBkhPzUERvwqA4NFFJB48eKSBUepbNbjIqrcC6jDcBH7BphbsqzzpyVfSM5VeSedItiSc3+dL9/IsnNdCxanAMzyQp1LtpenOQz+4cPfPfc6dldXzb/Uzac6pHdCRC/ehRI7Omcfqi0/prcxGXRI3XZwxocOtg2ZI9ex99dr2dQnUoEgQ4Pppnyq2U0C/Qh4g1R7ZKlcAVOkE1zhlGSqaShIUwx4qZFcZPWLm9/tI2H/De+IXIPn1Ar+ZxYSePhQfujcV1oLcx+unRkOoxMZntzYeV5W33gvMy/s9yh01HoXvef0tVPMm0uRZ2trLECo9EQ9Yv9+Ua+o8r+G6qBY9ecqoH8acK3IbXqaCp6eK1k4N+ShSGxu0617gC1VevVd84lheGkyTu9sUIzy4/AxaOboslMqw6K3gyQOIplyexhOGTXwYNeme4J2V1fNv9TNpwbb+blVSDMif1HyeyX5BewQpDE4/YfvWZ6nqpCanGNinveT/sP5tdo76Ftu5tOMP5Zfze42Hmg85/39Ypm1rcAj2QrqufxEp8l1AD2uUUTt';
  String _encrypt = 'Unknown';
  String _decrypt = 'Unknown';

  Future<void> initPlatformState() async {
    String platformVersion;
    String encrypt = 'Unknown';
    String decrypt = 'Unknown';
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await Encryptblowfish.platformVersion;
      encrypt = await Encryptblowfish.getStringAfterEncrypt(key, originStr);
      decrypt = await Encryptblowfish.getStringAfterDecrypt(key, decryptStr);
      debugPrint('encrypt: $encrypt');
      debugPrint('decrypt: $decrypt');
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
      _encrypt = encrypt;
      _decrypt = decrypt;
    });
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBlowFishWidget(),
    );
  }

  Widget _buildBlowFishWidget() {
    return Column(
      children: <Widget>[
        Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
        Center(
          child: Text("Encrypt : $_encrypt"),
        ),
        Center(
          child: Text("Decrypt : $_decrypt"),
        )
      ],
    );
  }
}
