import 'package:core_foundation/foundation.dart';
import 'package:core_service/service.dart';
import 'package:core_ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:melos_template/core/foundation/extension/l10_extension.dart';
import 'package:melos_template/core/router/data/app_route_data.dart';
import 'package:melos_template/core/router/data/e2e_sample/e2e_sample_route_data.dart';
import 'package:melos_template/core/router/data/setting/setting_route_data.dart';
import 'package:melos_template/core/router/data/weature/weature_route_data.dart';
import 'package:melos_template/feature/home/home_viewmodel.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(homeViewmodelProvider.notifier);
    final state = ref.watch(homeViewmodelProvider);
    final notificationService = ref.read(notificationServiceProvider);

    return AppBarFrame(
      hasPrevButton: false,
      title: context.l10n.home,
      rightWidget: IconButton(
        icon: const Icon(Icons.settings),
        onPressed: () {
          const SettingPageData().push<void>(context);
        },
      ),
      init: () async {
        await vm.checkInternetConnection().then((bool isConnected) {
          if (!isConnected && context.mounted) {
            AppErrorDialog.showErrorDialog(
              context,
              AppError.networkError(),
            );
          }
        });
      },
      body: GestureDetector(
        onTap: () {
          context.hideKeyboard();
        },
        child: !state.isInternetConnected
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
                          notificationService.showNotification(
                            title: 'Hello!',
                            body: 'This is a notification from the app!',
                          );
                          const E2ESamplePageData().push<void>(context);
                        },
                        icon: const Icon(
                          Icons.sunny,
                          color: Colors.red,
                          size: 24,
                        ),
                        label: const Text(
                          'E2E Sample',
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
      ),
    );
  }
}
