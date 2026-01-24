import 'package:hive/hive.dart';

part 'user_stats.g.dart';

@HiveType(typeId: 4)
class UserStats extends HiveObject {
  @HiveField(0)
  int totalCoins;

  @HiveField(1)
  DateTime? lastWaterCheckDate; // For once-per-day water check

  @HiveField(2)
  int tasksCompletedToday;

  @HiveField(3)
  DateTime lastResetDate; // Track when we last reset daily counters

  @HiveField(4)
  bool hasUncompletedYesterdayTasks; // Flag for showing migration prompt

  UserStats({
    this.totalCoins = 0,
    this.lastWaterCheckDate,
    this.tasksCompletedToday = 0,
    required this.lastResetDate,
    this.hasUncompletedYesterdayTasks = false,
  });

  /// Check if we need to reset daily counters (new day)
  bool shouldResetDaily() {
    final now = DateTime.now();
    return !_isSameDay(lastResetDate, now);
  }

  /// Check if water check is available today
  bool canCheckWaterToday() {
    if (lastWaterCheckDate == null) return true;
    final now = DateTime.now();
    return !_isSameDay(lastWaterCheckDate!, now);
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  UserStats copyWith({
    int? totalCoins,
    DateTime? lastWaterCheckDate,
    int? tasksCompletedToday,
    DateTime? lastResetDate,
    bool? hasUncompletedYesterdayTasks,
  }) {
    return UserStats(
      totalCoins: totalCoins ?? this.totalCoins,
      lastWaterCheckDate: lastWaterCheckDate ?? this.lastWaterCheckDate,
      tasksCompletedToday: tasksCompletedToday ?? this.tasksCompletedToday,
      lastResetDate: lastResetDate ?? this.lastResetDate,
      hasUncompletedYesterdayTasks:
          hasUncompletedYesterdayTasks ?? this.hasUncompletedYesterdayTasks,
    );
  }
}
