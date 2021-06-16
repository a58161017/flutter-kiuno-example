import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kiuno_example/bloc/numbers_bloc.dart';

class NumbersGameBlocRoute extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments;
    return MaterialApp(
      title: 'Startup Numbers Game Bloc',
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, "$args return");
            },
          ),
          title: Text('Kiuno\'s numbers game bloc'),
        ),
        body: _NumbersGameWidget(),
      ),
    );
  }
}

class _NumbersGameWidget extends StatefulWidget {
  @override
  _NumbersGameState createState() => _NumbersGameState();
}

class _NumbersGameState extends State<_NumbersGameWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NumbersBloc(),
      child: _NumbersGameView(),
    );
  }
}

class _NumbersGameView extends StatelessWidget {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        BlocBuilder<NumbersBloc, NumbersState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildNumberText('${state.minValue}'),
                _buildNumberText('<='),
                _buildNumberText(state.state == MessageState.completeGame ? '${state.guessValue}' : '?'),
                _buildNumberText('<='),
                _buildNumberText('${state.maxValue}'),
              ],
            );
          },
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  height: 50,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter a 0-100 number'),
                    controller: myController,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: ElevatedButton(
                      onPressed: () => context
                          .read<NumbersBloc>()
                          .add(SubmitEvent(submitValue: myController.text.isEmpty? -1 : int.parse(myController.text))),
                      child: Text('Submit',)),
                ),
              ],
            ),
            BlocBuilder<NumbersBloc, NumbersState>(
              builder: (context, state) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(32, 8, 32, 8),
                  child: Text(getMessage(state), style: TextStyle(color: Colors.red)),
                );
              },
            ),
          ],
        ),
        ElevatedButton(
            onPressed: () => context.read<NumbersBloc>().add(ResetEvent()),
            child: Text('Reset'))
      ],
    );
  }

  Widget _buildNumberText(String content) {
    return Text(content, style: TextStyle(fontSize: 50),);
  }

  String getMessage(NumbersState state) {
    switch(state.state) {
      case MessageState.none:
        return '';
      case MessageState.guess:
        return 'The number you just guessed is ${state.inputValue}.';
      case MessageState.rangeOut:
        return 'The input is out of range.';
      case MessageState.inputError:
        return 'There is a problem with the entered value.';
      case MessageState.completeGame:
        return 'Congratulations on guessed at ${state.guessTimes} times.';
      default:
        return '';
    }
  }
}
