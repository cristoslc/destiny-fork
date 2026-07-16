# Pinned Dependency Forks

## expand_widget

- **Source:** `https://github.com/shareef-dweikat/expand_widget` @ `52dc9fa9cc62191de4724b46edae29143c18a059`
- **Issues:** Uses old `TextTheme` names (`bodyText2`, `caption`), uses removed `AnimatedSize(vsync:)` parameter
- **Impact:** Blocks Flutter 3.22+ migration
- **Remediation:** Check if upstream has a compatible version, or update the fork

## flutter-intro-slider

- **Source:** `https://github.com/shareef-dweikat/flutter-intro-slider` @ `bbc9df2a00b29d94445f5be548635b39f5fde3f3`
- **Issues:** Uses removed `SystemChrome.setEnabledSystemUIOverlays`
- **Impact:** Blocks Flutter 3.22+ migration
- **Remediation:** Check if upstream has a compatible version, or update the fork

## window_size

- **Source:** `https://github.com/google/flutter-desktop-embedding` @ `17d4710c17f4913137e7ec931f6e71eaef443363`
- **Issues:** May not be compatible with Flutter 3.22+
- **Impact:** Could block macOS desktop builds after migration
- **Remediation:** Check compatibility, or find alternative (e.g., `system_alert_window` or native method channels)

## win32

- **Source:** pub.dev `3.1.3`
- **Issues:** Uses removed `UnmodifiableUint8ListView` type
- **Impact:** Blocks Windows builds on Flutter 3.22+
- **Remediation:** Bump to latest compatible version
