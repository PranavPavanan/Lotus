# 🏡 The Sanctuary - Cozy Productivity App

A Flutter-based MVP for a gamified to-do list inside an isometric virtual bedroom.

## 📱 Current Features (MVP - Phase 1)

### ✅ **Study Desk (Laptop)**
- **Tap the laptop** to open the Productivity Hub
- To-Do list with **Today** and **Tomorrow** tabs
- Add, complete, and delete tasks
- **+10 coins** per completed task with confetti animation 🎉
- Swipe to delete tasks

### 🪟 **Window (Focus Mode)**
- **Tap the window** to enter full-screen view
- Placeholder for weather controls and Pomodoro timer *(coming in Phase 2)*

### 🧸 **Plushie on Bed (Water Check)**
- **Tap the plushie** to get a water reminder
- "Have you had water today?"
- **+10 coins** for checking in (once per day limit)

### 🪞 **Mirror (Daily Affirmation)**
- **Tap the mirror** to receive a random motivational affirmation
- 15 pre-loaded affirmations

### 📚 **Shelf (Journal)** *(Placeholder)*
- Tapping shows "coming soon" message
- Will be implemented in Phase 3

### 💰 **Coin System**
- Persistent coin counter (top-right)
- Earn coins through task completion and water check
- Stored forever in local Hive database

---

## 🛠️ Tech Stack

| Component | Technology |
|-----------|------------|
| **Framework** | Flutter 3.10+ |
| **State Management** | Riverpod 2.x |
| **Local Storage** | Hive (offline-first) |
| **UI Enhancements** | Confetti package |
| **Orientation** | Portrait-locked |

---

## 📂 Project Structure

```
lib/
├── core/
│   ├── constants/
│   │   ├── app_colors.dart         # Color palette
│   │   ├── asset_paths.dart        # Asset references
│   │   └── affirmations.dart       # Daily affirmations list
│   ├── theme/
│   │   └── app_theme.dart          # Material theme
│   └── utils/
│       └── isometric_helper.dart   # Positioning system
├── models/
│   ├── todo_item.dart              # Todo model + Hive adapter
│   ├── journal_entry.dart          # Journal model + Hive adapter
│   └── user_stats.dart             # User stats model + Hive adapter
├── providers/
│   ├── todo_provider.dart          # Todo state management
│   ├── user_stats_provider.dart    # Coins, water check state
│   ├── journal_provider.dart       # Journal state
│   └── timer_provider.dart         # Pomodoro timer state
├── screens/
│   ├── room_screen.dart            # Main isometric room view
│   └── focus_mode_screen.dart      # Full-screen window view
├── widgets/
│   ├── laptop/
│   │   └── todo_modal.dart         # To-Do list dialog
│   └── (other feature widgets)
├── services/                       # (Future: API/cloud sync)
└── main.dart                       # App entry point
```

---

## 🎨 Asset Setup

**Your hand-drawn isometric assets should go here:**

```
assets/
└── images/
    └── room/
        ├── background.png      # Empty room base layer
        ├── bed.png
        ├── table.png
        ├── mirror.png
        ├── window.png
        ├── clock.png
        ├── shelf.png
        └── laptop.png
```

**Current State:** The app uses colored placeholder containers with icons. Simply replace them by:
1. Dropping your PNG files in `assets/images/room/`
2. Adjusting the `IsometricObject` fractional positions in [room_screen.dart](lib/screens/room_screen.dart)

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.10+
- Dart 3.0+
- Android Studio / Xcode (for emulators)

### Installation

```bash
# 1. Navigate to project
cd home

# 2. Install dependencies
flutter pub get

# 3. Generate Hive adapters
flutter pub run build_runner build

# 4. Run the app
flutter run
```

---

## 📐 Isometric Positioning System

Objects are positioned using **fractional coordinates** (0.0-1.0) for responsive scaling:

```dart
IsometricObject(
  leftFraction: 0.62,   // 62% from left edge
  topFraction: 0.67,    // 67% from top edge
  widthFraction: 0.25,  // 25% of screen width
  heightFraction: 0.12, // 12% of screen height
  child: // Your widget
)
```

**To adjust positions when adding real assets:**
- Edit the values in [room_screen.dart](lib/screens/room_screen.dart) (lines ~35-230)
- Hot reload to see changes instantly

---

## 🔮 Roadmap

### **Phase 2: Focus Mode (Window Feature)**
- [ ] Weather selector (Rainy, Winter, Summer, Spring)
- [ ] Ambient sound integration
- [ ] Pomodoro timer with clock interaction
- [ ] Screen wake lock during focus sessions

### **Phase 3: Journal (Shelf Feature)**
- [ ] Journal entry bottom sheet
- [ ] Mood selector (Happy, Neutral, Sad)
- [ ] Date-based entry storage
- [ ] Calendar view for past entries

### **Phase 4: Daily Task Migration**
- [ ] Prompt on new day: "Move yesterday's tasks to today?"
- [ ] Automatic archival system

### **Phase 5: Polish**
- [ ] Replace placeholders with real assets
- [ ] Add smooth animations
- [ ] Sound effects
- [ ] Tutorial overlay for first-time users

### **V2.0: Cloud Sync**
- [ ] Backend integration (Firebase/Supabase)
- [ ] Cross-device synchronization
- [ ] User accounts

---

## 🐛 Known Issues / Notes

- **Deprecation warnings:** `withOpacity` is deprecated in Flutter 3.10+. These are cosmetic and don't affect functionality. Will migrate to `.withValues()` in a future update.
- **Timer persistence:** Currently resets on app kill (no coins awarded). Background task handling will be added in Phase 2.

---

## 🤝 Contributing

This is a personal MVP project. Feel free to fork and adapt!

---

## 📄 License

MIT License - See LICENSE file for details.

---

## 🎯 Design Philosophy

> "The Sanctuary is about **gentle productivity**—a space where completing tasks feels rewarding, not stressful. Every interaction is designed to be cozy, forgiving, and motivating."

- **No streaks** (reduces pressure)
- **No punishments** (only rewards)
- **Offline-first** (always accessible)
- **Handcrafted aesthetic** (personal touch)

---

**Built with 💙 for cozy productivity.**
