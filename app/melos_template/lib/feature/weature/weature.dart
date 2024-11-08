import 'package:core_foundation/foundation.dart';
import 'package:core_ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:melos_template/core/foundation/extension/l10_extension.dart';
import 'package:melos_template/feature/weature/weature_viewmodel.dart';

class WeaturePage extends ConsumerWidget {
  const WeaturePage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(weatherViewmodelProvider.notifier);
    final state = ref.watch(weatherViewmodelProvider);
    final textController = ref.watch(textControllerProvider(0));

    return AppBarFrame(
      shouldRemoveFocus: true,
      title: context.l10n.weather,
      init: () async {
        textController.text = 'Tokyo';
        await vm.call(textController.text).then((AppError? error) {
          if (error != null && context.mounted) {
            AppErrorDialog.showErrorDialog(
              context,
              error,
            );
          }
        });
      },
      body: state.isLoading
          ? const AppCircleIndicator()
          : state.weatherData == null
              ? const AppDataNotAvailableWidget()
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        style: const TextStyle(color: Colors.black),
                        controller: textController,
                        decoration: InputDecoration(
                          labelText: 'Enter city',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () {
                          vm.call(textController.text).then((AppError? error) {
                            if (error != null && context.mounted) {
                              AppErrorDialog.showErrorDialog(
                                context,
                                error,
                              );
                            }
                          });
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
                      SizedBox(height: context.mediaQueryHeight * .05),
                      Text(
                        'Weather in ${state.weatherData!.name}',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      WeatherInfoCard(
                        iconCode: state.weatherData!.weather[0].icon,
                        description: state.weatherData!.weather[0].description,
                        temperature: state.weatherData!.main.temp - 273.15,
                        feelsLike: state.weatherData!.main.feels_like - 273.15,
                        windSpeed: state.weatherData!.wind.speed,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Details',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 10),
                      DetailList(
                        humidity: state.weatherData!.main.humidity,
                        pressure: state.weatherData!.main.pressure,
                      ),
                    ],
                  ),
                ),
    );
  }
}

class WeatherInfoCard extends StatelessWidget {
  const WeatherInfoCard({
    required this.iconCode,
    required this.description,
    required this.temperature,
    required this.feelsLike,
    required this.windSpeed,
    super.key,
  });
  final String iconCode;
  final String description;
  final double temperature;
  final double feelsLike;
  final double windSpeed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.network(
          'http://openweathermap.org/img/wn/$iconCode@2x.png',
          height: context.mediaQueryHeight * .1,
          width: context.mediaQueryWidth * .1,
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              'Temperature: ${temperature.toStringAsFixed(1)}°C',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'Feels like: ${feelsLike.toStringAsFixed(1)}°C',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'Wind Speed: ${windSpeed.toStringAsFixed(1)} m/s',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ],
    );
  }
}

class DetailList extends StatelessWidget {
  const DetailList({
    required this.humidity,
    required this.pressure,
    super.key,
  });
  final int humidity;
  final int pressure;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.opacity),
          title: Text('Humidity: $humidity%'),
        ),
        ListTile(
          leading: const Icon(Icons.compress),
          title: Text('Pressure: $pressure hPa'),
        ),
        const ListTile(
          leading: Icon(Icons.visibility),
          title: Text('Visibility: ${2 / 1000} km'),
        ),
      ],
    );
  }
}
