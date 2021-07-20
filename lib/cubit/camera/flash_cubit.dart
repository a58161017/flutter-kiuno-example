import 'package:bloc/bloc.dart';
import 'package:flutter_kiuno_example/page/camera/view/flash_view.dart';

class FlashCubit extends Cubit<int> {
  FlashCubit() : super(FLASH_OFF);

  void off() => emit(FLASH_OFF);
  void on() => emit(FLASH_ON);
  void auto() => emit(FLASH_AUTO);
}
