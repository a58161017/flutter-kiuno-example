import 'dart:ui';

import 'package:flutter/material.dart';

class WidgetUtil {
  static Size getScreenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static double getNavigatorHeight(BuildContext context) {
    return MediaQueryData.fromWindow(window).padding.top;
  }
}
