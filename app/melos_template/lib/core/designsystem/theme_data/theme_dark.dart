import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData themeDark() {
  const primary = Color.fromARGB(255, 56, 106, 31);

  // テーマの基本設定
  // https://zenn.dev/gen_kk/articles/cc538ffa392922
  final base = ThemeData(
    /// アプリのフォントを指定
    fontFamily: GoogleFonts.kiwiMaru().fontFamily,
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      // ライトテーマの指定
      brightness: Brightness.dark,
      //   必須プロパティ
      //  この色を元にして他の色が生成される
      seedColor: primary,
      // プライマリカラー(一番よく使う色)
      // カラーが指定されてない場合、defaultのテキストカラーが primaryで設定されているケースが多い
      primary: primary,
      // appbarなどの 背景色
      surface: primary,
      // errorは図の通り本来は赤色だが、今回は青色に設定する例
      error: Colors.blue,
      // cardなどの 背景色
      surfaceContainerLow: Colors.grey,
    ),

    // テキストスタイルのを統一する
    textTheme: const TextTheme(
      // https://flutter.salon/widget/textstyle/
      // 一環したテキストスタイルを定義す

      /// Middle size of the body styles.
      ///
      /// Body styles are used for longer passages of text.
      ///
      /// The default text style for [Material].
      // final TextStyle? bodyMedium;

      // デフォルトのテキストスタイル
      bodyMedium: TextStyle(fontSize: 18),
      // ヘッドラインのテキストスタイル
      headlineMedium: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
    ),
  );

  // テーマのカスタマイズ
  // 特定のウィジェットに適応されるテーマを設定する
  return base.copyWith(
    // ElevatedButtonのテーマを設定する例
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
    ),
    // floatingActionButtonのテーマを設定する例
    floatingActionButtonTheme: base.floatingActionButtonTheme.copyWith(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    ),

    // etc 要件に応じて追加可能
    // https://qiita.com/najeira/items/dfa20d0104bd4457bc9a
    // ios風の遷移アニメーションを設定
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );
}
