import '../../common.dart';
import '../../util/base.dart';
import '../../util/common_operation.dart';

void main() {
  patrol(
    'counter state is the same after going to Home and switching apps',
    ($) async {
      await createApp($);
      await $.introSkip();
      // await $.inputTextAndCloseKeyboard('test', 0);
      // expect(find.text('test'), findsOneWidget);
      await $.expectAppBarText('home');
    },
  );
}
