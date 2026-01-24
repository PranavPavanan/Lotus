# 👨‍💻 Developer Notes

## Architecture Decisions

### Why Riverpod over Provider?
- **Better separation of concerns:** Each feature gets its own provider file
- **No BuildContext dependency:** Can access state from anywhere (critical for GestureDetector hitboxes)
- **Type safety:** Compile-time error checking
- **Easier testing:** Providers can be overridden in tests
- **Future-proof:** Better async handling for cloud sync (V2)

### Why Hive over Shared Preferences?
- **Type safety:** Models with adapters (vs. JSON strings)
- **Performance:** Binary format, faster than JSON parsing
- **Relationships:** Can reference other Hive objects
- **Scalability:** No 2MB limit like SharedPreferences
- **Code generation:** Less boilerplate with build_runner

### Why Fractional Positioning?
- **Responsive:** Scales automatically across screen sizes
- **Predictable:** 0.0-1.0 range is easier to reason about than pixels
- **Maintainable:** One coordinate system for all devices
- **Designer-friendly:** Can map directly to Figma/Sketch percentage layouts

---

## State Management Pattern

All providers follow this structure:

```dart
// 1. Define state class (if complex)
class MyState {
  final int value;
  MyState(this.value);
}

// 2. Create StateNotifier
class MyNotifier extends StateNotifier<MyState> {
  MyNotifier() : super(MyState(0));
  
  void increment() {
    state = MyState(state.value + 1);
    _save(); // Persist to Hive
  }
}

// 3. Expose provider
final myProvider = StateNotifierProvider<MyNotifier, MyState>((ref) {
  return MyNotifier();
});
```

**Consumer usage:**
```dart
// Read
final myState = ref.watch(myProvider);

// Write
ref.read(myProvider.notifier).increment();
```

---

## Data Flow Diagram

```
User Interaction (Tap)
    ↓
GestureDetector in room_screen.dart
    ↓
ref.read(provider.notifier).method()
    ↓
StateNotifier updates state
    ↓
Hive box persists data
    ↓
ref.watch(provider) rebuilds UI
```

---

## Adding a New Interactive Object

Follow this checklist:

### 1. **Add to room_screen.dart**
```dart
IsometricObject(
  leftFraction: 0.x,
  topFraction: 0.y,
  widthFraction: 0.w,
  heightFraction: 0.h,
  child: GestureDetector(
    onTap: () => _handleNewObjectTap(context, ref),
    child: Container(/* placeholder */),
  ),
)
```

### 2. **Create handler method**
```dart
void _handleNewObjectTap(BuildContext context, WidgetRef ref) {
  // Show dialog, navigate, or update state
}
```

### 3. **If it needs state:**
- Create model in `lib/models/`
- Add Hive adapter
- Run `build_runner`
- Create provider in `lib/providers/`

### 4. **If it awards coins:**
```dart
ref.read(userStatsProvider.notifier).addCoins(10);
```

---

## Common Tasks

### Change Coin Reward Amount
Edit the provider method (e.g., `todo_provider.dart`):
```dart
// Change from 10 to 20
ref.read(userStatsProvider.notifier).addCoins(20);
```

### Add New Affirmation
Edit `lib/core/constants/affirmations.dart`:
```dart
static const List<String> daily = [
  "Your new affirmation here",
  // ... existing ones
];
```

### Modify Color Palette
Edit `lib/core/constants/app_colors.dart`:
```dart
static const Color primaryBeige = Color(0xFFYOURCOLOR);
```

### Add New Route
In `lib/main.dart`, add to `MaterialApp`:
```dart
routes: {
  '/room': (context) => const RoomScreen(),
  '/focus': (context) => const FocusModeScreen(),
  '/journal': (context) => const JournalScreen(), // New
},
```

---

## Performance Considerations

### Current Optimizations
- ✅ **Hive boxes opened once** at app startup (not per-read)
- ✅ **Riverpod caching** prevents unnecessary rebuilds
- ✅ **LayoutBuilder in IsometricObject** computes positions only when constraints change
- ✅ **Const constructors** where possible to reduce widget rebuilds

### Known Performance Notes
- **Confetti widget:** Runs on completion (minimal impact, 1-2s animation)
- **Image assets:** Once added, use `precacheImage()` in `initState` for smoother loading
- **Timer ticks:** Currently updates every second (could optimize to only update on-screen widgets)

### Future Optimizations (if needed)
- Use `Selector` providers for granular rebuilds
- Implement virtual scrolling for long journal entries
- Add image compression for user-uploaded assets (V2)

---

## Testing Strategy

### Manual Testing Checklist
- [ ] Add task → Complete → Verify +10 coins
- [ ] Add task → Delete → Verify removal
- [ ] Water check → Try twice → Second attempt blocked
- [ ] Close app → Reopen → Verify persistence
- [ ] Switch tabs (Today/Tomorrow) → Verify correct filtering
- [ ] Affirmation → Different each time (roughly)

### Unit Test Structure (Future)
```dart
test('completing todo awards 10 coins', () {
  final container = ProviderContainer();
  final todoNotifier = container.read(todoProvider.notifier);
  final statsNotifier = container.read(userStatsProvider.notifier);
  
  todoNotifier.addTodo('Test task', TodoCategory.today);
  final todoId = container.read(todoProvider)[0].id;
  
  final initialCoins = container.read(userStatsProvider).totalCoins;
  todoNotifier.toggleTodo(todoId);
  final finalCoins = container.read(userStatsProvider).totalCoins;
  
  expect(finalCoins, initialCoins + 10);
});
```

---

## Debugging Tips

### View Hive Database Contents
Add this to a debug button:
```dart
void _debugPrintHive() {
  final todos = Hive.box<TodoItem>('todos').values.toList();
  print('Todos: $todos');
  
  final stats = Hive.box<UserStats>('userStats').get('stats');
  print('Stats: ${stats?.totalCoins} coins');
}
```

### Inspect Provider State
Add to RoomScreen:
```dart
@override
Widget build(BuildContext context, WidgetRef ref) {
  ref.listen(userStatsProvider, (prev, next) {
    print('Coins changed: ${prev?.totalCoins} → ${next.totalCoins}');
  });
  // ... rest of build
}
```

### Reset All Data
Add to settings (future):
```dart
void _resetAllData() {
  Hive.box<TodoItem>('todos').clear();
  Hive.box<JournalEntry>('journal').clear();
  Hive.box<UserStats>('userStats').put(
    'stats',
    UserStats(lastResetDate: DateTime.now()),
  );
}
```

---

## Known Issues & Workarounds

### Issue: Confetti doesn't show on first completion
**Cause:** ConfettiController initialization race condition  
**Workaround:** Call `_confettiController.play()` with a slight delay:
```dart
Future.delayed(Duration(milliseconds: 50), () {
  _confettiController.play();
});
```

### Issue: Hot reload breaks Hive adapters
**Cause:** Adapter re-registration during dev  
**Workaround:** Hot restart instead of hot reload, or add guard:
```dart
if (!Hive.isAdapterRegistered(0)) {
  Hive.registerAdapter(TodoItemAdapter());
}
```

### Issue: withOpacity deprecation warnings
**Cause:** Flutter 3.10+ promotes `.withValues()`  
**Fix (when ready):** Replace all instances:
```dart
// Old
color.withOpacity(0.3)

// New
color.withValues(alpha: 0.3)
```

---

## Git Workflow Recommendations

### Commit Structure
```
feat: Add water check feature
fix: Coin counter not updating
refactor: Extract todo tile to widget
docs: Update asset guide
```

### Branching Strategy (if expanding)
- `main` - Stable releases
- `develop` - Integration branch
- `feature/focus-mode` - New features
- `hotfix/coin-bug` - Critical fixes

---

## Future Enhancements (Technical)

### Phase 2 Prep
- [ ] Research Flutter audio packages (for ambient sounds)
- [ ] Test `wakelock_plus` on iOS (requires entitlements)
- [ ] Design timer notification system (background tasks)

### V2 (Cloud Sync) Prep
- [ ] Abstract storage layer (Hive → Repository pattern)
- [ ] Add sync status indicators
- [ ] Implement conflict resolution (last-write-wins?)
- [ ] Consider Firebase vs. Supabase vs. custom backend

### Accessibility
- [ ] Add semantic labels to all interactive objects
- [ ] Test with screen readers
- [ ] Ensure sufficient contrast ratios
- [ ] Add haptic feedback on interactions

---

## Useful Commands Reference

```bash
# Get dependencies
flutter pub get

# Generate Hive adapters
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode (auto-generate on save)
flutter pub run build_runner watch

# Run with specific device
flutter run -d chrome
flutter run -d <device-id>

# List devices
flutter devices

# Clean build
flutter clean && flutter pub get

# Analyze code
flutter analyze

# Format code
flutter format lib/

# Run tests
flutter test

# Build APK (debug)
flutter build apk --debug

# Build APK (release)
flutter build apk --release
```

---

## Contact / Contribution Guidelines

This is a personal project, but if you fork it:
1. Keep the cozy aesthetic! 🏡
2. No dark patterns (streak pressure, etc.)
3. Privacy-first (offline default)
4. Maintain accessibility standards

---

**Last Updated:** January 14, 2026  
**Flutter Version:** 3.10.7  
**Dart Version:** 3.10.0
