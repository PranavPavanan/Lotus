import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Timer state for Focus Mode
class TimerState {
  final int remainingSeconds;
  final bool isRunning;
  final bool isAbandoned;
  final TimerMode mode;

  TimerState({
    required this.remainingSeconds,
    this.isRunning = false,
    this.isAbandoned = false,
    this.mode = TimerMode.pomodoro,
  });

  TimerState copyWith({
    int? remainingSeconds,
    bool? isRunning,
    bool? isAbandoned,
    TimerMode? mode,
  }) {
    return TimerState(
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      isRunning: isRunning ?? this.isRunning,
      isAbandoned: isAbandoned ?? this.isAbandoned,
      mode: mode ?? this.mode,
    );
  }

  /// Get formatted time string (MM:SS)
  String get formattedTime {
    final minutes = remainingSeconds ~/ 60;
    final seconds = remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}

enum TimerMode {
  pomodoro(25 * 60), // 25 minutes
  shortBreak(5 * 60), // 5 minutes
  longBreak(15 * 60); // 15 minutes

  final int seconds;
  const TimerMode(this.seconds);
}

/// Provider for Pomodoro Timer
final timerProvider = StateNotifierProvider<TimerNotifier, TimerState>((ref) {
  return TimerNotifier();
});

class TimerNotifier extends StateNotifier<TimerState> {
  TimerNotifier()
      : super(TimerState(remainingSeconds: TimerMode.pomodoro.seconds));

  Timer? _timer;

  /// Start the timer
  void start() {
    if (state.isRunning) return;

    state = state.copyWith(isRunning: true, isAbandoned: false);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.remainingSeconds > 0) {
        state = state.copyWith(remainingSeconds: state.remainingSeconds - 1);
      } else {
        stop();
      }
    });
  }

  /// Pause the timer
  void pause() {
    _timer?.cancel();
    state = state.copyWith(isRunning: false);
  }

  /// Stop and reset the timer
  void stop() {
    _timer?.cancel();
    state = TimerState(remainingSeconds: state.mode.seconds);
  }

  /// Mark as abandoned (when user exits without completing)
  void abandon() {
    _timer?.cancel();
    state = state.copyWith(isRunning: false, isAbandoned: true);
  }

  /// Switch timer mode (Pomodoro, Short Break, Long Break)
  void switchMode(TimerMode mode) {
    _timer?.cancel();
    state = TimerState(remainingSeconds: mode.seconds, mode: mode);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
