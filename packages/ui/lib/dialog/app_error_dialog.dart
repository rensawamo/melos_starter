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
      default:
        await _showGenericErrorDialog(context);
        break;
    }
  }

  /// ネットワークエラーダイアログ表示
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

  //// 以下は 必要なエラーdialogを増やしていく
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
