import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class L10nEn extends L10n {
  L10nEn([String locale = 'en']) : super(locale);

  @override
  String get setting => 'setting';

  @override
  String get home => 'home';

  @override
  String get darkmode => 'darkmode';

  @override
  String get weather => 'weather';
}
