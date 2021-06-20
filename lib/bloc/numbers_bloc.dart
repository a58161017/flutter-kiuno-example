import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'numbers_event.dart';
part 'numbers_state.dart';

class NumbersBloc extends Bloc<NumbersEvent, NumbersState> {
  NumbersBloc() : super(NumbersInitial());

  // onEvent() -> S -> onTransition() -> onChange()

  @override
  void onEvent(NumbersEvent event) {
    debugPrint('[NumbersBloc].onEvent() => ${event.runtimeType}');
    super.onEvent(event);
  }

  @override
  Stream<NumbersState> mapEventToState(
    NumbersEvent event,
  ) async* {
    debugPrint('[NumbersBloc].mapEventToState() => ${state.toString()}');
    NumbersState returnState = state;
    if (event is SubmitEvent) {
      if (state.status != MessageStatus.completeGame) {
        NumbersInProgress newState = state.clone(NumbersInProgress(event.submitValue)) as NumbersInProgress;
        int sValue = event.submitValue; // submit value
        int gValue = state.guessValue; // guess value

        // Check error
        if (sValue == -1) {
          newState.status = MessageStatus.inputError;
        } else if (sValue < state.minValue || sValue > state.maxValue) {
          newState.status = MessageStatus.rangeOut;
        } else {
          newState.guessTimes++;
          newState.inputValue = sValue;
          if (sValue == gValue) {
            newState.status = MessageStatus.completeGame;
          } else if (sValue > gValue) {
            newState.maxValue = event.submitValue;
            newState.status = MessageStatus.guess;
          } else if (sValue < gValue) {
            newState.minValue = event.submitValue;
            newState.status = MessageStatus.guess;
          }
        }
        returnState = newState;
      }
    } else if (event is ResetEvent) {
      returnState = state.clone(NumbersInitial());
    }
    // New status objects are needed, and the layout will be notified to update.
    yield returnState;
  }

  // ex. Transition { currentState: Instance of 'NumbersInitial', event: Instance of 'SubmitEvent', nextState: Instance of 'NumbersInitial' }
  @override
  void onTransition(Transition<NumbersEvent, NumbersState> transition) {
    debugPrint('[NumbersBloc].onTransition() => $transition');
    super.onTransition(transition);
  }

  // ex. Change { currentState: Instance of 'NumbersInitial', nextState: Instance of 'NumbersInitial' }
  @override
  void onChange(Change<NumbersState> change) {
    debugPrint('[NumbersBloc].onChange() => $change');
    super.onChange(change);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    debugPrint('[NumbersBloc].onError() => $error, $stackTrace');
    super.onError(error, stackTrace);
  }
}
