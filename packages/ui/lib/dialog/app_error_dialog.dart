import 'package:core_foundation/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppErrorDialog {
  AppErrorDialog();

  static Future<void> showErrorDialog(
    BuildContext context,
    AppError error,
  ) async {
    switch (error.type) {
      case AppErrorType.networkError:
        await _showNetworkErrorDialog(
          context,
        );
      case AppErrorType.unknownError:
        await _unknownErrorDialog(context);

      default:
        await _showGenericErrorDialog(context);
        break;
    }
  }


  // unknown error
  static Future<void> _unknownErrorDialog(BuildContext context) async {
    if (!context.mounted) {
      logger.d('context is not mounted');
      return;
    }
    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Unknown error occurred.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('閉じる'),
            ),
          ],
        );
      },
    );
  }


  static Future<void> _showNetworkErrorDialog(BuildContext context) async {
    if (!context.mounted) {
      logger.d('context is not mounted');
      return;
    }
    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('通信エラー'),
          content: const Text('ネットワークに接続できません。再試行してください。'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('閉じる'),
            ),
          ],
        );
      },
    );
  }

  static Future<void> _showGenericErrorDialog(BuildContext context) async {
    if (!context.mounted) {
      logger.d('context is not mounted');
      return;
    }
    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('閉じる'),
            ),
          ],
        );
      },
    );
  }
}
