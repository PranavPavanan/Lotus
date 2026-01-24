import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/todo_item.dart';
import 'user_stats_provider.dart';

/// Provider for all TODO items
final todoProvider = StateNotifierProvider<TodoNotifier, List<TodoItem>>((ref) {
  return TodoNotifier(ref);
});

/// Provider for filtered Today tasks
final todayTodosProvider = Provider<List<TodoItem>>((ref) {
  final allTodos = ref.watch(todoProvider);
  return allTodos.where((todo) => todo.category == TodoCategory.today).toList();
});

/// Provider for filtered Tomorrow tasks
final tomorrowTodosProvider = Provider<List<TodoItem>>((ref) {
  final allTodos = ref.watch(todoProvider);
  return allTodos.where((todo) => todo.category == TodoCategory.tomorrow).toList();
});

class TodoNotifier extends StateNotifier<List<TodoItem>> {
  TodoNotifier(this.ref) : super([]) {
    _loadTodos();
  }

  final Ref ref;
  final Box<TodoItem> _box = Hive.box<TodoItem>('todos');

  void _loadTodos() {
    state = _box.values.toList();
  }

  /// Add a new todo
  void addTodo(String title, TodoCategory category) {
    final newTodo = TodoItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      createdAt: DateTime.now(),
      category: category,
    );
    
    _box.put(newTodo.id, newTodo);
    state = [...state, newTodo];
  }

  /// Toggle todo completion status
  void toggleTodo(String id) {
    final index = state.indexWhere((todo) => todo.id == id);
    if (index == -1) return;

    final todo = state[index];
    final updatedTodo = todo.copyWith(
      isCompleted: !todo.isCompleted,
      completedCoins: !todo.isCompleted ? 10 : null, // Award 10 coins
    );

    _box.put(id, updatedTodo);
    state = [
      ...state.sublist(0, index),
      updatedTodo,
      ...state.sublist(index + 1),
    ];

    // Award coins if completing
    if (updatedTodo.isCompleted) {
      ref.read(userStatsProvider.notifier).addCoins(10);
      ref.read(userStatsProvider.notifier).incrementTasksCompleted();
    }
  }

  /// Delete a todo
  void deleteTodo(String id) {
    _box.delete(id);
    state = state.where((todo) => todo.id != id).toList();
  }

  /// Move uncompleted today tasks to tomorrow (or delete)
  void moveOrDeleteYesterdayTasks(bool moveToToday) {
    final yesterdayTasks = state.where(
      (todo) => todo.category == TodoCategory.today && !todo.isCompleted,
    ).toList();

    if (moveToToday) {
      // Keep them in "Today"
      for (var todo in yesterdayTasks) {
        final updated = todo.copyWith(createdAt: DateTime.now());
        _box.put(todo.id, updated);
      }
    } else {
      // Delete them
      for (var todo in yesterdayTasks) {
        _box.delete(todo.id);
      }
    }

    _loadTodos(); // Refresh state
    ref.read(userStatsProvider.notifier).setHasUncompletedYesterdayTasks(false);
  }
}
