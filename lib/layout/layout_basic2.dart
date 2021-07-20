import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kiuno_example/base.dart';
import 'package:url_launcher/url_launcher.dart';

class LayoutBasic2Route extends BaseRoute {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return buildAppBar(
      context,
      'Kiuno\'s layout basic2',
      LayoutBasic2Widget(),
    );
  }
}

class LayoutBasic2Widget extends StatelessWidget {
  void openWebsiteByUrl(String urlString) async {
    await canLaunch(urlString)
        ? await launch(urlString)
        : debugPrint('Could not launch $urlString');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Divider(),
          _buildIdWidget('1'),
          Row(
            children: [
              Text(
                "Hello world",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18.0,
                    height: 1.2,
                    fontFamily: "Courier",
                    background: new Paint()..color = Colors.yellow,
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.dashed),
              ),
            ],
          ),
          Divider(),
          _buildIdWidget('2'),
          Text.rich(TextSpan(children: [
            TextSpan(text: "HomePage: "),
            TextSpan(
                text: "https://www.google.com",
                style: TextStyle(color: Colors.blue),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => openWebsiteByUrl("https://www.google.com")),
          ])),
          Divider(),
          _buildIdWidget('3'),
          _buildCustomTextStyle(Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("hello world"),
              Text("I am Jack"),
              Text(
                "I am Jack",
                style: TextStyle(
                    inherit: false, //2.不继承默认样式
                    color: Colors.grey),
              ),
            ],
          )),
          Divider(),
          _buildIdAndNotionWidget('4', 'FlatButton(old) => TextButton(new)'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FlatButton(onPressed: () => {}, child: Text('FlatButton')),
              TextButton(
                onPressed: () => {},
                child: Text(
                  'TextButton',
                ),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                ),
              ),
            ],
          ),
          Divider(),
          _buildIdAndNotionWidget(
              '5', 'RaisedButton(old) => ElevatedButton(new)'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(onPressed: () => {}, child: Text('RaisedButton')),
              ElevatedButton(
                  onPressed: () => {}, child: Text('ElevatedButton')),
            ],
          ),
          Divider(),
          _buildIdAndNotionWidget(
              '6', 'OutlineButton(old) => OutlinedButton(new)'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlineButton(onPressed: () => {}, child: Text('OutlineButton')),
              OutlinedButton(
                  onPressed: () => {}, child: Text('OutlinedButton')),
            ],
          ),
        ],
      ),
    );
  }
}

Row _buildIdWidget(String id) {
  return Row(
    children: [
      Text(
        'ID:$id',
        style: TextStyle(fontSize: 32),
      ),
    ],
  );
}

Row _buildIdAndNotionWidget(String id, String notion) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.baseline,
    textBaseline: TextBaseline.alphabetic,
    children: [
      Text(
        'ID:$id',
        style: TextStyle(fontSize: 32),
      ),
      Text(' ($notion)')
    ],
  );
}

Widget _buildCustomTextStyle(Widget childWidget) {
  return DefaultTextStyle(
    style: TextStyle(
      color: Colors.red,
      fontSize: 20.0,
    ),
    textAlign: TextAlign.start,
    child: childWidget,
  );
}
