import 'package:flutter/material.dart';
import 'package:flutter_kiuno_example/base.dart';

class LayoutBasicRoute extends BaseRoute {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return buildAppBar(
      context,
      'Kiuno\'s layout basic',
      _LayoutBasicWidget(),
    );
  }
}

class _LayoutBasicWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        Divider(),
        _buildIdWidget('1'),
        Row(
          // Row and Column occupy all of the space on their main axes. If the combined width of their children is less than the total space on their main axes, their children are laid out with extra space.
          mainAxisSize: MainAxisSize.max,
          // default
          // Positions children near the beginning of the main axis. (Left for Row, top for Column)
          mainAxisAlignment: MainAxisAlignment.start,
          // default
          children: [
            BlueBox(),
            BlueBox(),
            BlueBox(),
          ],
        ),
        Divider(),
        _buildIdWidget('2'),
        Row(
          // Row and Column only occupy enough space on their main axes for their children. Their children are laid out without extra space and at the middle of their main axes.
          mainAxisSize: MainAxisSize.min,
          // Positions children near the end of the main axis. (Right for Row, bottom for Column)
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            BlueBox(),
            BlueBox(),
            BlueBox(),
          ],
        ),
        Divider(),
        _buildIdWidget('3'),
        Row(
          // Positions children at the middle of the main axis.
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlueBox(),
            BlueBox(),
            BlueBox(),
          ],
        ),
        Divider(),
        _buildIdWidget('4'),
        Row(
          // Divides the extra space evenly between children.
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlueBox(),
            BlueBox(),
            BlueBox(),
          ],
        ),
        Divider(),
        _buildIdWidget('5'),
        Row(
          // Divides the extra space evenly between children and before and after the children.
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BlueBox(),
            BlueBox(),
            BlueBox(),
          ],
        ),
        Divider(),
        _buildIdWidget('6'),
        Row(
          // Similar to MainAxisAlignment.spaceEvenly, but reduces half of the space before the first child and after the last child to half of the width between the children.
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BlueBox(),
            BlueBox(),
            BlueBox(),
          ],
        ),
        BiggerDivider(),
        _buildIdWidget('7'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          // Positions children near the start of the cross axis. (Top for Row, Left for Column)
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlueBox(),
            BiggerBlueBox(),
            BlueBox(),
          ],
        ),
        Divider(),
        _buildIdWidget('8'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          // Positions children near the end of the cross axis. (Bottom for Row, Right for Column)
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            BlueBox(),
            BiggerBlueBox(),
            BlueBox(),
          ],
        ),
        Divider(),
        _buildIdWidget('9'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          // Positions children at the middle of the cross axis. (Middle for Row, Center for Column)
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlueBox(),
            BiggerBlueBox(),
            BlueBox(),
          ],
        ),
        BiggerDivider(),
        _buildIdWidget('10'),
        Row(
          // Row and Column occupy all of the space on their main axes. If the combined width of their children is less than the total space on their main axes, their children are laid out with extra space.
          mainAxisSize: MainAxisSize.max,
          // default
          // Positions children near the beginning of the main axis. (Left for Row, top for Column)
          mainAxisAlignment: MainAxisAlignment.start,
          // default
          children: [
            BlueBox(),
            Flexible(
              // Forces the widget to fill all of its extra space.
              fit: FlexFit.tight,
              flex: 2,
              child: BlueBox(),
            ),
            Flexible(
              // The widget’s preferred size is used. (Default)
              fit: FlexFit.loose, // default
              flex: 1, // default
              child: BlueBox(),
            )
          ],
        ),
        Divider(),
        _buildIdWidget('11'),
        Row(
          children: [
            BlueBox(),
            // Similar to Flexible, the Expanded widget can wrap a widget and force the widget to fill extra space.
            Expanded(child: BlueBox()),
            BlueBox(),
          ],
        ),
        Divider(),
        _buildIdWidget('12'),
        Row(
          children: [
            BlueBox(),
            SizedBox(
              width: 50,
              height: 50,
            ),
            BlueBox(),
            SizedBox(
              width: 100,
              height: 100,
              child: BlueBox(),
            ),
            BlueBox(),
          ],
        ),
        Divider(),
        _buildIdWidget('13'),
        Row(
          children: [
            BlueBox(),
            // Similar to SizedBox, the Spacer widget also can create space between widgets.
            Spacer(
              flex: 1,
            ),
            BlueBox(),
            Spacer(
              flex: 1,
            ),
            BlueBox(),
          ],
        ),
        BiggerDivider(),
        _buildIdWidget('14'),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              'Hey!',
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'Futura',
                color: Colors.blue,
              ),
            ),
            Text(
              'Hey!',
              style: TextStyle(
                fontSize: 50,
                fontFamily: 'Futura',
                color: Colors.green,
              ),
            ),
            Text(
              'Hey!',
              style: TextStyle(
                fontSize: 40,
                fontFamily: 'Futura',
                color: Colors.red,
              ),
            ),
          ],
        ),
        Divider(),
        _buildIdWidget('15'),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Icon(
              Icons.widgets,
              size: 50,
              color: Colors.blue,
            ),
            Icon(
              Icons.widgets,
              size: 30,
              color: Colors.red,
            ),
            Icon(
              Icons.wifi,
              size: 80,
              color: Colors.lightBlue,
            )
          ],
        ),
        Divider(),
        _buildIdWidget('16'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              child: Image.network(
                  'https://s3cdn.yourator.co/companies/logos/000/000/465/thumb/9bb1a700c41b0ce13a25d44c2c076c4a9e4d258a.png'),
            ),
          ],
        ),
        Divider(),
        _buildIdWidget('17'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Add assets to pubspec.yaml
            Container(
              width: 100,
              height: 100,
              child: Image.asset('assets/pic1.jpeg'),
            ),
          ],
        ),
        Divider(),
        _buildIdWidget('18'),
        Row(
          children: [
            Stack(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.red,
                ),
                Container(
                  width: 90,
                  height: 90,
                  color: Colors.green,
                ),
                Container(
                  width: 80,
                  height: 80,
                  color: Colors.blue,
                ),
                Positioned(
                  bottom: -10,
                  right: -10,
                  child: Container(
                    width: 50,
                    height: 50,
                    color: Colors.yellow,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                    width: 50,
                    height: 50,
                    color: Colors.grey,
                  ),
                ),
              ],
              clipBehavior: Clip.none,
            )
          ],
        ),
        BiggerDivider(),
        _buildIdAndNotionWidget('19', 'IconButton can click'),
        IconButton(
            icon: const Icon(
              Icons.star,
              size: 50,
              color: Colors.blue,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('You are lucky star!'),
              ));
            }),
        Divider(),
        _buildIdAndNotionWidget('20', 'FloatingActionButton can click'),
        FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('You want to add something!')));
            }),
        Divider(),
        _buildIdAndNotionWidget('21', 'ElevatedButton can click'),
        ElevatedButton(
            child: Text('Click me'),
            onPressed: () {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('Click me response!')));
            }),
        Divider(),
        _buildIdAndNotionWidget('22', 'Widget can tap'),
        GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('It\'s tap!'),
            ));
          },
          child: Container(
            width: 100,
            height: 50,
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.lightGreen[500],
            ),
            child: Center(
              child: Text('Click me'),
            ),
          ),
        ),
        Divider(),
      ],
    ));
  }
}

class BlueBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(),
      ),
    );
  }
}

class BiggerBlueBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(),
      ),
    );
  }
}

class BiggerDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Colors.black,
      thickness: 10,
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
