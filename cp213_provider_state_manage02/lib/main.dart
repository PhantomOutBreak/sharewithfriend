import 'eligibility_model.dart';
import 'voting_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ChangeNotifierProvider<EligibilityModel>(
            create: (_) => EligibilityModel(),
            child: VotingScreen(),
          ),
        ),
      ),
    );
  }
}
