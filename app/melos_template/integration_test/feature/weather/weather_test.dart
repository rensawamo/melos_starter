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

      await $.tapByText('Get to weather info (REST API)');
      await $.expectAppBarText('weather');

      await $.inputTextField('New York');

      await $.tapByText('Search');
      expect($('Details'), findsOneWidget);
    },
  );
}
