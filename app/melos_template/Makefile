
.PHONY: upgrade
upgrade:
	flutter pub upgrade --major-versions

.PHONY: splash
splash:
	flutter pub run flutter_native_splash:create

.PHONY: icon
icon:
	flutter pub run flutter_launcher_icons

.PHONY: release_build_android
release_build_android:
	flutter build apk --release  --obfuscate --split-debug-info=obfuscate/android --dart-define=flavor=prod

.PHONY: release_build_ios
release_build_ios:
	flutter build ipa --release --obfuscate --split-debug-info=obfuscate/ios --dart-define=flavor=prod