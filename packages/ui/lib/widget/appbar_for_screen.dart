import 'package:core_foundation/extension/context_extension.dart';
import 'package:flutter/material.dart';

class AppBarForScreen extends StatelessWidget implements PreferredSizeWidget {
  const AppBarForScreen({
    required this.leftWidget,
    super.key,
    this.titleText = '',
    this.appbar,
    this.rightWidget,
  });

  final String titleText;

  final Widget leftWidget;
  final Widget? rightWidget;

  final PreferredSizeWidget? appbar;

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      centerTitle: true,
      titleSpacing: 0,
      title: Column(
        children: [
          Container(
            width: context.mediaQueryWidth,
            height: 56,
            padding: const EdgeInsets.symmetric(
              vertical: 6,
              horizontal: 4,
            ),
            child: Stack(
              alignment: AlignmentDirectional.centerStart,
              children: [
                leftWidget,
                Center(
                  child: _titleContents(context),
                ),
                if (rightWidget != null)
                  Positioned(
                    right: 0,
                    child: rightWidget!,
                  ),
              ],
            ),
          ),
          const Divider(
            height: 0,
            thickness: 0.5,
          ),
        ],
      ),
    );
  }

  Widget _titleContents(BuildContext context) {
    return Text(
      titleText,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}
