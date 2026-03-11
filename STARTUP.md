# 🚀 Sanctuary - Startup Guide

## Prerequisites
- Flutter SDK installed
- Android/iOS emulator or physical device (optional - web also works)

## Quick Start (3 Commands)

```bash
# 1. Install dependencies
flutter pub get

# 2. Generate Hive adapters (local storage)
flutter pub run build_runner build

# 3. Run the app
flutter run
```

That's it! The app launches in portrait mode.

---

## 🎮 Interactive Elements

### **💻 Laptop (Study Desk)**
Tap to open your To-Do list
- Switch between "Today" and "Tomorrow" tabs
- Add tasks and mark them complete to earn coins
- Swipe left to delete tasks

### **🧸 Plushie (On Bed)**
Tap for daily water reminder
- Answer to earn +10 coins (once per day)

### **🪞 Mirror (Left Wall)**
Tap to receive a daily affirmation

### **🪟 Window (Above Bed)**
Tap to enter Focus Mode (full-screen placeholder)

### **📚 Shelf (Above Table)**
Tap to access Journal (coming soon)

### **💰 Coin Counter (Top-Right)**
Shows your earned coins (persistent across sessions)

---

## ⚡ Key Commands

| Command | Purpose |
|---------|---------|
| `flutter run` | Launch app |
| `flutter pub get` | Install dependencies |
| `flutter pub add <package>` | Add new dependency |
| `flutter clean` | Clean build artifacts |
| `flutter pub run build_runner build` | Regenerate Hive adapters |

---

## 💾 Data Persistence

All user data (tasks, coins, stats) is saved locally using Hive—a fast, offline-first database. No internet required.

---

## 📁 Project Structure

```
lib/
├── main.dart                 # App entry point
├── screens/                  # UI screens
│   ├── room_screen.dart      # Main sanctuary view
│   └── focus_mode_screen.dart
├── providers/                # Riverpod state management
├── models/                   # Data models (JSON serialized)
├── widgets/                  # Reusable UI components
├── core/                     # Constants, themes, utilities
└── services/                 # Business logic
```

---

**Ready to build your cozy sanctuary!** 🏡✨
