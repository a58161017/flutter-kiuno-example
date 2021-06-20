part of 'numbers_bloc.dart';

abstract class NumbersEvent {}
class SubmitEvent extends NumbersEvent {
  int submitValue;
  SubmitEvent(this.submitValue);
}
class ResetEvent extends NumbersEvent {}
