import 'package:core_di_provider/di_provider.dart';
import 'package:core_foundation/extension/context_extension.dart';
import 'package:core_ui/widget/app_base_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_template/feature/setting/widget/setting_switch_tile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingPage extends ConsumerWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flavor = ref.read(flavorProvider);

    return AppBarFrame(
      hasPrevButton: false,
      title: '設定',
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            height: context.mediaQueryHeight * .25,
            decoration: const BoxDecoration(),
            // child: Image.asset(isDarkMode
            //     ? 'assets/images/national_dark.png'
            //     : 'assets/images/national_flag.png'),
            child: Column(
              children: <Widget>[
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // アプリアイコン情報
                    children: <Widget>[
                      SizedBox(
                        height: context.mediaQueryHeight * .015,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        width: context.mediaQueryHeight * .15,
                        decoration: const BoxDecoration(),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                spreadRadius: 2,
                                blurRadius: 2,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'assets/images/icons/${flavor.name}.png',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'melos_template',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SettingsSwitchTile(
            title: 'ダークモード',
            icon: Icons.brightness_6,
          ),
        ],
      ),
    );
  }
}
