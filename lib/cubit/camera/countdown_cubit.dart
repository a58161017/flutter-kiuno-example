import 'package:bloc/bloc.dart';
import 'package:flutter_kiuno_example/page/camera/view/countdown_view.dart';

class CountdownCubit extends Cubit<int> {
  CountdownCubit() : super(COUNTDOWN_OFF);

  void off() => emit(COUNTDOWN_OFF);
  void on() => emit(COUNTDOWN_FIVE_SECONDS);
}
