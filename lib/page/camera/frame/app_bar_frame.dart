import 'package:flutter/material.dart';
import 'package:flutter_kiuno_example/cubit/camera/countdown_cubit.dart';
import 'package:flutter_kiuno_example/cubit/camera/flash_cubit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '../view/close_view.dart';

part '../view/countdown_view.dart';

part '../view/flash_view.dart';

part '../view/info_view.dart';

abstract class OnAppBarFrameListener {
  void onCloseClicked();

  void onCountdownClicked();

  void onFlashClicked();

  void onInfoClicked();
}

class AppBarFrame extends StatelessWidget {
  final OnAppBarFrameListener? listener;

  AppBarFrame({this.listener});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => listener?.onCloseClicked(),
          child: CloseView(),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocBuilder<CountdownCubit, int>(builder: (context, state) {
              return GestureDetector(
                onTap: () => listener?.onCountdownClicked(),
                child: CountdownView(mode: state),
              );
            }),
            BlocBuilder<FlashCubit, int>(builder: (context, state) {
              return GestureDetector(
                onTap: () => listener?.onFlashClicked(),
                child: FlashView(mode: state),
              );
            }),
            GestureDetector(
              onTap: () => listener?.onInfoClicked(),
              child: InfoView(),
            ),
          ],
        )
      ],
    );
  }
}
