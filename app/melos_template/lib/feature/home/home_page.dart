import 'package:core_foundation/foundation.dart';
import 'package:core_ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:melos_template/core/foundation/extension/l10_extension.dart';
import 'package:melos_template/core/router/data/app_route_data.dart';
import 'package:melos_template/core/router/data/weature/weature_route_data.dart';
import 'package:melos_template/feature/home/home_viewmodel.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(homeViewmodelProvider.notifier);
    final state = ref.watch(homeViewmodelProvider);

    return AppBarFrame(
      hasPrevButton: false,
      title: context.l10n.home,
      init: () async {
        await vm.checkInternetConnection().then((bool isConnected) {
          if (context.mounted) {
            logger.d(context.locale);
            timeago.setDefaultLocale('en');
          }
          if (!isConnected && context.mounted) {
            AppErrorDialog.showErrorDialog(
              context,
              AppError.networkError(),
            );
          }
        });
      },
      body: !state.isInternetConnected
          ? AppRetryNetworkConnectWidget(
              onRetry: vm.checkInternetConnection,
            )
          : Center(
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
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        const WeatureRouteData().push<void>(context);
                      },
                      icon: const Icon(
                        Icons.sunny,
                        color: Colors.red,
                        size: 24,
                      ),
                      label: const Text(
                        'Get to weather info (REST API)',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
    );
  }
}
