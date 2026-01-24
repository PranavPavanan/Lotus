# 📝 Changelog

All notable changes to The Sanctuary will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [Unreleased]

### To Do
- Focus Mode weather selector
- Focus Mode ambient sounds
- Focus Mode Pomodoro timer UI
- Journal bottom sheet implementation
- Task migration prompt dialog
- Sound effects
- Tutorial overlay

---

## [0.1.0-mvp] - 2026-01-14

### Added - Initial MVP Release
- **Core Architecture**
  - Riverpod 2.x state management
  - Hive local database with type-safe adapters
  - Portrait-locked orientation
  - Material 3 theme system
  - Isometric fractional positioning system

- **Features**
  - **Study Desk (Laptop)**: To-Do list with Today/Tomorrow tabs
    - Add, complete, and delete tasks
    - +10 coins per completed task
    - Confetti animation on completion
    - Swipe to delete functionality
  - **Plushie (Water Check)**: Daily hydration reminder
    - +10 coins for checking in (once per day)
    - Encouraging messages
  - **Mirror (Affirmations)**: 15 motivational quotes
    - Random selection on tap
  - **Window (Focus Mode)**: Navigation placeholder
    - Full-screen view (timer coming in Phase 2)
  - **Shelf (Journal)**: Interaction placeholder
    - Backend ready (UI coming in Phase 3)
  - **Coin System**: Persistent reward counter
    - Never resets, stored forever locally

- **Data Models**
  - TodoItem with Hive adapter
  - JournalEntry with Hive adapter
  - UserStats with Hive adapter

- **Providers**
  - todoProvider (CRUD operations)
  - userStatsProvider (coins, water check, daily resets)
  - journalProvider (ready for Phase 3)
  - timerProvider (ready for Phase 2)

- **Documentation**
  - README.md (full project overview)
  - BUILD_SUMMARY.md (technical details)
  - QUICKSTART.md (run guide)
  - ASSET_GUIDE.md (placeholder replacement)
  - LAYOUT_REFERENCE.md (object positions)
  - DEVELOPER_NOTES.md (architecture decisions)
  - PROJECT_STATUS.md (completion tracking)

### Technical
- Placeholder visuals using colored containers + icons
- Fractional coordinate system (0.0-1.0) for responsive scaling
- Portrait-mode lock enforced
- Asset paths pre-configured for hand-drawn PNGs

### Known Issues
- Timer doesn't persist on app kill (no coins awarded) - Phase 2
- No task migration prompt yet - Phase 4
- 12 deprecation warnings for `withOpacity` (cosmetic)

---

## Version History Guidelines

### Version Numbering
- **Major (X.0.0)**: Breaking changes, major rewrites
- **Minor (0.X.0)**: New features, Phase completions
- **Patch (0.0.X)**: Bug fixes, minor improvements

### Categories
- **Added**: New features
- **Changed**: Changes to existing features
- **Deprecated**: Soon-to-be-removed features
- **Removed**: Removed features
- **Fixed**: Bug fixes
- **Security**: Vulnerability patches

---

## Future Planned Versions

### [0.2.0] - Phase 2: Focus Mode
- Weather selector (Rainy, Winter, Summer, Spring)
- Ambient sound playback
- Pomodoro timer with clock interaction
- Screen wake lock
- Timer persistence/abandonment handling

### [0.3.0] - Phase 3: Journal
- Bottom sheet UI
- Mood selector (Happy, Neutral, Sad)
- Text input with character limit
- Date-based entry storage
- View past entries

### [0.4.0] - Phase 4: Task Migration
- Daily uncompleted task detection
- Migration prompt dialog
- Move/Delete options

### [0.5.0] - Phase 5: Polish
- Sound effects
- Smooth animations
- Tutorial overlay
- Settings screen
- Data export

### [1.0.0] - Public Release
- All MVP features complete
- Real hand-drawn assets integrated
- Beta tested
- App Store / Play Store ready

### [2.0.0] - Cloud Sync
- User accounts
- Backend integration (Firebase/Supabase)
- Cross-device synchronization
- Cloud backup

---

## Development Notes

- MVP development started: January 14, 2026
- Lead Developer: Senior Flutter Developer
- Tech Stack: Flutter 3.10.7, Dart 3.10.0, Riverpod 2.x, Hive 2.x

---

*Keep this file updated with each release!*
