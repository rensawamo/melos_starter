import 'package:core_foundation/foundation.dart';
import 'package:core_router/router.dart';
import 'package:core_ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class {{page_name.pascalCase()}}Page extends ConsumerWidget {
  const {{page_name.pascalCase()}}Page({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch({{page_name.camelCase()}}ViewmodelProvider.notifier);
    final state = ref.watch({{page_name.camelCase()}}ViewmodelProvider);
    final appErrorDialog = AppErrorDialog();

    return AppBaseFrame(
      hasPrevButton: true,
      shouldRemoveFocus: true,
      title: '',
      initFrame: () async {
        await vm.call().then((AppError? error) {
          if (error != null) {
            appErrorDialog.showErrorDialog(context, error);
          }
        });
      },
      body: state.isLoading
          ? const AppCircleIndicator()
          : Column(
              children: [ 
              ],
            ),
    );
  }
}