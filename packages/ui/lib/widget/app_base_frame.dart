import 'package:core_ui/widget/appbar_for_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AppBarFrame extends ConsumerStatefulWidget {
  const AppBarFrame({
    required this.body,
    super.key,
    this.init,
    this.title = '',
    this.hasAppbar = true,
    this.appBar,
    this.bottomBar,
    this.backOnTap,
    this.hasPrevButton = true,
    this.shouldRemoveFocus = false,
    this.drawer,
    this.scaffoldKey,
    this.onDrawerChanged,
    this.backButtonKey,
    this.didPopEvent,
    this.canPop = true,
  });

  final String title;
  final PreferredSizeWidget? appBar;
  final Widget body;
  final bool hasAppbar;
  final Widget? bottomBar;
  final void Function()? backOnTap;
  final bool hasPrevButton;
  final bool shouldRemoveFocus;
  final Widget? drawer;
  final void Function()? init;
  final GlobalKey? scaffoldKey;
  final void Function({required bool isOpen})? onDrawerChanged;
  final GlobalKey? backButtonKey;
  final void Function()? didPopEvent;
  final bool canPop;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppBaseFrameState();
}

class _AppBaseFrameState extends ConsumerState<AppBarFrame> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        widget.init?.call();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _baseScaffold(context);
  }

  Widget _baseScaffold(BuildContext context) {
    return PopScope(
      canPop: widget.canPop,
      child: Scaffold(
        key: widget.scaffoldKey,
        drawer: widget.drawer,
        onDrawerChanged: widget.onDrawerChanged != null
            ? (isOpen) => widget.onDrawerChanged!(isOpen: isOpen)
            : null,
        drawerEnableOpenDragGesture: false,
        appBar: widget.hasAppbar == false
            ? null
            : widget.appBar ??
                AppBarForScreen(
                  titleText: widget.title,
                  leftWidget: widget.hasPrevButton
                      ? _prevButton(context)
                      : const SizedBox(),
                ),
        body: SafeArea(child: _buildBody(context)),
        bottomNavigationBar: widget.bottomBar != null
            ? SafeArea(child: widget.bottomBar!)
            : null,
      ),
    );
  }

  Widget _prevButton(BuildContext context) {
    if (!context.canPop()) {
      return const SizedBox();
    }
    return IconButton(
      key: widget.backButtonKey,
      icon: widget.hasPrevButton
          ? const Icon(Icons.arrow_back_ios)
          : const SizedBox(),
      onPressed: () {
        if (widget.backOnTap != null) {
          widget.backOnTap!();
        } else {
          if (context.canPop()) {
            context.pop();
          }
        }
      },
    );
  }

  Widget _buildBody(BuildContext context) {
    return widget.shouldRemoveFocus
        ? GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: widget.body,
          )
        : widget.body;
  }
}
