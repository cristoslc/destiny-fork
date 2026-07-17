# Musing: Upgrade to Flutter 3.44+ (Gradle Declarative Plugin Migration)

## Status

Half-formed. Captured for future reference.

## Context

We're currently pinned to Flutter 3.41.0 — the first version with Visual Studio 2026 support (`case 18 => 'Visual Studio 18 2026'` in `visual_studio.dart`). This gets Windows CI green on `windows-latest` runners which now ship VS 2026.

3.41 was chosen as a stopping point because Flutter 3.44 introduced a hard breaking change: the imperative Gradle plugin application (`apply from: flutter.gradle` / `apply plugin: 'com.android.application'`) is no longer allowed. Projects must migrate to the declarative `plugins {}` block.

## What 3.44 requires

### Android Gradle migration

**Before (current):**
```gradle
// android/build.gradle
buildscript {
    dependencies {
        classpath 'com.android.tools.build:gradle:7.2.2'
    }
}

// android/app/build.gradle
apply plugin: 'com.android.application'
apply plugin: 'kotlin-android'
apply from: "$flutterRoot/packages/flutter_tools/gradle/flutter.gradle"
```

**After (required):**
```gradle
// android/build.gradle
plugins {
    id 'dev.flutter.flutter-plugin-loader' version '1.0.0'
    id 'com.android.application' version '8.1.0' apply false
    id 'org.jetbrains.kotlin.android' version '1.9.10' apply false
}

// android/app/build.gradle
plugins {
    id 'com.android.application'
    id 'kotlin-android'
    id 'dev.flutter.flutter-plugin-loader'
}
```

### Other 3.44 breaking changes

- `BottomAppBarTheme` → `BottomAppBarThemeData` (already fixed, but may regress)
- `dialogBackgroundColor` → `DialogThemeData.backgroundColor`
- `WillPopScope` → `PopScope`
- `MaterialStateProperty` → `WidgetStateProperty`
- `withOpacity` → `withValues`
- `textScaleFactor` → `textScaler`
- Default value syntax: `:` → `=` in Dart 3.0+

### Plugin compatibility

- `file_picker ^5.2.4` references default implementations that newer Flutter warns about
- `wakelock` references `wakelock_windows` which may not exist as a plugin
- `package_info_plus ^3.1.0` has `package=` in AndroidManifest (AGP 8.x incompat)
- `desktop_drop ^0.4.0` compiled with Kotlin 1.9.0 (needs Kotlin 1.9.10+ in host project)

## Why not do it now

1. The Gradle migration touches `android/build.gradle`, `android/app/build.gradle`, and potentially every plugin's `android/build.gradle`
2. We'd need to bump AGP to 8.x, which requires `namespace` in every Android module
3. `pubspec.lock` dependency resolution may break with newer Flutter
4. This is a sashay-worthy task on its own — not a drive-by fix

## When to do it

When we're ready to take on the full Android Gradle migration as a dedicated sashay. The 3.41 → 3.44 jump is smaller than 3.22 → 3.44, but still non-trivial.

## References

- Flutter issue #176399: Add Support for VisualStudio 2026
- Flutter PR #177458: VS 2026 support merged Nov 1, 2025
- Flutter 3.44 release notes: Gradle declarative plugins block required