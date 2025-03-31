import 'package:flutter/material.dart';

import 'intensive_task_no_isolate.dart';
import 'intensive_task_with_compute.dart';
import 'intensive_task_with_run.dart';
import 'intensive_task_with_spawn.dart';
import 'simple_task.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Isolate Examples',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      initialRoute: 'home',
      routes: {
        'home': (context) => const HomePage(),
        'simple_task': (context) => const SimpleTask(),
        'intensive_task_no_isolate': (context) => const IntensiveTaskNoIsolate(),
        'intensive_task_with_compute': (context) => const IntensiveTaskWithCompute(),
        'intensive_task_with_spawn': (context) => const IntensiveTaskWithSpawn(),
        'intensive_task_with_run': (context) => const IntensiveTaskWithRun(),
      },
    );
  }
}


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'CP213(2/2567): Isolate Inclass Exercise/kongpob Laohapipatchai/31 March 2025',
          style: TextStyle(fontSize: 10), 
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'simple_task');
                },
                child: const Text('Simple Task'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'intensive_task_no_isolate');
                },
                child: const Text('Intensive Task No Isolate'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'intensive_task_with_compute');
                },
                child: const Text('Intensive Task with Compute'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'intensive_task_with_spawn');
                },
                child: const Text('Intensive Task with Spawn'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'intensive_task_with_run');
                },
                child: const Text('Intensive Task with Run'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
