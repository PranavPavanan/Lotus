import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/theme/app_theme.dart';
import 'models/todo_item.dart';
import 'models/journal_entry.dart';
import 'models/user_stats.dart';
import 'screens/room_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock to portrait mode
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize Hive
  await Hive.initFlutter();
  
  // Register Hive Adapters
  Hive.registerAdapter(TodoItemAdapter());
  Hive.registerAdapter(TodoCategoryAdapter());
  Hive.registerAdapter(JournalEntryAdapter());
  Hive.registerAdapter(JournalMoodAdapter());
  Hive.registerAdapter(UserStatsAdapter());

  // Open Boxes
  await Hive.openBox<TodoItem>('todos');
  await Hive.openBox<JournalEntry>('journal');
  await Hive.openBox<UserStats>('userStats');

  runApp(const ProviderScope(child: SanctuaryApp()));
}

class SanctuaryApp extends StatelessWidget {
  const SanctuaryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Sanctuary',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const RoomScreen(),
    );
  }
}
