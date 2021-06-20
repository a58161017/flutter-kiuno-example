part of 'numbers_bloc.dart';

enum MessageStatus {
  none,
  guess,
  rangeOut,
  inputError,
  completeGame,
}

class NumbersState extends Equatable {
  late MessageStatus status;
  int minValue;
  int maxValue;
  int guessValue;
  int guessTimes;

  NumbersState({
    this.status = MessageStatus.none,
    this.minValue = 0,
    this.maxValue = 100,
    this.guessValue = 50,
    this.guessTimes = 0,
  });

  @override
  String toString() {
    return '''$runtimeType { status: $status, minValue: $minValue, maxValue: $maxValue, guessValue: $guessValue, guessTimes: $guessTimes }''';
  }

  NumbersState copyWith({
    MessageStatus? status,
    int? minValue,
    int? maxValue,
    int? guessValue,
    int? guessTimes,
  }) {
    return NumbersState(
      status: status ?? this.status,
      minValue: minValue ?? this.minValue,
      maxValue: maxValue ?? this.maxValue,
      guessValue: guessValue ?? this.guessValue,
      guessTimes: guessTimes ?? this.guessTimes,
    );
  }

  NumbersState clone(NumbersState newState) {
    newState.status = status;
    newState.minValue = minValue;
    newState.maxValue = maxValue;
    newState.guessValue = guessValue;
    newState.guessTimes = guessTimes;
    return newState;
  }

  @override
  List<Object?> get props => [status, minValue, maxValue, guessValue, guessTimes];
}

class NumbersInitial extends NumbersState {
  NumbersInitial() {
    status = MessageStatus.none;
    minValue = 0;
    maxValue = 100;
    guessValue = Random().nextInt(101);
    guessTimes = 0;
  }
}
class NumbersInProgress extends NumbersState {
  int inputValue;
  NumbersInProgress(this.inputValue);
}
class NumbersSuccess extends NumbersState {}
