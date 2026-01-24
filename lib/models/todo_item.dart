import 'package:hive/hive.dart';

part 'todo_item.g.dart';

@HiveType(typeId: 0)
class TodoItem extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  bool isCompleted;

  @HiveField(3)
  DateTime createdAt;

  @HiveField(4)
  TodoCategory category; // Today or Tomorrow

  @HiveField(5)
  int? completedCoins; // Coins earned when completed

  TodoItem({
    required this.id,
    required this.title,
    this.isCompleted = false,
    required this.createdAt,
    required this.category,
    this.completedCoins,
  });

  /// Creates a copy with modified fields
  TodoItem copyWith({
    String? id,
    String? title,
    bool? isCompleted,
    DateTime? createdAt,
    TodoCategory? category,
    int? completedCoins,
  }) {
    return TodoItem(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      category: category ?? this.category,
      completedCoins: completedCoins ?? this.completedCoins,
    );
  }
}

@HiveType(typeId: 1)
enum TodoCategory {
  @HiveField(0)
  today,

  @HiveField(1)
  tomorrow,
}
