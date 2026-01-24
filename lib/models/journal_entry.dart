import 'package:hive/hive.dart';

part 'journal_entry.g.dart';

@HiveType(typeId: 2)
class JournalEntry extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  DateTime date;

  @HiveField(2)
  String content;

  @HiveField(3)
  JournalMood mood;

  JournalEntry({
    required this.id,
    required this.date,
    required this.content,
    required this.mood,
  });

  JournalEntry copyWith({
    String? id,
    DateTime? date,
    String? content,
    JournalMood? mood,
  }) {
    return JournalEntry(
      id: id ?? this.id,
      date: date ?? this.date,
      content: content ?? this.content,
      mood: mood ?? this.mood,
    );
  }
}

@HiveType(typeId: 3)
enum JournalMood {
  @HiveField(0)
  happy,

  @HiveField(1)
  neutral,

  @HiveField(2)
  sad,
}
