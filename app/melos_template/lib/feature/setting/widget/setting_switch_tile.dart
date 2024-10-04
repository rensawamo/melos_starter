import 'package:core_repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsSwitchTile extends ConsumerStatefulWidget {
  const SettingsSwitchTile({
    required this.title,
    required this.icon,
    super.key,
  });
  final String title;
  final IconData icon;
  @override
  _SettingsSwitchTileState createState() => _SettingsSwitchTileState();
}

class _SettingsSwitchTileState extends ConsumerState<SettingsSwitchTile> {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = ref.read(themeColorRepositoryProvider.notifier);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      leading: Icon(widget.icon),
      title: Text(widget.title),
      trailing: Switch(
        autofocus: true,
        activeColor: Colors.green,
        value: Theme.of(context).brightness == Brightness.dark,
        onChanged: (bool newValue) {
          themeNotifier.setTheme(
            newValue ? ThemeMode.dark : ThemeMode.light,
          );
        },
      ),
    );
  }
}
