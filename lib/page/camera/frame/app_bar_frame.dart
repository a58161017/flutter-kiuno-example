import 'package:flutter/material.dart';

part '../view/close_view.dart';
part '../view/countdown_view.dart';
part '../view/flash_view.dart';
part '../view/info_view.dart';

class AppBarFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => onBackPressed(context),
          child: CloseView(),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () => {},
              child: CountdownView(),
            ),
            GestureDetector(
              onTap: () => {},
              child: FlashView(),
            ),
            GestureDetector(
              onTap: () => {},
              child: InfoView(),
            ),
          ],
        )
      ],
    );
  }
}

Future<bool> onBackPressed(BuildContext context) async {
  var args = ModalRoute.of(context)!.settings.arguments;
  Navigator.pop(context, "$args return");
  return true;
}
