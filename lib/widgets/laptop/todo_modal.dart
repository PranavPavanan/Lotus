import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:confetti/confetti.dart';
import '../../core/constants/app_colors.dart';
import '../../models/todo_item.dart';
import '../../providers/todo_provider.dart';

class TodoModal extends ConsumerStatefulWidget {
  const TodoModal({super.key});

  @override
  ConsumerState<TodoModal> createState() => _TodoModalState();
}

class _TodoModalState extends ConsumerState<TodoModal>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ConfettiController _confettiController;
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _confettiController = ConfettiController(duration: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    _tabController.dispose();
    _confettiController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todayTodos = ref.watch(todayTodosProvider);
    final tomorrowTodos = ref.watch(tomorrowTodosProvider);

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              children: [
                // Header with Close Button
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const Icon(Icons.laptop, color: AppColors.textPrimary),
                      const SizedBox(width: 12),
                      const Text(
                        'Productivity Hub',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),

                // Tabs
                TabBar(
                  controller: _tabController,
                  labelColor: AppColors.accentWarm,
                  unselectedLabelColor: AppColors.textSecondary,
                  indicatorColor: AppColors.accentWarm,
                  tabs: const [
                    Tab(text: 'Today'),
                    Tab(text: 'Tomorrow'),
                  ],
                ),

                // Tab Views
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildTodoList(todayTodos, TodoCategory.today),
                      _buildTodoList(tomorrowTodos, TodoCategory.tomorrow),
                    ],
                  ),
                ),

                // Add Task Input
                _buildAddTaskInput(),
              ],
            ),

            // Confetti Overlay
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                colors: const [
                  AppColors.accentWarm,
                  AppColors.success,
                  AppColors.coinGold,
                  Colors.pink,
                  Colors.blue,
                ],
                numberOfParticles: 20,
                gravity: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTodoList(List<TodoItem> todos, TodoCategory category) {
    if (todos.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline,
              size: 64,
              color: AppColors.textHint.withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            Text(
              category == TodoCategory.today
                  ? 'No tasks for today!\nAdd one below.'
                  : 'No tasks for tomorrow yet.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.textHint,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return _buildTodoTile(todo);
      },
    );
  }

  Widget _buildTodoTile(TodoItem todo) {
    return Dismissible(
      key: Key(todo.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: AppColors.error,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) {
        ref.read(todoProvider.notifier).deleteTodo(todo.id);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Task deleted')),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 8),
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: Checkbox(
            value: todo.isCompleted,
            onChanged: (_) {
              ref.read(todoProvider.notifier).toggleTodo(todo.id);
              if (!todo.isCompleted) {
                // Trigger confetti on completion
                _confettiController.play();
              }
            },
            activeColor: AppColors.success,
          ),
          title: Text(
            todo.title,
            style: TextStyle(
              decoration: todo.isCompleted
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
              color: todo.isCompleted
                  ? AppColors.textHint
                  : AppColors.textPrimary,
            ),
          ),
          trailing: todo.isCompleted
              ? const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.monetization_on,
                        color: AppColors.coinGold, size: 20),
                    SizedBox(width: 4),
                    Text(
                      '+10',
                      style: TextStyle(
                        color: AppColors.coinGold,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildAddTaskInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: AppColors.divider.withOpacity(0.3)),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: const InputDecoration(
                hintText: 'Add a new task...',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              onSubmitted: (_) => _addTask(),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.add_circle, size: 36),
            color: AppColors.accentWarm,
            onPressed: _addTask,
          ),
        ],
      ),
    );
  }

  void _addTask() {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    final category = _tabController.index == 0
        ? TodoCategory.today
        : TodoCategory.tomorrow;

    ref.read(todoProvider.notifier).addTodo(text, category);
    _textController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          category == TodoCategory.today
              ? 'Task added to Today'
              : 'Task added to Tomorrow',
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
