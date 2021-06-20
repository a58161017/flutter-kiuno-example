import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlobalBlocObserver extends BlocObserver {
  @override
  Future<void> onEvent(Bloc bloc, Object? event) async {
    super.onEvent(bloc, event);
    debugPrint('[GlobalBlocObserver].onEvent() => ${bloc.runtimeType} ${event.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    debugPrint('[GlobalBlocObserver].onChange() => ${bloc.runtimeType} $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    debugPrint('[GlobalBlocObserver].onTransition() => ${bloc.runtimeType} $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint('[GlobalBlocObserver].onError() => ${bloc.runtimeType} $error $stackTrace');
    super.onError(bloc, error, stackTrace);
  }
}