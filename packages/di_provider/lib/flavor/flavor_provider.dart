import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'flavor_provider.g.dart';

@Riverpod(keepAlive: true)
Flavor flavor(FlavorRef ref) {
  throw UnimplementedError();
}

enum Flavor {
  dev,
  stg,
  prod,
}
