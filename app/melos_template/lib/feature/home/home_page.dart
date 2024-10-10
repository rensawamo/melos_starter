import 'package:core_foundation/foundation.dart';
import 'package:core_service/firebase_messaging/firebase_messaging_service.dart';
import 'package:core_ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/foundation/extension/l10_extension.dart';
import 'package:flutter_app_template/core/router/data/app_route_data.dart';
import 'package:flutter_app_template/core/router/data/weature/weature_route_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firebaseMessagingService =
        ref.watch(firebaseMessagingServiceProvider);

    return AppBarFrame(
      title: context.l10n.setting,
      init: () {
        firebaseMessagingService.messageStream.listen((message) {
          logger.d('Received a message: ${message.notification?.title}');
        });
        firebaseMessagingService.openedAppStream.listen((message) {
          logger.d('Opened app from a message: ${message.notification?.title}');
        });
        timeago.setDefaultLocale(context.locale);
      },
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome to the App!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Get started by exploring the features below.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),
              InkWell(
                onTap: () {
                  const WeatureRouteData().push<void>(context);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Go to Weature',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Powered by Flutter',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
