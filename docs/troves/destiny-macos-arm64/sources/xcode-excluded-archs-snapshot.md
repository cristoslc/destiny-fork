# Source: Xcode project — EXCLUDED_ARCHS

**URL:** Local file `macos/Runner.xcodeproj/project.pbxproj`
**Fetch date:** 2026-07-15

## Verbatim excerpt

All three build configurations (Debug, Release, Profile) set:

```
EXCLUDED_ARCHS = arm64;
```

This explicitly prevents Xcode from compiling any arm64 slice for the macOS target. The app will only produce x86_64 binaries.

Additionally, `macos/Runner/Info.plist` sets:

```xml
<key>LSArchitecturePriority</key>
<string>x86_64</string>
<key>LSRequiresNativeExecution</key>
<false/>
```

This tells macOS to prefer x86_64 and allows Rosetta 2 translation on Apple Silicon hardware.
