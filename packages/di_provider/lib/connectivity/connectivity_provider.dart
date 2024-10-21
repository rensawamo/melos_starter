import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'connectivity_provider.g.dart';

@Riverpod(keepAlive: true)
Connectivity connectivity(ConnectivityRef ref) {
  return Connectivity();
}

// @Riverpod(keepAlive: true)
// class ConnectivityProvider extends _$ConnectivityProvider {
//   @override
//   Stream<bool> build() {
//     final connectivity = Connectivity();
//     // Listen to connectivity changes and map the results to a boolean
//     return connectivity.onConnectivityChanged.map((result) {
//       return result.contains(ConnectivityResult.none);
//     });
//   }
// }
