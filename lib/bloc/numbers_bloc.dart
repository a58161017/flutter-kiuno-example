import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'numbers_event.dart';
part 'numbers_state.dart';

class NumbersBloc extends Bloc<NumbersEvent, NumbersState> {
  NumbersBloc() : super(NumbersInitial());

  @override
  Stream<NumbersState> mapEventToState(
    NumbersEvent event,
  ) async* {
    debugPrint('${event.runtimeType} is trigger, '
        'state:${state.state} '
        'minValue:${state.minValue} '
        'maxValue:${state.maxValue} '
        'guessValue:${state.guessValue} '
        'inputValue:${state.inputValue} '
        'guessTimes:${state.guessTimes}');
    if (event is SubmitEvent) {
      if (state.state != MessageState.completeGame) {
        int sValue = event.submitValue; // submit value
        int gValue = state.guessValue; // guess value

        // Check error
        if (sValue == -1) {
          state.state = MessageState.inputError;
        } else if (sValue < state.minValue || sValue > state.maxValue) {
          state.state = MessageState.rangeOut;
        } else {
          state.guessTimes++;
          state.inputValue = sValue;
          if (sValue == gValue) {
            state.state = MessageState.completeGame;
          } else if (sValue > gValue) {
            state.maxValue = event.submitValue;
            state.state = MessageState.guess;
          } else if (sValue < gValue) {
            state.minValue = event.submitValue;
            state.state = MessageState.guess;
          }
        }
      }
    } else if (event is ResetEvent) {
      state.initValues();
    }
    yield state.getNewState();
  }
}
