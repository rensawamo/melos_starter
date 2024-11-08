import '../../common.dart';
import '../../shared/base.dart';
import '../../shared/common_operation.dart';

void main() {
  patrol(
    'counter state is the same after going to Home and switching apps',
    ($) async {
      await createApp($);

      await $.introSkip();

      await $.expectAppBarText('home');

      await $.tapByText('E2E Sample');
      await $.expectAppBarText('E2E Sample');

      await $.tapByText('Simulateion TextField Page');
      await $.expectAppBarText('Simulation TextField Page');

      // テキストフィールドに文字を入力
      await $.inputTextField('Hello, Riverpod!');

      // Submitボタンをタップ
      await $.tapByText('Submit');

      // 入力したテキストが表示されていることを確認
      expect(find.text('Submitted Text: Hello, Riverpod!'), findsOneWidget);
    },
  );
}
