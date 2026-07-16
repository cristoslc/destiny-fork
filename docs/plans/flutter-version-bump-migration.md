# Plan: Flutter Version Bump + Dart API Migration

## Status

Phase 1 (infrastructure) is committed on `tahoe/apple-silicon`. This plan covers Phase 2.

## Problem

The codebase is pinned to Flutter 3.3.10 (Dart <3.4.0). Modern Flutter (3.22.x+) is needed for stable arm64 macOS target support, but introduces breaking API changes:

### TextTheme migration (Flutter 3.22)

| Old name | New name |
|---|---|
| `headline1` | `displayLarge` |
| `headline2` | `displayMedium` |
| `headline3` | `displaySmall` |
| `headline4` | `headlineLarge` |
| `headline5` | `headlineMedium` |
| `headline6` | `headlineSmall` |
| `subtitle1` | `titleLarge` |
| `subtitle2` | `titleMedium` |
| `bodyText1` | `bodyLarge` |
| `bodyText2` | `bodyMedium` |
| `caption` | `bodySmall` |

### Removed APIs

- `SystemChrome.setEnabledSystemUIOverlays` — used by `flutter-intro-slider` dependency
- `BottomAppBarTheme` → `BottomAppBarThemeData`
- `AnimatedSize(vsync:)` — parameter removed
- `TextTheme.backgroundColor` — removed

### Dependency issues

- `win32-3.1.3` uses removed `UnmodifiableUint8ListView` — needs version bump
- `expand_widget` pinned fork uses old `TextTheme` names and `AnimatedSize(vsync:)`
- `flutter-intro-slider` pinned fork uses `SystemChrome.setEnabledSystemUIOverlays`

## Test strategy

Existing coverage is thin (6 unit tests, 3 integration tests) and doesn't cover the ~40 UI files being migrated. The TextTheme rename is mechanical but risky — a missed rename compiles but renders wrong.

### Coverage matrix

| Path | Existing tests | Migration safety |
|------|---------------|-----------------|
| `lib/config/theme/custom_theme.dart` | None | Compiler catches wrong names |
| `lib/views/desktop/` (14 files) | None | Compiler catches wrong names |
| `lib/views/mobile/` (18 files) | None | Compiler catches wrong names |
| `lib/widgets/` (4 files) | `prefs_edit_test.dart` | Compiler catches wrong names |
| `lib/views/desktop//widgets/DTFileInfo.dart` | None | Compiler catches wrong names |
| Pinned deps (`expand_widget`, `flutter-intro-slider`) | None | Must verify manually |

The Dart compiler catches any TextTheme name that doesn't exist — a missed rename produces a compile error, not a silent bug. The risk is not missed renames but *wrong* renames (e.g., mapping `headline1` to the wrong new name). Snapshot/golden tests on key screens would catch rendering regressions.

### Snapshot test plan

Write golden tests for the 4 key screens before migration, then verify they still render identically after:

1. **Send screen** — `lib/views/desktop/send/` (desktop) and `lib/views/mobile/send/` (mobile)
2. **Receive screen** — `lib/views/desktop/receive/` and `lib/views/mobile/receive/`
3. **Settings screen** — `lib/views/desktop/settings.dart`
4. **Info screen** — `lib/views/mobile/Info.dart`

Each golden test renders the widget tree, captures a screenshot, and compares against the stored golden. After migration, the goldens are updated if the visual output is correct.

## Approach

### Step 0: Write snapshot tests (before migration)

Write golden tests for the 4 key screens. Run them to establish baselines. Commit the goldens.

### Step 1: Bump CI Flutter pin

`.github/workflows/build.yml`: `FLUTTER_VERSION: "3.3.10"` → `"3.22.3"`

### Step 2: TextTheme rename (bulk)

Files to update (from build errors):
- `lib/config/theme/custom_theme.dart`
- `lib/views/desktop/receive/receive.dart`
- `lib/views/desktop/receive/widgets/DTReceiveConfirmation.dart`
- `lib/views/desktop/receive/widgets/DTReceiveProgress.dart`
- `lib/views/desktop/receive/widgets/DTReceivingDone.dart`
- `lib/views/desktop/send/widgets/DTCodeGeneration.dart`
- `lib/views/desktop/send/widgets/DTDropAFile.dart`
- `lib/views/desktop/send/widgets/DTErrorUI.dart`
- `lib/views/desktop/send/widgets/DTSelectAFile.dart`
- `lib/views/desktop/send/widgets/DTSendingDone.dart`
- `lib/views/desktop/send/widgets/DTSendingProgress.dart`
- `lib/views/desktop/send/widgets/DTButtonLinearGradientWithIcon.dart`
- `lib/views/desktop/send/widgets/DTRowGroupButton.dart`
- `lib/views/desktop/settings.dart`
- `lib/views/desktop/widgets/DTButton.dart`
- `lib/views/desktop/widgets/DTButtonWithBackground.dart`
- `lib/views/desktop/widgets/DTFileInfo.dart`
- `lib/views/desktop/widgets/DTInfo.dart`
- `lib/views/desktop/widgets/NavbarTap.dart`
- `lib/views/mobile/Info.dart`
- `lib/views/mobile/receive/receive.dart`
- `lib/views/mobile/receive/widgets/EnterCode.dart`
- `lib/views/mobile/receive/widgets/ReceiveConfirmation.dart`
- `lib/views/mobile/receive/widgets/ReceiveProgress.dart`
- `lib/views/mobile/receive/widgets/ReceivingDone.dart`
- `lib/views/mobile/send/widgets/CodeGeneration.dart`
- `lib/views/mobile/send/widgets/RowGroupButtons.dart`
- `lib/views/mobile/send/widgets/SelectAFileUI.dart`
- `lib/views/mobile/send/widgets/SendingDone.dart`
- `lib/views/mobile/send/widgets/SendingProgress.dart`
- `lib/views/mobile/widgets/BottomBarTap.dart`
- `lib/views/mobile/widgets/ErrorUI.dart`
- `lib/views/mobile/widgets/FileInfo.dart`
- `lib/views/mobile/widgets/buttons/Button.dart`
- `lib/views/mobile/widgets/buttons/ButtonLinearGradientWithIcon.dart`
- `lib/views/mobile/widgets/buttons/ButtonWithBackground.dart`
- `lib/views/mobile/widgets/buttons/ButtonWithIcon.dart`
- `lib/views/mobile/widgets/custom-app-bar.dart`
- `lib/widgets/ExpandableTextBox.dart`
- `lib/widgets/buttons/Button.dart`
- `lib/widgets/prefs_edit.dart`
- `lib/views/desktop//widgets/DTFileInfo.dart` (duplicate path)

### Step 3: Fix custom_theme.dart

- `BottomAppBarTheme(...)` → `BottomAppBarThemeData(...)`
- `headline1` → `displayLarge` (and all other renames)
- Remove `backgroundColor:` parameter

### Step 4: Fix or replace pinned dependencies

- `expand_widget` fork — needs update for `AnimatedSize(vsync:)` removal and TextTheme renames
- `flutter-intro-slider` fork — needs update for `SystemChrome.setEnabledSystemUIOverlays` removal
- `win32` — bump from `3.1.3` to compatible version

### Step 5: Update snapshot goldens

Run the golden tests. If the visual output is correct, update the golden files. If not, fix the migration.

### Step 6: Verify

```bash
fvm flutter build macos --debug
lipo -info build/macos/Build/Products/Debug/Destiny.app/Contents/MacOS/Destiny
# Expected: architecture: arm64
```

## Risk

- Pinned dependency forks (`expand_widget`, `flutter-intro-slider`) may need upstream updates or replacement
- `window_size` plugin from `google/flutter-desktop-embedding` may have compatibility issues
- Golden tests require a display server (not available in headless CI) — may need to run locally or use `flutter test --platform chrome` for widget tests
- Full build can only be verified on Apple Silicon hardware or `macos-14` CI runner
