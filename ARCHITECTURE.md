# 🏗️ Technical Architecture

## Overview

Sanctuary is a Flutter app designed as an interactive virtual room where users complete self-care tasks (hydration, journaling, focus work) and earn coins as rewards. All data persists locally using Hive.

---

## Tech Stack

- **Framework:** Flutter (Dart)
- **State Management:** Riverpod (Provider pattern)
- **Local Storage:** Hive (key-value database)
- **Code Generation:** build_runner (for JSON serialization and Hive adapters)
- **UI:** Material Design with custom isometric positioning

---

## Architecture Layers

### 1. **Models Layer** (`lib/models/`)
- `journal_entry.dart` - Journal entry data (title, content, date)
- `todo_item.dart` - Todo task (title, completed status, date)
- `user_stats.dart` - User stats (coins earned, water checks, streak)

All models use JSON serialization via `build_runner` (`.g.dart` files auto-generated).

### 2. **State Management** (`lib/providers/`)
- `user_stats_provider.dart` - Manages coins, streaks, daily stats
- `todo_provider.dart` - Manages today/tomorrow todo lists
- `journal_provider.dart` - Manages journal entries (placeholder)
- `timer_provider.dart` - Manages focus mode timer (placeholder)

**State Pattern:** Riverpod `StateNotifier` wraps Hive boxes for reactive updates.

### 3. **Persistence Layer** (Hive)
- Boxes: `user_stats`, `todos`, `journal_entries`
- Data syncs with Riverpod providers on app startup
- No network calls—completely offline

### 4. **UI Layer** (`lib/screens/` & `lib/widgets/`)

#### Main Screen: `room_screen.dart`
- Isometric room with 7 interactive elements
- Each element (laptop, plushie, mirror, etc.) triggers a dialog or modal
- Uses `Stack` with `Positioned` widgets for precise layering

#### Key Widgets:
- `IsometricObject` - Custom positioning helper for room elements
- `TodoModal` - Todo list UI with add/delete/complete actions
- Room object widgets (bed, laptop, plushie, etc.)

#### Focus Mode: `focus_mode_screen.dart`
- Full-screen distraction-free view (placeholder)

### 5. **Constants & Utilities** (`lib/core/`)
- `app_colors.dart` - Centralized color palette
- `affirmations.dart` - Daily affirmation strings
- `isometric_helper.dart` - Positioning calculations

---

## Data Flow

```
User Interaction (tap event)
  ↓
Room Screen calls dialog/modal
  ↓
Modal updates Riverpod provider (e.g., mark todo complete)
  ↓
Provider writes to Hive box
  ↓
UI rebuilds reactively
  ↓
Coins counter & UI reflect changes
```

---

## Key Features Implementation

### ✅ Todo Management
- **Add:** User types task → Provider stores in Hive → List rebuilds
- **Complete:** User checks box → Coins += 10 → Confetti animation
- **Delete:** Swipe left → Remove from Hive → List updates

### 💧 Water Check
- **Once per day limit:** UserStats tracks last check date
- **Yes → +10 coins:** Provider adds coins to user_stats box
- **No → Encouragement:** Modal shows encouraging message

### ✨ Affirmations
- Random quote fetched from `affirmations.dart`
- Simple dialog display, no persistence needed

### 🪞 Mirror & Interactive Elements
- Gesture detection on images
- Each element mapped to a specific callback (`_showTodoModal`, `_showWaterCheckDialog`, etc.)
- Modal/dialog UX for user interaction

### 💰 Coin Persistence
- Coins stored in `user_stats` Hive box
- Loaded on app startup via Riverpod
- Updated whenever user completes task or checks water

---

## Build & Codegen

**Build Process:**
```bash
flutter pub run build_runner build
```

This generates:
- `.g.dart` files for JSON serialization
- Hive adapters for data models
- Type-safe getters/setters

**Rebuild on Changes:**
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

---

## File Structure Deep Dive

```
lib/
├── main.dart                            # App root, theme setup
├── screens/
│   ├── room_screen.dart                 # Main interactive sanctuary
│   └── focus_mode_screen.dart           # Full-screen focus mode
├── models/
│   ├── journal_entry.dart + .g.dart
│   ├── todo_item.dart + .g.dart
│   └── user_stats.dart + .g.dart
├── providers/
│   ├── journal_provider.dart
│   ├── timer_provider.dart
│   ├── todo_provider.dart
│   └── user_stats_provider.dart
├── widgets/
│   ├── bed/                             # Bed widget group
│   ├── laptop/                          # Laptop & todo modal
│   ├── room/                            # Room background & overlays
│   ├── shelf/                           # Shelf widget
│   └── window/                          # Window widget
├── services/                            # (Placeholder for future services)
├── core/
│   ├── constants/
│   │   ├── app_colors.dart
│   │   └── affirmations.dart
│   ├── theme/                           # (Theme configuration)
│   └── utils/
│       └── isometric_helper.dart
└── assets/                              # Images & icons
    └── images/
        ├── room/
        └── ui/
```

---

## State Management Pattern (Riverpod)

Example: `user_stats_provider.dart`

```dart
final userStatsProvider = StateNotifierProvider<UserStatsNotifier, UserStats>((ref) {
  return UserStatsNotifier();
});

class UserStatsNotifier extends StateNotifier<UserStats> {
  UserStatsNotifier() : super(initialState) {
    // Load from Hive on init
    _loadStats();
  }
  
  void addCoins(int amount) {
    state = state.copyWith(totalCoins: state.totalCoins + amount);
    // Save to Hive
    _saveStats();
  }
}
```

**Pattern Benefits:**
- Immutable state updates (copyWith)
- Reactive rebuilds via `ref.watch()`
- Centralized logic in notifiers

---

## Hive Storage Schema

| Box Name | Key | Value Type | Purpose |
|----------|-----|-----------|---------|
| `user_stats` | Single record | `UserStats` | Coins, water check date, streaks |
| `todos` | Date string | `List<TodoItem>` | Tasks for today/tomorrow |
| `journal_entries` | Entry ID | `JournalEntry` | Journal entries (placeholder) |

---

## Future Extensions

- **Focus Timer:** `timer_provider.dart` ready for Pomodoro integration
- **Journal:** `journal_provider.dart` scaffolding complete
- **Cloud Sync:** Add Firebase for cross-device sync
- **Animations:** Confetti, transitions already structured
- **Dark Mode:** Theme layer supports easy switching

---

## Dependencies

```yaml
flutter_riverpod: ^2.x           # State management
hive: ^2.x                       # Local database
hive_flutter: ^1.x               # Hive Flutter integration
build_runner: ^2.x               # Code generation
json_serializable: ^6.x           # JSON serialization
```

---

**This architecture prioritizes simplicity, offline-first design, and scalability.** 🏡✨
