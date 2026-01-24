# 🎨 Asset Replacement Guide

## Current Status
The app is using **placeholder visuals** (colored containers + icons) for all room objects.

## Where to Place Your Hand-Drawn Assets

Drop your PNG files here:
```
assets/images/room/
├── background.png   (Full room base layer)
├── bed.png
├── table.png
├── mirror.png
├── window.png
├── clock.png
├── shelf.png
└── laptop.png
```

## How to Replace Placeholders

### Step 1: Add Your PNG Files
Place your hand-drawn isometric images in the `assets/images/room/` folder.

### Step 2: Edit room_screen.dart

Open `lib/screens/room_screen.dart` and replace the placeholder `Container` widgets with `Image.asset()`:

**Before (Placeholder):**
```dart
Container(
  decoration: BoxDecoration(
    color: Colors.grey.withOpacity(0.3),
    border: Border.all(color: Colors.grey, width: 2),
  ),
  child: const Icon(Icons.laptop, size: 40),
)
```

**After (Your Asset):**
```dart
Image.asset(
  'assets/images/room/laptop.png',
  fit: BoxFit.contain,
)
```

### Step 3: Adjust Positioning

Fine-tune the `leftFraction`, `topFraction`, `widthFraction`, and `heightFraction` values in each `IsometricObject` to match your asset's dimensions.

**Example:**
```dart
IsometricObject(
  leftFraction: 0.62,   // Adjust left position (0.0 = far left, 1.0 = far right)
  topFraction: 0.67,    // Adjust top position
  widthFraction: 0.25,  // Adjust width (relative to screen)
  heightFraction: 0.12, // Adjust height
  child: GestureDetector(
    onTap: () => _showTodoModal(context),
    child: Image.asset(
      'assets/images/room/laptop.png',
      fit: BoxFit.contain,
    ),
  ),
)
```

### Step 4: Hot Reload
Save the file and hot reload (`r` in terminal or save in IDE) to see changes instantly!

---

## Recommended Asset Specs

- **Format:** PNG with transparency
- **Resolution:** 512x512 to 1024x1024 per object (depending on size in room)
- **Background:** 1080x2340 (portrait ratio) for full room background
- **Color Depth:** 32-bit RGBA
- **Style:** Consistent isometric perspective across all objects

---

## Tips for Positioning

1. **Start with the background:** Make sure your empty room image fills the entire screen
2. **Layer from back to front:** Adjust objects furthest from the camera first
3. **Test on different devices:** Use `flutter run` on various screen sizes
4. **Use fractional coords:** This ensures responsive scaling across devices

---

## Testing Without Assets

The app is fully functional with placeholders! You can:
- Test all features immediately
- Get user feedback on UX/interactions
- Draw assets at your own pace
- Replace them incrementally (one object at a time)

---

**Need help?** Check `lib/screens/room_screen.dart` lines 35-230 for all object positions.
