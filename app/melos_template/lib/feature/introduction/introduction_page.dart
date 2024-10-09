import 'package:core_di_provider/di_provider.dart';
import 'package:core_ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/router/data/app_route_data.dart';
import 'package:flutter_app_template/core/router/data/home/home_route_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroductionPage extends ConsumerWidget {
  const IntroductionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBarFrame(
      hasAppbar: false,
      init: () {
        // I only call the first one.
        final sharedPreferences = ref.read(sharedPreferencesProvider);
        const key = 'isFirstLaunch';
        sharedPreferences.setBool(key, true);
      },
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            title: 'アプリ紹介のページへ\nようこそ!',
            body: '１ページ目だよ！',
            image: Image.asset(
              'assets/images/introduction/aisome_company_color.png',
            ),
          ),
          PageViewModel(
            title: 'アプリの使い方を説明すると\nユーザーにとって親切だよ!',
            body: '2ページ目だよ!',
            image: Image.asset(
              'assets/images/introduction/aisome_company_color.png',
            ),
          ),
          PageViewModel(
            title: '紹介ページを設けることで\n簡単にアプリをリッチにできるよ!',
            body: '3ページ目だよ!',
            image: Image.asset(
              'assets/images/introduction/aisome_company_color.png',
            ),
          ),
        ],
        onDone: () async {
          // 必要に応じてRiverpodのプロバイダを使用できます
          // 例: ref.read(yourProvider);
          const HomePageData().go(context);
        },
        showBackButton: true,
        next: const Icon(Icons.arrow_forward_ios),
        back: const Icon(Icons.arrow_back_ios),
        done: const Text(
          'OK!',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        dotsDecorator: DotsDecorator(
          size: const Size.square(10),
          activeSize: const Size(20, 10),
          activeColor: Colors.blue,
          color: Colors.black26,
          spacing: const EdgeInsets.symmetric(horizontal: 3),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
    );
  }
}
