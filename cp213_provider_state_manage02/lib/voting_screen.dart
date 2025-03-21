import 'eligibility_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VotingScreen extends StatefulWidget {
  const VotingScreen({super.key});

  @override
  State<VotingScreen> createState() => _VotingScreenState();
}

class _VotingScreenState extends State<VotingScreen> {
  final _votingAgeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<EligibilityModel>(
        builder:
            (context, eligibilityModelProvider, child) => Container(
              padding: const EdgeInsets.all(16),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Kongpob Laohapipatchai/Provider State Management/21 March 2568/10:35AM',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 15),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            eligibilityModelProvider.isEligible
                                ? Colors.green
                                : Colors.red,
                      ),
                      height: 50,
                      width: 50,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _votingAgeController,
                      decoration: const InputDecoration(
                        hintText: "Enter your age",
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          final int age = int.parse(
                            _votingAgeController.text.trim(),
                          );
                          eligibilityModelProvider.checkEligibility(age);
                        },
                        child: const Text("Check if you can vote"),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Result: ${eligibilityModelProvider.eligibilityMessage}',
                    ),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}
