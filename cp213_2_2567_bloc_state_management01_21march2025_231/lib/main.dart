import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'counter_bloc.dart';
import 'home_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterBloc(),
      child: MaterialApp( 
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: const TextTheme(
            headlineLarge: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            bodyLarge: TextStyle(fontSize: 18), 
          ),
        ),
        home: const HomePage(),
      ),
    );
  }
}
