import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher_string.dart';

/// url_launcherで外部接続するユーティリティ
class URLLauncherUtility {
  /// ブラウザで開く
  ///
  /// 接続先[url]、接続できない時の処理[onResume]を設定する.
  static Future<void> openBrowser(
    String url, {
    dynamic Function()? onResume,
  }) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(
        url,
        mode: LaunchMode.externalApplication,
      );
    } else {
      // urlに接続できない場合、処理が指定されていれば実行する
      await onResume?.call();
    }
  }

  /// 電話を発信する
  ///
  /// 電話番号[tel]を設定する.
  static Future<void> call(String tel) async {
    // 電話を発信する
    final uriString = 'tel:$tel';
    if (await canLaunchUrlString(uriString)) {
      await launchUrlString(uriString);
    }
  }

  /// マップを開く
  ///
  /// プラットフォーム[targetPlatform]がiosの場合appleのマップ、それ以外の場合はGoogleMapを表示する
  /// 緯度[latitude]と経度[longitude]を設定する.
  static Future<void> openMap({
    required TargetPlatform targetPlatform,
    double? latitude,
    double? longitude,
  }) async {
    if (targetPlatform == TargetPlatform.iOS) {
      await openBrowser('https://maps.apple.com/?q=$latitude,$longitude');
    } else {
      await openBrowser(
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude',
      );
    }
  }
}
