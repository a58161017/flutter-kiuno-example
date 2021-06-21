import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'calculator_state.dart';

class CalculatorCubit extends Cubit<CalculatorState> {
  CalculatorCubit() : super(CalculatorInitial());

  void clear() => emit(CalculatorInitial());

  void input(int value) {
    CalculatorInput nextState = CalculatorInput(inputValue: value.toDouble());
    state.clone(nextState);
    nextState.num1 == null
        ? nextState.num1 = nextState.inputValue
        : nextState.num2 = nextState.inputValue;
    emit(nextState);
  }

  void add() => _mapOperateStateToEmit(
      state, CalculatorOperate(newArithmetic: Arithmetic.add));

  void subtract() => _mapOperateStateToEmit(
      state, CalculatorOperate(newArithmetic: Arithmetic.subtract));

  void multiply() => _mapOperateStateToEmit(
      state, CalculatorOperate(newArithmetic: Arithmetic.multiply));

  void divide() => _mapOperateStateToEmit(
      state, CalculatorOperate(newArithmetic: Arithmetic.divide));

  void sum() {
    if (state is CalculatorSum || state.num1 == null || state.num2 == null)
      return;

    emit(state.clone(CalculatorSum()));
  }

  void _mapOperateStateToEmit(
      CalculatorState currentState, CalculatorOperate nextState) {
    currentState.clone(nextState);
    if (nextState.arithmetic != nextState.newArithmetic) {
      nextState.arithmetic = nextState.newArithmetic;
      emit(nextState);
    }
  }
}
