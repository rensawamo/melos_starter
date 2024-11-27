import 'package:core_ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:melos_template/core/foundation/extension/l10_extension.dart';
import 'package:melos_template/feature/weature/notifier/weather_notifier.dart';
import 'package:melos_template/feature/weature/ui/component/weather_detail.dart';

class WeatherPage extends ConsumerWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = ref.watch(textControllerProvider(0));
    final asyncData = ref.watch(weatherNotifierProvider(textController.text));

    return Scaffold(
      appBar: CustomAppBar(
        title: context.l10n.weather,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TextField for city input
            TextField(
              controller: textController,
              decoration: InputDecoration(
                labelText: 'Enter city',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Search Button
            ElevatedButton.icon(
              onPressed: () {
                if (textController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a city name')),
                  );
                  return;
                }
                ref
                    .read(weatherNotifierProvider(textController.text).notifier)
                    .updateState(textController.text);
              },
              icon: const Icon(Icons.search, color: Colors.white),
              label: const Text(
                'Search',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 24,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                elevation: 5,
              ),
            ),
            const SizedBox(height: 20),

            // Async Data Handling
            asyncData.when(
              data: (state) {
                if (state.weatherData == null) {
                  return const Center(
                    child: Text('No data available'),
                  );
                }
                return WeatherDetails(state: state);
              },
              loading: () => const Center(child: AppCircleIndicator()),
              error: (error, stack) => AppRetryNetworkConnectWidget(
                error: error,
                onRefresh: () {
                  ref.invalidate(weatherNotifierProvider(textController.text));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
