part of '../camera_page.dart';

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
