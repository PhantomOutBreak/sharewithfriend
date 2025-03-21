import 'package:flutter/material.dart';
import 'counter_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BLoC Counter - Kongpob Laohapipatchai"),
        centerTitle: true,
      ),
      body: const Center(
        child: CounterScreen(),
      ),
    );
  }
}
