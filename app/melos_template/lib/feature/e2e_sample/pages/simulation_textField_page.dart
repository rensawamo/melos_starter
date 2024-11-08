import 'package:core_foundation/foundation.dart';
import 'package:core_ui/widget/app_base_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SimulationTextFieldPage extends ConsumerStatefulWidget {
  const SimulationTextFieldPage({super.key});

  @override
  SimulationTextFieldPageState createState() => SimulationTextFieldPageState();
}

class SimulationTextFieldPageState
    extends ConsumerState<SimulationTextFieldPage> {
  String submittedText = '';
  @override
  Widget build(BuildContext context) {
    final textController = ref.watch(textControllerProvider(0));

    return AppBarFrame(
      title: 'Simulation TextField Page',
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          context.hideKeyboard();
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: textController,
                decoration: const InputDecoration(
                  labelText: 'Enter some text',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    submittedText = textController.text;
                  });
                  context.hideKeyboard();
                },
                child: const Text('Submit'),
              ),
              const SizedBox(height: 24),
              Text(
                'Submitted Text: $submittedText',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
