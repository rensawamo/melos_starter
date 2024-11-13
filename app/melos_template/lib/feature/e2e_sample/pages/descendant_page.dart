import 'package:core_ui/widget/app_base_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DescendantPage extends ConsumerStatefulWidget {
  const DescendantPage({super.key});

  @override
  DescendantPageState createState() => DescendantPageState();
}

class DescendantPageState extends ConsumerState<DescendantPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBarFrame(
      title: 'Descendant Page',
      body: Center(
        child: Container(
          width: 300,
          height: 250,
          color: Colors.blue,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Text(
                      'Counter: $_counter',
                      style: const TextStyle(fontSize: 24),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _incrementCounter,
                    child: const Text('+'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _decrementCounter,
                    child: const Text('-'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
