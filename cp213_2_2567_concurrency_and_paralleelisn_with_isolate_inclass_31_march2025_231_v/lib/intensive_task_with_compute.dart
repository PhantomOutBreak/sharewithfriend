import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/foundation.dart'; 

class IntensiveTaskWithCompute extends StatefulWidget {
  const IntensiveTaskWithCompute({super.key});

  @override
  State<IntensiveTaskWithCompute> createState() =>
      _IntensiveTaskWithComputeState();
}

class _IntensiveTaskWithComputeState extends State<IntensiveTaskWithCompute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Isolate Examples: Intensive Task with Compute'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const CircularProgressIndicator(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final sum = await getSumFromOneToNum(200000);
                    Fluttertoast.showToast(msg: "Sum: $sum");
                  },
                  child: const Text('Simple Task'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () async {
                    final primes = await compute(getPrimes, 200000); 
                    Fluttertoast.showToast(
                      msg: "No. of primes: ${primes.length}",
                    );
                  },
                  child: const Text('Intensive Task'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<double> getSumFromOneToNum(int num) async {
    final sum = num * (num + 1) / 2;
    log("Sum: $sum");
    return sum;
  }
}

List<int> getPrimes(int num) {
  bool isPrime(int n) {
    if (n <= 1) return false;
    for (var i = 2; i * i <= n; i++) {
      if (n % i == 0) return false;
    }
    return true;
  }

  final List<int> primes = [];
  for (var i = 0; i < num; i++) {
    if (isPrime(i)) {
      primes.add(i);
    }
  }
  log("No. Of Primes: ${primes.length}");
  return primes;
}
