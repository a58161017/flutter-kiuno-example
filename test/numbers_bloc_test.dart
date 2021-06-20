import 'package:flutter_kiuno_example/bloc/numbers_bloc.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group('NumbersBloc', () {
    late NumbersBloc numbersBloc;

    setUp(() {
      numbersBloc = NumbersBloc();
    });

    test('initial state isA<NumbersInitial>', () {
      expect(numbersBloc.state, isA<NumbersInitial>());
    });

    blocTest<NumbersBloc, NumbersState>(
      'emits [#error] when run NumbersBloc',
      build: () => NumbersBloc(),
      act: (bloc) {
        bloc.add(SubmitEvent(50));
        bloc.add(ResetEvent());
      },
      expect: () => [isA<NumbersInProgress>(), isA<NumbersInitial>()],
    );
  });
}