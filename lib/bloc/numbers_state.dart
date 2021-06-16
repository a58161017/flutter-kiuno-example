part of 'numbers_bloc.dart';

enum MessageState {
  none,
  guess,
  rangeOut,
  inputError,
  completeGame,
}

@immutable
abstract class NumbersState {
  MessageState state = MessageState.none;
  int minValue = 0;
  int maxValue = 100;
  int guessValue = Random().nextInt(101);
  int inputValue = -1;
  int guessTimes = 0;

  void initValues() {
    state = MessageState.none;
    minValue = 0;
    maxValue = 100;
    guessValue = Random().nextInt(101);
    inputValue = -1;
    guessTimes = 0;
  }

  NumbersInitial getNewState() {
    NumbersInitial newState = NumbersInitial();
    newState.state = state;
    newState.minValue = minValue;
    newState.maxValue = maxValue;
    newState.guessValue = guessValue;
    newState.inputValue = inputValue;
    newState.guessTimes = guessTimes;
    return newState;
  }
}

class NumbersInitial extends NumbersState {}
