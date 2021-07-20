import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PermissionTipView extends StatelessWidget {
  VoidCallback? onPressedCallback;

  PermissionTipView({this.onPressedCallback});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 48, 32, 48),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Please Allow Access to Camera',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Color(0xFFFAFDFF),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 16,
            ),
            child: Text(
              'Use your camera to make videos and share your experience with the world.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Color(0x99E8F9FC),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 24,
            ),
            child: TextButton(
              onPressed: () => {
                if (onPressedCallback != null) {onPressedCallback!()}
              },
              child: Text(
                'Allow Access',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFFED765E),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
