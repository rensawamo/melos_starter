import 'package:core_foundation/extension/context_extension.dart';
import 'package:core_ui/widget/app_base_frame.dart';
import 'package:feature_setting/widget/setting_switch_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return AppBaseFrame(
        screenContext: context,
        hasPrevButton: false,
        title: '設定',
        body: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              height: context.mediaQueryHeight * .25,
              decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
              ),
              // child: Image.asset(isDarkMode
              //     ? 'assets/images/national_dark.png'
              //     : 'assets/images/national_flag.png'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SettingsSwitchTile(
                    title: 'ダークモード',
                    icon: Icons.brightness_6,
                  ),
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
                          decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
                          ),
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
                          ),
                        ),
                        SizedBox(
                          width: context.mediaQueryWidth * .25,
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'YOUR APP',
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

            const SizedBox(height: 3),
            // 退会処理
            TextButton(
              onPressed: () {},
              child: Text(
                '退会について',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
