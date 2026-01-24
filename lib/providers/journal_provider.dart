import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/journal_entry.dart';

/// Provider for all journal entries
final journalProvider = StateNotifierProvider<JournalNotifier, List<JournalEntry>>((ref) {
  return JournalNotifier();
});

class JournalNotifier extends StateNotifier<List<JournalEntry>> {
  JournalNotifier() : super([]) {
    _loadEntries();
  }

  final Box<JournalEntry> _box = Hive.box<JournalEntry>('journal');

  void _loadEntries() {
    state = _box.values.toList()
      ..sort((a, b) => b.date.compareTo(a.date)); // Most recent first
  }

  /// Add or update journal entry for today
  void saveEntry(String content, JournalMood mood) {
    final today = DateTime.now();
    final todayKey = '${today.year}-${today.month}-${today.day}';

    // Check if entry exists for today
    final existingEntry = state.firstWhere(
      (entry) =>
          entry.date.year == today.year &&
          entry.date.month == today.month &&
          entry.date.day == today.day,
      orElse: () => JournalEntry(
        id: todayKey,
        date: today,
        content: '',
        mood: JournalMood.neutral,
      ),
    );

    final updatedEntry = existingEntry.copyWith(
      content: content,
      mood: mood,
      date: today,
    );

    _box.put(todayKey, updatedEntry);
    _loadEntries();
  }

  /// Get entry for a specific date
  JournalEntry? getEntryForDate(DateTime date) {
    return state.firstWhere(
      (entry) =>
          entry.date.year == date.year &&
          entry.date.month == date.month &&
          entry.date.day == date.day,
      orElse: () => JournalEntry(
        id: '',
        date: date,
        content: '',
        mood: JournalMood.neutral,
      ),
    );
  }
}
