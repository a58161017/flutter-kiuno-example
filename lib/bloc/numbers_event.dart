part of 'numbers_bloc.dart';

@immutable
abstract class NumbersEvent {}
class SubmitEvent extends NumbersEvent {
  final int submitValue;
  SubmitEvent({@required this.submitValue});
}
class ResetEvent extends NumbersEvent {}
