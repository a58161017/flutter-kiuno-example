import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kiuno_example/base.dart';
import 'package:flutter_kiuno_example/cubit/calculator_cubit.dart';

class CalculatorCubitRoute extends BaseRoute {
  @override
  Widget build(BuildContext context) {
    return buildMaterialApp(
      context,
      'Startup Calculator Cubit',
      'Kiuno\'s calculator cubit',
      _CalculatorWidget(),
    );
  }
}

class _CalculatorWidget extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<_CalculatorWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CalculatorCubit(),
      child: _CalculatorView(),
    );
  }
}

class _CalculatorView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalculatorCubit, CalculatorState>(
        builder: (context, state) {
      return GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, childAspectRatio: 1.0),
          children: <Widget>[
            _buildDisplayText('${state.num1 != null ? state.num1 : ''}'),
            _buildDisplayText('${_getArithmetic(state.arithmetic)}'),
            _buildDisplayText('${state.num2 != null ? state.num2 : ''}'),
            _buildDisplayText(
                '= ${(state is CalculatorSum && state.getSum() != null) ? state.getSum()!.toStringAsFixed(2) : '?'}'),
            _buildInputButton(context, 1),
            _buildInputButton(context, 2),
            _buildInputButton(context, 3),
            _buildOperateButton(context, "+"),
            _buildInputButton(context, 4),
            _buildInputButton(context, 5),
            _buildInputButton(context, 6),
            _buildOperateButton(context, "-"),
            _buildInputButton(context, 7),
            _buildInputButton(context, 8),
            _buildInputButton(context, 9),
            _buildOperateButton(context, "*"),
            _buildOperateButton(context, "c"),
            _buildInputButton(context, 0),
            _buildOperateButton(context, "="),
            _buildOperateButton(context, "/"),
          ]);
    });
  }

  Widget _buildDisplayText(String context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Center(
        child: Text(
          context,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  Widget _buildInputButton(BuildContext context, int value) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(textStyle: TextStyle(fontSize: 20)),
        onPressed: () => context.read<CalculatorCubit>().input(value),
        child: Text('$value'),
      ),
    );
  }

  Widget _buildOperateButton(BuildContext context, String arithmetic) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(textStyle: TextStyle(fontSize: 20)),
        onPressed: () {
          switch (arithmetic) {
            case "+":
              context.read<CalculatorCubit>().add();
              break;
            case "-":
              context.read<CalculatorCubit>().subtract();
              break;
            case "*":
              context.read<CalculatorCubit>().multiply();
              break;
            case "/":
              context.read<CalculatorCubit>().divide();
              break;
            case "c":
              context.read<CalculatorCubit>().clear();
              break;
            case "=":
              context.read<CalculatorCubit>().sum();
              break;
          }
        },
        child: Text(arithmetic),
      ),
    );
  }

  String _getArithmetic(Arithmetic arithmetic) {
    switch (arithmetic) {
      case Arithmetic.add:
        return "+";
      case Arithmetic.subtract:
        return "-";
      case Arithmetic.multiply:
        return "*";
      case Arithmetic.divide:
        return "/";
    }
  }
}
