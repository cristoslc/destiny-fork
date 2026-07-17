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

## Approach

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

### Step 5: Verify

```bash
fvm flutter build macos --debug
lipo -info build/macos/Build/Products/Debug/Destiny.app/Contents/MacOS/Destiny
# Expected: architecture: arm64
```

## Risk

- Pinned dependency forks (`expand_widget`, `flutter-intro-slider`) may need upstream updates or replacement
- `window_size` plugin from `google/flutter-desktop-embedding` may have compatibility issues
- Full build can only be verified on Apple Silicon hardware or `macos-14` CI runner
