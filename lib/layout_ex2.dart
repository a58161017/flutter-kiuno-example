import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class LayoutExample2Route extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments;
    return MaterialApp(
      title: 'Startup Layout Example2',
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () { Navigator.pop(context, "$args return"); },),
          title: Text('Kiuno\'s layout example2'),
        ),
        body: LayoutExample2(),
      ),
    );
  }
}

class LayoutExample2 extends StatefulWidget {
  @override
  _LayoutExample2State createState() => _LayoutExample2State();
}

class _LayoutExample2State extends State<LayoutExample2> {
  @override
  void initState() {
    super.initState();
    // Set landscape orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    // Set portrait orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 280,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(0, 24, 0, 0),
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      border: Border.all(color: Colors.black)),
                  alignment: Alignment.center,
                  child: Text(
                    'Strawberry Pavlova',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      border: Border.all(color: Colors.black)),
                  alignment: Alignment.center,
                  child: Text(
                    'Pavlova is a meringue-based dessert named after the Russian ballerina Anna Pavlova.\nPavlova features a crisp crust and soft, light inside, topped with fruit and whipped cream.',
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      border: Border.all(color: Colors.black)),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 14,
                          ),
                          Icon(
                            Icons.star,
                            size: 14,
                          ),
                          Icon(
                            Icons.star,
                            size: 14,
                          ),
                          Icon(
                            Icons.star,
                            size: 14,
                          ),
                          Icon(
                            Icons.star,
                            size: 14,
                          ),
                        ],
                      ),
                      Text('170 Reviews')
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(0, 24, 0, 0),
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      border: Border.all(color: Colors.black)),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Container(height: 4,),
                          Icon(
                            Icons.smartphone,
                            size: 14,
                            color: Colors.green,
                          ),
                          Container(height: 4,),
                          Text('PREP:'),
                          Container(height: 8,),
                          Text('25 min'),
                          Container(height: 8,),
                        ],
                      ),
                      Column(
                        children: [
                          Container(height: 4,),
                          Icon(
                            Icons.timer,
                            size: 14,
                            color: Colors.green,
                          ),
                          Container(height: 4,),
                          Text('COOK:'),
                          Container(height: 8,),
                          Text('1 hr'),
                          Container(height: 8,),
                        ],
                      ),
                      Column(
                        children: [
                          Container(height: 4,),
                          Icon(
                            Icons.food_bank,
                            size: 14,
                            color: Colors.green,
                          ),
                          Container(height: 4,),
                          Text('FEEDS:'),
                          Container(height: 8,),
                          Text('4-6'),
                          Container(height: 8,),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(child: Image.asset('assets/pic1.jpeg')),
      ],
    );
  }
}
