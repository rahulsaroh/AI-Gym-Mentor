import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'connectivity_service.g.dart';

@riverpod
class ConnectivityService extends _$ConnectivityService {
  @override
  Stream<bool> build() {
    return Connectivity().onConnectivityChanged.map((results) {
      // In connectivity_plus v6, onConnectivityChanged returns a List<ConnectivityResult>
      return results.isNotEmpty && !results.contains(ConnectivityResult.none);
    });
  }

  Future<bool> isConnected() async {
    final results = await Connectivity().checkConnectivity();
    return results.isNotEmpty && !results.contains(ConnectivityResult.none);
  }
}
