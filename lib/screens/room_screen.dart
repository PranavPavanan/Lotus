import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/affirmations.dart';
import '../core/utils/isometric_helper.dart';
import '../providers/user_stats_provider.dart';
import '../widgets/laptop/todo_modal.dart';
import 'focus_mode_screen.dart';

class RoomScreen extends ConsumerWidget {
  const RoomScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userStats = ref.watch(userStatsProvider);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Layer 1: Background (Bedroom Day Scene)
            Positioned.fill(
              child: Image.asset(
                'assets/images/room/bedroom_day.png',
                fit: BoxFit.cover,
              ),
            ),

            // Layer 2: Room Objects (Z-Order: Back to Front)
            
            // Window (Back wall, attached)
            IsometricObject(
              leftFraction: 0.16,
              topFraction: 0.36,
              widthFraction: 0.24,
              heightFraction: 0.12,
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const FocusModeScreen()),
                ),
                child: Image.asset(
                  'assets/images/room/window.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // Shelf (Back wall, attached)
            IsometricObject(
              leftFraction: 0.50,
              topFraction: 0.33,
              widthFraction: 0.38,
              heightFraction: 0.10,
              child: GestureDetector(
                onTap: () => _showJournalSheet(context, ref),
                child: Image.asset(
                  'assets/images/room/shelf.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // Mirror (Leaning against wall)
            IsometricObject(
              leftFraction: 0.38,
              topFraction: 0.42,
              widthFraction: 0.12,
              heightFraction: 0.28,
              child: GestureDetector(
                onTap: () => _showMirrorAffirmation(context),
                child: Image.asset(
                  'assets/images/room/mirror.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // Table (On floor, slightly behind bed)
            IsometricObject(
              leftFraction: 0.52,
              topFraction: 0.50,
              widthFraction: 0.38,
              heightFraction: 0.24,
              child: Image.asset(
                'assets/images/room/table.png',
                fit: BoxFit.contain,
              ),
            ),

            // Laptop on Table (Interactive - To-Do List)
            // Positioned on top of the table
            IsometricObject(
              leftFraction: 0.65,
              topFraction: 0.58,
              widthFraction: 0.15,
              heightFraction: 0.08,
              child: GestureDetector(
                onTap: () => _showTodoModal(context),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Center(
                    child: Icon(Icons.laptop, size: 30, color: Colors.white70),
                  ),
                ),
              ),
            ),

            // Bed (Most foreground object)
            IsometricObject(
              leftFraction: 0.12,
              topFraction: 0.58,
              widthFraction: 0.36,
              heightFraction: 0.18,
              child: Image.asset(
                'assets/images/room/bed.png',
                fit: BoxFit.contain,
              ),
            ),

            // Plushie on Bed (Interactive - Water Check)
            // Positioned on top of the bed
            IsometricObject(
              leftFraction: 0.20,
              topFraction: 0.63,
              widthFraction: 0.12,
              heightFraction: 0.08,
              child: GestureDetector(
                onTap: () => _showWaterCheckDialog(context, ref),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Center(
                    child: Icon(Icons.pets, size: 24, color: Colors.white70),
                  ),
                ),
              ),
            ),

            // Coin Counter (Top-Right)
            Positioned(
              top: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.monetization_on,
                      color: AppColors.coinGold,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${userStats.totalCoins}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Show To-Do Modal
  void _showTodoModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const TodoModal(),
    );
  }

  // Show Mirror Affirmation
  void _showMirrorAffirmation(BuildContext context) {
    final affirmation = Affirmations.getRandom();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.auto_awesome, color: AppColors.accentWarm),
            SizedBox(width: 8),
            Text('Today\'s Affirmation'),
          ],
        ),
        content: Text(
          affirmation,
          style: const TextStyle(
            fontSize: 18,
            fontStyle: FontStyle.italic,
            color: AppColors.textPrimary,
          ),
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Thank you ✨'),
          ),
        ],
      ),
    );
  }

  // Show Water Check Dialog
  void _showWaterCheckDialog(BuildContext context, WidgetRef ref) {
    final canCheck = ref.read(userStatsProvider).canCheckWaterToday();

    if (!canCheck) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.check_circle, color: AppColors.success),
              SizedBox(width: 8),
              Text('Already Checked!'),
            ],
          ),
          content: const Text(
            'You\'ve already checked in today! Come back tomorrow. 💙',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.water_drop, color: Colors.blue),
            SizedBox(width: 8),
            Text('Hydration Check'),
          ],
        ),
        content: const Text(
          'Have you had water today?',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: const Text(
                    'That\'s okay! Remember to hydrate when you can. 💧',
                    textAlign: TextAlign.center,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Will do!'),
                    ),
                  ],
                ),
              );
            },
            child: const Text('Not yet'),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(userStatsProvider.notifier).markWaterChecked();
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Row(
                    children: [
                      Icon(Icons.celebration, color: AppColors.coinGold),
                      SizedBox(width: 8),
                      Text('Great job!'),
                    ],
                  ),
                  content: const Text(
                    'You earned +10 coins for staying hydrated! 💧✨',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Awesome!'),
                    ),
                  ],
                ),
              );
            },
            child: const Text('Yes! 💧'),
          ),
        ],
      ),
    );
  }

  // Show Journal Sheet (Placeholder)
  void _showJournalSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.book, size: 48, color: AppColors.accentWarm),
            const SizedBox(height: 16),
            const Text(
              'Journal',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Coming in Phase 3!',
              style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Okay'),
            ),
          ],
        ),
      ),
    );
  }
}
