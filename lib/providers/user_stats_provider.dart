import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/user_stats.dart';

/// Provider for user statistics (coins, water check, etc.)
final userStatsProvider = StateNotifierProvider<UserStatsNotifier, UserStats>((ref) {
  return UserStatsNotifier();
});

class UserStatsNotifier extends StateNotifier<UserStats> {
  UserStatsNotifier() : super(_loadInitialStats()) {
    _checkDailyReset();
  }

  final Box<UserStats> _box = Hive.box<UserStats>('userStats');

  /// Load initial stats from Hive or create default
  static UserStats _loadInitialStats() {
    final box = Hive.box<UserStats>('userStats');
    if (box.isEmpty) {
      final defaultStats = UserStats(lastResetDate: DateTime.now());
      box.put('stats', defaultStats);
      return defaultStats;
    }
    return box.get('stats')!;
  }

  /// Check if we need to reset daily counters
  void _checkDailyReset() {
    if (state.shouldResetDaily()) {
      state = state.copyWith(
        tasksCompletedToday: 0,
        lastResetDate: DateTime.now(),
      );
      _saveStats();
    }
  }

  /// Add coins to user's total
  void addCoins(int amount) {
    state = state.copyWith(totalCoins: state.totalCoins + amount);
    _saveStats();
  }

  /// Mark water check as done for today
  void markWaterChecked() {
    if (state.canCheckWaterToday()) {
      state = state.copyWith(
        lastWaterCheckDate: DateTime.now(),
        totalCoins: state.totalCoins + 10, // +10 coins for water
      );
      _saveStats();
    }
  }

  /// Increment task completion counter
  void incrementTasksCompleted() {
    state = state.copyWith(tasksCompletedToday: state.tasksCompletedToday + 1);
    _saveStats();
  }

  /// Set the flag for uncompleted yesterday tasks
  void setHasUncompletedYesterdayTasks(bool value) {
    state = state.copyWith(hasUncompletedYesterdayTasks: value);
    _saveStats();
  }

  void _saveStats() {
    _box.put('stats', state);
  }
}
