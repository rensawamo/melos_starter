import 'app_logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProviderLogger implements ProviderObserver {
  const ProviderLogger();

  @override
  void didAddProvider(
    ProviderBase<dynamic> provider,
    Object? value,
    ProviderContainer container,
  ) {
    logger.i('[ADD]: ${provider.describe}');
  }

  @override
  void didDisposeProvider(
    ProviderBase<dynamic> provider,
    ProviderContainer container,
  ) {
    logger.d('[DISPOSE]: ${provider.describe}');
  }

  @override
  void didUpdateProvider(
    ProviderBase<dynamic> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    logger.i('[UPDATE]*: ${provider.describe}');
  }

  @override
  void providerDidFail(
    ProviderBase<dynamic> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    logger.e('[FAIL]: ${provider.describe}');
  }
}

extension _ProviderName on ProviderBase<dynamic> {
  String get describe => name ?? toString();
}
