# [FeatureFirst] flutter_app_template

動作確認済み
[clone by this repository](https://github.com/rensawamo/flutter_app_template/tree/main/feature_first)

Flutter + Firebase アプリのスターターキット、新規アプリ開発はこのテンプレートをベースに始める。

| カテゴリ       | 説明                            |
|------------|-------------------------------|
| 状態管理と DI   | flutter_hooks, hooks_riverpod |
| データモデル     | freezed, equatable          |
| クラウド DB    | cloud_firestore               |
| ローカル DB    | shared_preferences            |
| API クライアント | retrofit                      |
| 画面遷移       | go_router                     |
| Flavor設定       | --dart-define  |
| テスト | flutter_test, integration_test, mockito |

## 画面構成

- タブ 1
  - Hero アニメーションによるモーダル表示
  - SharedPreferences を用いた カウンター画面
  - Firestore を用いた カウンター画面
  - メールアドレス認証のサンプル
  - タイムラインのサンプル
- タブ 2
  - GithubApi を用いた Github Users の一覧画面
- タブ 3
  - Firestore を用いた Memo データ一覧と CRUD
    - データの追加、更新、削除
    - データ一覧の Pull-to-refresh
    - データ一覧の Infinite Scroll Pagination
- タブ 4
  - 設定画面
    - プロフィール 「名前」「誕生日」「画像」の表示と保存
    - アプリ名、パッケージ名、バージョンを表示
    - 株式会社 Never の URL を WebView で表示
    - ログアウト

![screenshot_home](./doc/images/screenshot_home.png)
![screenshot_github](./doc/images/screenshot_github.png)
![screenshot_memo](./doc/images/screenshot_memo.png)
![screenshot_setting](./doc/images/screenshot_setting.png)

![screenshot_sign_in](./doc/images/screenshot_sign_in.png)
![screenshot_sign_up](./doc/images/screenshot_sign_up.png)
![screenshot_change_password](./doc/images/screenshot_change_password.png)
![screenshot_timeline](./doc/images/screenshot_timeline.png)

## 実装済み

- iOS14、Android7 以上で動作
- DDDライクなFeatureFirst構成で設計
- Firebase を利用 (FirebaseAuth, Firestore, Functions, FirebaseAnalytics, FirebaseCrashlytics)
- retrofit を用いた サンプルコード
- 画面遷移は go_router（ShellRouteは未対応）
- ボトムナビゲーション構成のサンプル画面
- 画像選択・保存
- カメラ、画像のパーミッション設定
- 起動時に匿名認証でログイン
- ダークモード対応
- デバイス向きは縦固定
- 静的解析導入
- Android/iOS の Flavor 設定
- iOS 日本語デフォルト
- MethodChannelとEventChannelのサンプルコード
  - AndroidはTalkback、iOSはVoiceOverの設定状態の表示
- その他アプリに必要なライブラリを設定済み
- fvm, asdf
- Unit tests（オフラインテスト）
- Widget tests（オフラインテスト）
- Integration tests（E2Eテスト）

## やっていないこと

- Android/iOS ローカル通知とプッシュ通知の設定
- Android の keystore の設定（debug, release）
- ローカライズ対応
- dartdoc
- fastlane
- テストでスクリーンショット撮影

## 設計指針

### ディレクトリ構成

- [lib/](./lib)
  - [core/](./lib/core)
    - [converters/](./lib/core/converters)
    - [custom_hooks/](./lib/core/custom_hooks)
    - [entities/](./lib/core/entities)
    - [exceptions/](./lib/core/exceptions)
    - [extensions/](./lib/core/extensions)
    - [repositories/](./lib/core/repositories)
    - [res/](./lib/core/res)
    - [router/](./lib/core/router)
    - [use_cases/](./lib/core/use_cases)
    - [utils/](./lib/core/utils)
    - [widgets/](./lib/core/widgets)
  - [features/](./lib/features)
    - [app_wrapper/](./lib/features/app_wrapper)
    - [authentication/](./lib/features/authentication)
    - [error/](./lib/features/error)
    - [counter/](./lib/features/counter)
    - [github_users/](./lib/features/github_users)
    - [home/](./lib/features/home)
    - [memo/](./lib/features/memo)
    - [setting/](./lib/features/setting)
    - [start_up/](./lib/features/start_up)
    - [timeline/](./lib/features/timeline)
  - [app.dart](./lib/app.dart)
  - [main.dart](./lib/main.dart)

### Flavor

| 環境 | パッケージ名        | アプリ名           |
| ---- | ------------------- | ------------------ |
| 開発 | com.example.app.dev | dev.テンプレアプリ |
| 本番 | com.example.app     | 　テンプレアプリ   |

### 実行コマンド

- 開発

  ```sh
  flutter run --debug --dart-define=FLAVOR=dev
  ```

- 本番

  ```sh
  flutter run --debug --dart-define=FLAVOR=prod
  ```

Android Studio から実行する場合は、以下のように Run Configurations を設定する。

- dev環境でビルドする場合

![dev](./doc/images/run_configuration_debug_dev.png)

- prod環境でビルドする場合

![prod](./doc/images/run_configuration_debug_prod.png)

### Masonを使ってFeatureディレクトリを作成する

masonに登録されているbrickを取り込む

```sh
mason get
```

featureを実行してディレクトリを作成する

```sh
mason make feature
```

作成したディレクトリを[lib/features](lib/features/)へ移動して実装する

### リリースビルド

- Android

  ```sh
  # dev
  flutter build appbundle --release --dart-define=FLAVOR=dev

  # prod
  flutter build appbundle --release --dart-define=FLAVOR=prod
  ```

- iOS

  ```sh
  # dev
  flutter build ipa --release --dart-define=FLAVOR=dev

  # prod
  flutter build ipa --release --dart-define=FLAVOR=prod
  ```

## テスト

### Unit tests

```sh
# Run all tests
flutter test

# Run target test
flutter test test/features/github_users/repositories/github_api_repository_test.dart
```

ドキュメント

- [Testing Flutter apps: Unit tests](https://docs.flutter.dev/testing#unit-tests)

### Widget tests

```sh
# Run all tests
flutter test

# Run target test
flutter test test/features/github_users/pages/github_users_page_test.dart
```

ドキュメント

- [Testing Flutter apps: Widget tests](https://docs.flutter.dev/testing#widget-tests)

### Integration tests

実機・シミュレータを起動させるので、実行コマンドにflavor設定のjsonを指定してください。

```sh
# Run all tests
flutter test --dart-define=FLAVOR=dev integration_test

# Run target test
flutter test --dart-define=FLAVOR=dev integration_test/features/github_users/pages/github_users_page_test.dart
```

ドキュメント

- [Testing Flutter apps: Integration tests](https://docs.flutter.dev/testing#integration-tests)

### モック

[mockito](https://pub.dev/packages/mockito)を利用しています。モックのDIは[Riverpod](https://riverpod.dev/)の overrides を利用しています。

ドキュメント

- [Mock dependencies using Mockito](https://docs.flutter.dev/cookbook/testing/unit/mocking)

- [Riverpod Testing](https://docs-v2.riverpod.dev/docs/cookbooks/testing)

- [How to Unit Test AsyncNotifier Subclasses with Riverpod 2.0 in Flutter](https://codewithandrea.com/articles/unit-test-async-notifier-riverpod/)

