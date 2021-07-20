import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kiuno_example/base.dart';
import 'package:flutter_kiuno_example/cubit/calculator_cubit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CalculatorCubitRoute extends BaseRoute {
  @override
  Widget build(BuildContext context) {
    return buildAppBar(
      context,
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
      return StaggeredGridView.countBuilder(
          crossAxisCount: 4,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
          itemBuilder: (BuildContext context, int index) {
            switch (index) {
              case 0:
                var displayMessage = '';
                displayMessage += '${state.num1 != null ? state.num1 : '?'}';
                displayMessage += ' ${_getArithmetic(state.arithmetic)} ';
                displayMessage += '${state.num2 != null ? state.num2 : '?'}';
                displayMessage +=
                    ' = ${(state is CalculatorSum && state.getSum() != null) ? state.getSum()!.toStringAsFixed(2) : '?'}';
                return _buildDisplayText(displayMessage);
              case 1:
              case 2:
              case 3:
              case 5:
              case 6:
              case 7:
              case 9:
              case 10:
              case 11:
              case 14:
                return _buildInputButton(context, index);
              case 4:
                return _buildOperateButton(context, "+");
              case 8:
                return _buildOperateButton(context, "-");
              case 12:
                return _buildOperateButton(context, "*");
              case 13:
                return _buildOperateButton(context, "c");
              case 15:
                return _buildOperateButton(context, "=");
              case 16:
                return _buildOperateButton(context, "/");
              default:
                return Text('');
            }
          },
          staggeredTileBuilder: (int index) {
            return (index == 0)
                ? StaggeredTile.count(4, 1)
                : StaggeredTile.count(1, 1);
          });
      // return GridView(
      //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //         crossAxisCount: 4, childAspectRatio: 1.0),
      //     children: <Widget>[
      //       _buildDisplayText('${state.num1 != null ? state.num1 : ''}'),
      //       _buildDisplayText('${_getArithmetic(state.arithmetic)}'),
      //       _buildDisplayText('${state.num2 != null ? state.num2 : ''}'),
      //       _buildDisplayText(
      //           '= ${(state is CalculatorSum && state.getSum() != null) ? state.getSum()!.toStringAsFixed(2) : '?'}'),
      //       _buildInputButton(context, 1),
      //       _buildInputButton(context, 2),
      //       _buildInputButton(context, 3),
      //       _buildOperateButton(context, "+"),
      //       _buildInputButton(context, 4),
      //       _buildInputButton(context, 5),
      //       _buildInputButton(context, 6),
      //       _buildOperateButton(context, "-"),
      //       _buildInputButton(context, 7),
      //       _buildInputButton(context, 8),
      //       _buildInputButton(context, 9),
      //       _buildOperateButton(context, "*"),
      //       _buildOperateButton(context, "c"),
      //       _buildInputButton(context, 0),
      //       _buildOperateButton(context, "="),
      //       _buildOperateButton(context, "/"),
      //     ]);
    });
  }

  Widget _buildDisplayText(String context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(color: Colors.orange),
        child: Center(
          child: Text(
            context,
            style: TextStyle(fontSize: 28, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildInputButton(BuildContext context, int index) {
    var value = 0;
    switch (index) {
      case 1:
      case 2:
      case 3:
        value = index;
        break;
      case 5:
      case 6:
      case 7:
        value = index - 1;
        break;
      case 9:
      case 10:
      case 11:
        value = index - 2;
        break;
      case 14:
        value = 0;
        break;
    }
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
