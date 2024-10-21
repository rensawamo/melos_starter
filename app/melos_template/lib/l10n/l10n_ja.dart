import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class L10nJa extends L10n {
  L10nJa([String locale = 'ja']) : super(locale);

  @override
  String get setting => '設定';

  @override
  String get home => 'ホーム';

  @override
  String get darkmode => 'ダークモード';

  @override
  String get weather => '天気';
}
