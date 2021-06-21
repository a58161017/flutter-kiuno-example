part of 'calculator_cubit.dart';

enum Arithmetic { add, subtract, multiply, divide }

@immutable
abstract class CalculatorState {
  double? num1;
  double? num2;
  Arithmetic arithmetic = Arithmetic.add;

  CalculatorState clone(CalculatorState newState) {
    newState.num1 = num1;
    newState.num2 = num2;
    newState.arithmetic = arithmetic;
    return newState;
  }
}

class CalculatorInitial extends CalculatorState {
  CalculatorInitial() {
    arithmetic = Arithmetic.add;
  }
}

class CalculatorInput extends CalculatorState {
  final double inputValue;
  CalculatorInput({required this.inputValue});
}

class CalculatorOperate extends CalculatorState {
  final Arithmetic newArithmetic;
  CalculatorOperate({required this.newArithmetic});
}

class CalculatorSum extends CalculatorState {
  double? getSum() {
    if (num1 == null ||
        num2 == null ||
        (arithmetic == Arithmetic.divide && num2 == 0.0)) {
      return null;
    } else {
      switch (arithmetic) {
        case Arithmetic.add:
          return num1! + num2!;
        case Arithmetic.subtract:
          return num1! - num2!;
        case Arithmetic.multiply:
          return num1! * num2!;
        case Arithmetic.divide:
          return num1! / num2!;
      }
    }
  }
}
