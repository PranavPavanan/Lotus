# 🗺️ Room Layout Reference

## Isometric Room Object Positions

This diagram shows the current placeholder positions. Use this as a reference when adjusting coordinates or placing your hand-drawn assets.

```
                    📱 Coin Counter (Top-Right)
                         💰 [Coins: XX]

     ┌─────────────────────────────────────────┐
     │                                         │
     │                                         │
     │    🪞                  🪟               │
     │  Mirror            Window               │
     │   (0.05,           (0.35,               │
     │    0.25)            0.1)                │
     │                                         │
     │                                         │
     │                                         │
     │             📚 Shelf                    │
     │            (0.5, 0.45)                  │
     │                                         │
     │   🛏️ Bed                                │
     │  (0.05,                                 │
     │   0.55)                                 │
     │     🧸                                   │
     │   Plushie           🪑 Study Desk       │
     │   (0.15,            (0.55, 0.6)         │
     │    0.62)                                │
     │                        💻 Laptop        │
     │                       (0.62, 0.67)      │
     │                                         │
     │                                         │
     │                                         │
     └─────────────────────────────────────────┘
```

## Object Details

### 1. **Mirror** 🪞
- **Position:** Far left wall
- **Fractional Coords:** `(0.05, 0.25)` 
- **Size:** `(0.15, 0.25)`
- **Action:** Tap → Random affirmation dialog

### 2. **Window** 🪟
- **Position:** Back wall, centered above bed
- **Fractional Coords:** `(0.35, 0.1)`
- **Size:** `(0.3, 0.3)`
- **Action:** Tap → Navigate to Focus Mode screen

### 3. **Bed** 🛏️
- **Position:** Center-left floor area
- **Fractional Coords:** `(0.05, 0.55)`
- **Size:** `(0.4, 0.25)`
- **Action:** Visual only (no direct tap)

### 4. **Plushie** 🧸
- **Position:** On the bed
- **Fractional Coords:** `(0.15, 0.62)`
- **Size:** `(0.15, 0.1)`
- **Action:** Tap → Water check dialog

### 5. **Shelf** 📚
- **Position:** Horizontal, above table area
- **Fractional Coords:** `(0.5, 0.45)`
- **Size:** `(0.45, 0.1)`
- **Action:** Tap → Journal sheet (placeholder)

### 6. **Study Desk** 🪑
- **Position:** Right floor area
- **Fractional Coords:** `(0.55, 0.6)`
- **Size:** `(0.4, 0.25)`
- **Action:** Visual only (no direct tap)

### 7. **Laptop** 💻
- **Position:** On the study desk
- **Fractional Coords:** `(0.62, 0.67)`
- **Size:** `(0.25, 0.12)`
- **Action:** Tap → To-Do list modal

### 8. **Coin Counter** 💰
- **Position:** Fixed top-right overlay
- **Action:** Display only (no tap)

---

## Fractional Coordinate System

All positions use **fractional coordinates** (0.0 to 1.0) relative to screen dimensions:

```
(0.0, 0.0)  ←─────────── Screen Width ─────────→  (1.0, 0.0)
     ↓                                                  ↓
     │                                                  │
     │                                                  │
 Screen                                             Screen
 Height                                             Height
     │                                                  │
     │                                                  │
     ↓                                                  ↓
(0.0, 1.0)  ←─────────── Screen Width ─────────→  (1.0, 1.0)
```

### Example: Laptop Position
```dart
IsometricObject(
  leftFraction: 0.62,   // 62% from left edge
  topFraction: 0.67,    // 67% from top edge
  widthFraction: 0.25,  // 25% of screen width
  heightFraction: 0.12, // 12% of screen height
  child: // Your widget
)
```

---

## Adjusting Positions for Your Assets

When you add your hand-drawn PNGs, you'll likely need to adjust these coordinates:

### 1. **Find the object** in `lib/screens/room_screen.dart`
   - Search for the label (e.g., "Laptop")
   - Lines 35-230 contain all object definitions

### 2. **Tweak the fractions**
   - Increase `leftFraction` → Move right
   - Decrease `leftFraction` → Move left
   - Increase `topFraction` → Move down
   - Decrease `topFraction` → Move up

### 3. **Adjust size**
   - Increase `widthFraction` → Wider object
   - Increase `heightFraction` → Taller object

### 4. **Hot Reload**
   - Save the file
   - Press `r` in the terminal to see changes instantly

---

## Layer Order (Z-Index)

Objects are rendered in the order they appear in the `Stack` widget:
1. **Background** (bottom layer)
2. **Bed** (under other objects)
3. **Mirror** (back wall)
4. **Window** (back wall)
5. **Shelf** (mid-layer)
6. **Table** (mid-layer)
7. **Laptop** (top of table)
8. **Plushie** (top of bed)
9. **Coin Counter** (overlay, always on top)

To change the stacking order, rearrange the `IsometricObject` widgets in `room_screen.dart`.

---

## Recommended Asset Dimensions

For best quality, prepare your PNG assets at these approximate sizes:

| Object | Recommended Size | Notes |
|--------|------------------|-------|
| Background | 1080x2340 | Full portrait screen |
| Window | 512x512 | Square for symmetry |
| Bed | 800x600 | Wide horizontal |
| Table | 800x600 | Wide horizontal |
| Mirror | 300x600 | Tall vertical |
| Shelf | 900x200 | Wide, thin horizontal |
| Laptop | 400x300 | Small, centered |
| Plushie | 300x300 | Small, cute |

All assets should use **transparent backgrounds** (RGBA PNGs).

---

## Testing on Different Screen Sizes

The fractional system ensures objects scale proportionally, but test on:
- **Small phones** (iPhone SE, Pixel 4a)
- **Large phones** (iPhone 15 Pro Max, Galaxy S24 Ultra)
- **Tablets** (iPad Pro - optional, but nice to check)

Run `flutter run -d <device-id>` to test on specific devices.

---

**Need to see the code?** → Open `lib/screens/room_screen.dart` (lines 35-230)
