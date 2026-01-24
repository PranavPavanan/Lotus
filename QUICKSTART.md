# 🚀 Quick Start Guide

## Run the App (3 Steps)

```bash
# 1. Get dependencies
flutter pub get

# 2. Generate Hive adapters
flutter pub run build_runner build

# 3. Run the app
flutter run
```

That's it! The app will launch in portrait mode.

---

## 🎮 How to Use The Sanctuary

### **💻 Laptop (Study Desk)**
**Tap to:** Open your To-Do list
- Switch between "Today" and "Tomorrow" tabs
- Type a task and press the + button
- Check the box to complete → Get +10 coins + confetti! 🎉
- Swipe left to delete a task

### **🧸 Plushie (On Bed)**
**Tap to:** Water check reminder
- Answer "Yes" to get +10 coins (once per day)
- Answer "No" for an encouraging message

### **🪞 Mirror (Left Wall)**
**Tap to:** Receive a daily affirmation
- Random motivational quote appears
- Tap "Thank you" to close

### **🪟 Window (Above Bed)**
**Tap to:** Enter Focus Mode
- Full-screen view (placeholder)
- Press back arrow to return

### **📚 Shelf (Above Table)**
**Tap to:** Journal (coming soon)
- Currently shows a "coming soon" message

### **💰 Coin Counter (Top-Right)**
- Shows your total earned coins
- Persists forever (saved locally)

---

## 📱 Recommended Test Flow

1. **Tap the Laptop** → Add 3 tasks to "Today"
2. Complete 1 task → Watch confetti + coin counter increase
3. **Tap the Plushie** → Answer "Yes" for water → Get +10 coins
4. **Tap the Mirror** → Read an affirmation
5. Close the app completely
6. Reopen → Verify your tasks and coins are still there

---

## 🎨 Adding Your Hand-Drawn Assets

See [ASSET_GUIDE.md](ASSET_GUIDE.md) for detailed instructions.

**TL;DR:**
1. Drop PNG files in `assets/images/room/`
2. Edit `lib/screens/room_screen.dart` to replace `Container` placeholders with `Image.asset()`
3. Hot reload to see changes

---

## 🐛 Troubleshooting

### "No Android SDK found"
- This is normal if you haven't set up Android Studio
- You can still run on iOS simulator or Chrome (web)
- To fix: Install Android Studio and set `ANDROID_HOME` environment variable

### "Hive box not found"
- Run: `flutter pub run build_runner build --delete-conflicting-outputs`
- Restart the app

### "Hot reload not working"
- Try hot restart: Press `Shift + R` in the terminal or `Ctrl/Cmd + Shift + F5` in VS Code

---

## 📖 Full Documentation

- **[README.md](README.md)** - Full app overview and roadmap
- **[BUILD_SUMMARY.md](BUILD_SUMMARY.md)** - Technical implementation details
- **[ASSET_GUIDE.md](ASSET_GUIDE.md)** - How to replace placeholders with your art

---

**Ready to build your cozy productivity sanctuary!** 🏡✨
