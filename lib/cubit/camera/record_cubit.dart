import 'package:bloc/bloc.dart';

class RecordCubit extends Cubit<bool> {
  RecordCubit() : super(false);

  void start() => emit(true);
  void stop() => emit(false);
}
