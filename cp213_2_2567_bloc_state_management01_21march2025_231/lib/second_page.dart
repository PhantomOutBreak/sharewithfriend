import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'counter_bloc.dart';
import 'counter_state.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Second Page - BLoC Counter")),
      body: Center(
        child: BlocBuilder<CounterBloc, CounterState>(
          builder: (context, state) {
            int counter = (state as CounterValueState).counter;
            return Text(
              'Counter: $counter',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Colors.deepPurple),
            );
          },
        ),
      ),
    );
  }
}
