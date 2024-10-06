import 'package:core_foundation/foundation.dart';
import 'package:core_ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/router/data/app_route_data.dart';
import 'package:flutter_app_template/core/router/data/weature/weature_route_data.dart';
import 'package:flutter_app_template/core/util/l10_extension.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final fifteenAgo = DateTime.now().subtract(const Duration(minutes: 15));
    // yesterday
    final yesterday = DateTime.now().subtract(const Duration(days: 1));

    final oneHourAgo = now.subtract(const Duration(hours: 1));

    return AppBarFrame(
      shouldRemoveFocus: true,
      title: context.l10n.setting,
      init: () async {
        timeago.setDefaultLocale(Localizations.localeOf(context).languageCode);
      },
      body: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Current Time: ${now.format()}'),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  // Navigate to another route or perform another action
                  const WeatureRouteData().go(context);
                },
                child: const Text(
                  'Weature',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                '1 hour ago (en_short): ${now.createTimeAgoString(
                  yesterday,
                )}',
              ),
              InkWell(
                onTap: () {
                  final now = DateTime.now();
                  final formattedDate =
                      now.format(); // Use DateTimeExtension to format date
                  final formattedLocaleDate = now.format(
                    'yyyy/MM/dd HH:mm:ss',
                    'ja_JP',
                  ); // Example with locale
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Current Date & Time'),
                        content: Text(
                          'Formatted: $formattedDate\nLocale (ja_JP): $formattedLocaleDate',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text(
                  'Show Date & Time',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
