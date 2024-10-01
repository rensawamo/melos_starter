import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/use_cases/authentication/fetch_logged_in_type.dart';
import '../../../core/utils/logger.dart';
import 'sign_in_with_anonymously.dart';

part 'start_up.g.dart';

enum StartUpResultType {
  success,
  forcedVersionUpgrade,
}

@riverpod
Future<StartUpResultType> startUp(StartUpRef ref) async {
  /// ログイン状態を確認
  final loginType = ref.watch(fetchLoggedInTypeProvider)();
  logger.info(loginType);

  if (loginType == null) {
    /// ログインしていなければ匿名認証でログインする
    await ref.watch(signInWithAnonymouslyProvider)();
  }


  return StartUpResultType.success;
}
