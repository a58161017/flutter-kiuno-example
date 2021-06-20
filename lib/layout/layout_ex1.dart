import 'package:flutter/material.dart';
import 'package:flutter_kiuno_example/base.dart';

class LayoutExample1Route extends BaseRoute {
  @override
  Widget build(BuildContext context) {
    return buildMaterialApp(
      context,
      'Startup Layout Example',
      'Kiuno\'s layout example1',
      LayoutExample1Widget(),
    );
  }
}

class LayoutExample1Widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.account_circle,
                size: 50,
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Flutter McFlutter',
                  style: Theme.of(context).textTheme.headline5,
                ),
                Text('Experienced App Developer'),
              ],
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('123 Main Street'),
            Text('(415) 555-0198'),
          ],
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.accessibility,
              size: 50,
            ),
            Icon(
              Icons.timer,
              size: 50,
            ),
            Icon(
              Icons.phone_android,
              size: 50,
            ),
            Icon(
              Icons.phone_iphone,
              size: 50,
            ),
          ],
        )
      ],
    );
  }
}
