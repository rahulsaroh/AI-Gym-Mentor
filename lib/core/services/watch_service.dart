import 'dart:async';
import 'package:watch_connectivity/watch_connectivity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'watch_service.g.dart';

@riverpod
class WatchService extends _$WatchService {
  final WatchConnectivity _watch = WatchConnectivity();
  
  // Streams for the UI to consume
  final _messageController = StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get messages => _messageController.stream;

  @override
  void build() {
    _init();
    ref.onDispose(() {
      _messageController.close();
    });
  }

  Future<void> _init() async {
    _watch.messageStream.listen((message) {
      _handleIncomingMessage(message);
      _messageController.add(message);
    });
  }

  void _handleIncomingMessage(Map<String, dynamic> message) {
    final type = message['type'];
    if (type == 'hr_update') {
      final hr = message['hr'] as int;
      // You could update a separate HeartRate provider here
      print('Received HR from watch: $hr');
    } else if (type == 'set_completed') {
      // Handle remote set completion if needed
      print('Set completed via watch');
    }
  }

  /// Sends the current workout state to the watch.
  Future<void> updateWorkoutState({
    required String exerciseName,
    required int currentSet,
    required int totalSets,
    bool timerRunning = false,
    int remainingSeconds = 0,
  }) async {
    try {
      if (await _watch.isPaired) {
        final data = {
          'type': 'workout_update',
          'exercise': exerciseName,
          'set': currentSet,
          'total_sets': totalSets,
          'timer_active': timerRunning,
          'timer_seconds': remainingSeconds,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        };
        await _watch.sendMessage(data);
      }
    } catch (e) {
      // Silent fail for connectivity issues to avoid crashing the app
      print('Watch communication error: $e');
    }
  }

  /// Sends a simple notification or ping to the watch
  Future<void> pingWatch(String title, String body) async {
    try {
      if (await _watch.isPaired) {
        await _watch.sendMessage({
          'type': 'notification',
          'title': title,
          'body': body,
        });
      }
    } catch (e) {
      print('Watch ping error: $e');
    }
  }

  /// Check if a watch is connected and the app is installed
  Future<bool> get isWatchAvailable async {
    try {
      return await _watch.isPaired && await _watch.isReachable;
    } catch (_) {
      return false;
    }
  }
}
