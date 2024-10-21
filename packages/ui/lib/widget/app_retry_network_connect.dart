import 'package:core_foundation/foundation.dart';
import 'package:core_ui/dialog/app_error_dialog.dart';
import 'package:flutter/material.dart';

class AppRetryNetworkConnectWidget extends StatelessWidget {
  const AppRetryNetworkConnectWidget({
    required this.onRetry,
    super.key,
    this.label = 'Retry',
    this.icon = Icons.refresh,
    this.color = Colors.grey,
  });
  final Future<bool> Function() onRetry;
  final String label;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: InkWell(
          onTap: () async {
            final connectivity = await onRetry();
            if (!connectivity && context.mounted) {
              await AppErrorDialog.showErrorDialog(
                context,
                AppError.networkError(),
              );
            } else {
              logger.d('Internet connection is available & innit');
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: color),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
