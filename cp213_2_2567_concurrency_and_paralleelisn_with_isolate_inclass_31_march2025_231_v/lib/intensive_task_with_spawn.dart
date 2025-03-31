import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:isolate';

class IntensiveTaskWithSpawn extends StatefulWidget {
  const IntensiveTaskWithSpawn({super.key});

  @override
  State<IntensiveTaskWithSpawn> createState() => _IntensiveTaskWithSpawnState();
}

class _IntensiveTaskWithSpawnState extends State<IntensiveTaskWithSpawn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Isolate Examples: Intensive Task with Spawn'),
        backgroundColor: Colors.greenAccent,
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
                    final primes = await computeInIsolate(200000);
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
}


Future<List<int>> computeInIsolate(int num) async {
  final receivePort = ReceivePort();
  await Isolate.spawn(findPrimesIsolate, receivePort.sendPort);
  final sendPort = await receivePort.first as SendPort;

  final answerPort = ReceivePort();
  sendPort.send([num, answerPort.sendPort]);

  return await answerPort.first as List<int>;
}


void findPrimesIsolate(SendPort sendPort) {
  final receivePort = ReceivePort();
  sendPort.send(receivePort.sendPort);

  receivePort.listen((message) {
    final int num = message[0];
    final SendPort replyPort = message[1];

    final primes = getPrimes(num);
    replyPort.send(primes);
  });
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
  return primes;
}

Future<double> getSumFromOneToNum(int num) async {
  final sum = num * (num + 1) / 2;
  return sum;
}
