import 'package:core_ui/widget/appbar_for_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppBaseFrame extends ConsumerStatefulWidget {
  /// [title]AppBarに表示されるタイトルテキストを設定
  /// [initFrame]初期表示完了時のイベント
  /// [appBar]AppBarForScreen以外のアプリバーを使用する場合設定する
  /// [body]画面本体のWidgetを設定
  /// [bottomBar]ボトムバーを使用する場合設定する
  /// [backOnTap]戻るボタンタップ時にセットされたメソッドが実行される。何もセットされていない場合は遷移元へ戻る
  /// [hasPrevButton]falseの場合戻るボタンが表示されない。戻り先がない場合は値に関係なく表示されない
  /// [shouldRemoveFocus]画面押下時にフォーカスアウトを実行させるかどうか。デフォルトはfalse
  /// [onDrawerChanged]ドロワーが開いたり閉じたりしたときのイベント
  /// [backButtonKey]戻るボタンにセットするWidget Key
  /// [didPopEvent]didPopでハンドリングできる画面再表示イベント
  const AppBaseFrame({
    required this.body,
    super.key,
    this.initFrame,
    this.title = '',
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
  });

  /// AppBarForScreenのtitleTextプロパティにセットされる値
  final String title;

  /// AppBarForScreen以外に設定するアプリバー
  final PreferredSizeWidget? appBar;

  /// 画面本体
  final Widget body;

  /// ボトムバー
  final Widget? bottomBar;

  /// 戻るボタンタップイベント
  final void Function()? backOnTap;

  /// 左上に戻るボタンを表示させるかどうか
  final bool hasPrevButton;

  /// 画面タップ時にフォーカスアウトさせるかどうか
  final bool shouldRemoveFocus;

  /// ドロワー（サイドメニュー）
  final Widget? drawer;

  /// 画面のBuild完了後に呼び出されるFunction。引数にBuiildContextとWidgetReferenceが渡される
  final void Function()? initFrame;

  /// ScaffoldKey。
  /// ドロワーを開きたい場合などに設定する必要がある
  final GlobalKey? scaffoldKey;

  /// ドロワーが開いたり閉じたりしたときに呼び出されるFunction 引数としてドロワーの状態(開閉)が渡される
  final void Function(bool)? onDrawerChanged;

  /// 戻るボタンのGlobalKey
  final GlobalKey? backButtonKey;

  final void Function()? didPopEvent;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppBaseFrameState();
}

class _AppBaseFrameState extends ConsumerState<AppBaseFrame> {
  /// state初期化
  @override
  void initState() {
    // 画面のbuild完了後に１度だけ呼び出される処理を設定
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        if (widget.initFrame != null) {
          widget.initFrame!();
        }
      },
    );
    super.initState();
  }

  // 画面破棄時の処理
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  /// Widgetを生成
  @override
  Widget build(BuildContext context) {
    if (widget.shouldRemoveFocus) {
      // 画面全体にTapイベントを持たせる
      return GestureDetector(
        // タップ時にフォーカスを外す
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: _baseScaffold(context),
      );
    } else {
      return _baseScaffold(context);
    }
  }

  /// 画面共通のScaffold Widget
  Widget _baseScaffold(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        key: widget.scaffoldKey,
        // backgroundColor: _colorSet1.color(widget.mode),
        drawer: widget.drawer,
        onDrawerChanged: widget.onDrawerChanged,
        drawerEnableOpenDragGesture: false,
        appBar: widget.appBar ??
            AppBarForScreen(
              titleText: widget.title,
              leftWidget: widget.hasPrevButton
                  ? _prevButton(context)
                  : const SizedBox(),
            ),
        body: SafeArea(child: widget.body),
        bottomNavigationBar: widget.bottomBar != null
            ? SafeArea(child: widget.bottomBar!)
            : null,
      ),
    );
  }

  /// 戻るボタンの生成
  Widget _prevButton(BuildContext context) {
    if (!widget.hasPrevButton) {
      return const SizedBox();
    }
    return InkWell(
      highlightColor: Colors.transparent,
      onTap: widget.backOnTap,
      child: const SizedBox(
        width: 44,
        height: 44,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Icon(
            Icons.arrow_back_ios,
            size: 24,
          ),
        ),
      ),
    );
  }
}
