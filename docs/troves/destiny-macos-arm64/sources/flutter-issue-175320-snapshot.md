# Source: Flutter issue #175320 — Debugging on Apple Silicon fails (CLOSED/SOLVED)

**URL:** https://github.com/flutter/flutter/issues/175320
**Fetch date:** 2026-07-15

## Verbatim excerpt

"Debugging on apple silicon for macos device fails". Filed Sep 2025, **closed as solved**.

The error was:

```
xcodebuild: error: Unable to find a device matching the provided destination specifier:
                { platform:macOS, arch:arm64 }
```

The available destination was only `{ platform:macOS, arch:x86_64 }`. This happened with Flutter 3.35.3 on macOS 15.6.1 with Xcode 16.4.

**Key takeaway:** This was a recent (Sep 2025) bug where `flutter run -d macos` failed on arm64. It's been solved. The fact that it was filed and fixed shows Flutter is actively working on arm64 macOS support.
