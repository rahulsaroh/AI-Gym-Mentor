import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ai_gym_mentor/core/auth/auth_provider.dart';
import 'package:ai_gym_mentor/core/database/database.dart';
import 'package:ai_gym_mentor/services/connectivity_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dart:async';

part 'cloud_integration_state.freezed.dart';
part 'cloud_integration_state.g.dart';

@freezed
class CloudIntegrationState with _$CloudIntegrationState {
  const factory CloudIntegrationState({
    @Default(false) bool isFirebaseInitialized,
    @Default(ConnectivityResult.none) ConnectivityResult connectivity,
    @Default(false) bool isGoogleSignedIn,
    @Default(0) int pendingSyncCount,
    String? lastSyncError,
    DateTime? lastSyncedAt,
    @Default(false) bool isSyncEnabled,
  }) = _CloudIntegrationState;
}

@Riverpod(keepAlive: true)
class CloudIntegration extends _$CloudIntegration {
  StreamSubscription? _authSub;
  StreamSubscription? _queueSub;

  @override
  CloudIntegrationState build() {
    // 1. Listen to connectivity
    ref.listen(connectivityServiceProvider, (prev, next) {
      final res = next.value ?? ConnectivityResult.none;
      state = state.copyWith(connectivity: res);
    });

    // 2. Listen to Auth Status
    final gSignIn = ref.watch(googleSignInProvider);
    _authSub?.cancel();
    _authSub = gSignIn.onCurrentUserChanged.listen((user) {
      state = state.copyWith(isGoogleSignedIn: user != null);
    });

    // 3. Listen to Sync Queue
    _initSyncCounter();

    ref.onDispose(() {
      _authSub?.cancel();
      _queueSub?.cancel();
    });

    return const CloudIntegrationState();
  }

  void setFirebaseInitialized(bool value) {
    state = state.copyWith(isFirebaseInitialized: value);
  }

  void setLastSyncError(String? error) {
    state = state.copyWith(lastSyncError: error);
  }

  void updateLastSyncedAt(DateTime at) {
    state = state.copyWith(lastSyncedAt: at);
  }

  void setSyncEnabled(bool enabled) {
    state = state.copyWith(isSyncEnabled: enabled);
  }

  void _initSyncCounter() {
    final db = ref.read(appDatabaseProvider);
    _queueSub?.cancel();
    _queueSub = (db.select(db.syncQueue)
          ..where((t) => t.status.isIn(['pending', 'failed'])))
        .watch()
        .listen((items) {
      state = state.copyWith(pendingSyncCount: items.length);
    });
  }
}
