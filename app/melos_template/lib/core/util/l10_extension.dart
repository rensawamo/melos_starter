import 'package:flutter/material.dart';
import 'package:flutter_app_template/l10n/l10n.dart';

extension L10Extension on BuildContext {
  L10n get l10n => L10n.of(this)!;
}
