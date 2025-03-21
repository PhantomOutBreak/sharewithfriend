import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'counter_bloc.dart';
import 'counter_event.dart';
import 'counter_state.dart';
import 'second_page.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterBloc, CounterState>(
      builder: (context, state) {
        int counter = (state as CounterValueState).counter;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Counter: $counter',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Colors.blue),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.read<CounterBloc>().add(DecrementEvent());
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),  
                  child: const Text('-', style: TextStyle(fontSize: 24)),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    context.read<CounterBloc>().add(IncrementEvent());
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),  
                  child: const Text('+', style: TextStyle(fontSize: 24)),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    context.read<CounterBloc>().add(MultiplyEvent());
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),  
                  child: const Text('x2', style: TextStyle(fontSize: 24)),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SecondPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple, 
                foregroundColor: Colors.white, 
              ),
              child: const Text("Go to Second Page"),
            ),
          ],
        );
      },
    );
  }
}
