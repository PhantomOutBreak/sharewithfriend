import 'package:flutter/material.dart';

class SimpleTask extends StatefulWidget {
  const SimpleTask({super.key});
  @override
  State<SimpleTask> createState() => _SimpleTaskState();
}

class _SimpleTaskState extends State<SimpleTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Isolate Examples: Simple Task'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const CircularProgressIndicator(),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () {}, child: const Text('Simple Task')),
          ],
        ),
      ),
    );
  }
}
