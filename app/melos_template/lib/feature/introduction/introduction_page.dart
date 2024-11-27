import 'package:core_di_provider/di_provider.dart';
import 'package:core_foundation/foundation.dart';
import 'package:core_ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:melos_template/core/foundation/constant/e2e_key.dart';
import 'package:melos_template/core/router/data/app_route_data.dart';

class IntroductionPage extends ConsumerWidget {
  const IntroductionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBarFrame(
      hasAppbar: false,
      init: () {
        final sharedPreferences = ref.read(sharedPreferencesProvider);
        const key = AppSharedPreferenceKey.appIsIntroDoneKey;
        sharedPreferences.setBool(key.name, true);
      },
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            title: 'Welcome to melos template!',
            body: 'Page1',
            image: Image.asset(
              height: 150,
              width: 150,
              'assets/images/introduction/aisome_company_color.png',
            ),
          ),
          PageViewModel(
            title: 'Lets use this application as a reference!',
            body: 'Page2',
            image: Image.asset(
              'assets/images/introduction/coffee_color.png',
            ),
          ),
          PageViewModel(
            title: 'I will be using Riverpod a lot!',
            body: 'Page3!',
            image: Image.asset(
              'assets/images/introduction/many_documents_color.png',
            ),
          ),
        ],
        onDone: () async {
          const HomePageData().go(context);
        },
        showBackButton: true,
        next: Icon(
          Icons.arrow_forward_ios,
          key: Key(E2eKey.introNextKey.name),
        ),
        back: const Icon(Icons.arrow_back_ios),
        done: Text(
          'OK!',
          style: const TextStyle(fontWeight: FontWeight.w600),
          key: Key(E2eKey.introDoneKey.name),
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
