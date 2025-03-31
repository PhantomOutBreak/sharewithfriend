import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart'; 

class IntensiveTaskNoIsolate extends StatefulWidget {
  const IntensiveTaskNoIsolate({super.key});

  @override
  State<IntensiveTaskNoIsolate> createState() => _IntensiveTaskNoIsolateState();
}

class _IntensiveTaskNoIsolateState extends State<IntensiveTaskNoIsolate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Isolate Examples: Intensive Task No Isolate'),
        backgroundColor: Colors.yellowAccent,
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
                    final primes = await getPrimes(200000);
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

  Future<List<int>> getPrimes(int num) async {
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
    debugPrint("No. Of Primes: ${primes.length}");
    return primes;
  }

  Future<double> getSumFromOneToNum(int num) async {
    final sum = num * (num + 1) / 2;
    debugPrint("Sum: $sum");
    return sum;
  }
}
