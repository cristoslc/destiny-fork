# Musing: macOS Apple Silicon Build Readiness

## Status: Not Ready — Explicitly Blocked

The macOS build is **not ready for Apple Silicon (arm64)**. Three independent mechanisms block it:

### 1. Xcode project excludes arm64

`macos/Runner.xcodeproj/project.pbxproj` sets `EXCLUDED_ARCHS = arm64` in all three configurations (Debug, Release, Profile). This means Xcode will never produce an arm64 slice — only x86_64.

### 2. Info.plist prefers x86_64

`macos/Runner/Info.plist` has `LSArchitecturePriority` set to `x86_64` and `LSRequiresNativeExecution` set to `<false/>`. This tells macOS to run the app under Rosetta 2 on Apple Silicon hardware.

### 3. README documents the gap

`README.md:116` explicitly states: "MacOS M1/M2 (arm64) chip build is not supported yet."

## What would need to change

### Go layer (wormhole-william) — already ready

`dart_wormhole_william/wormhole-william/build_release.go:97` includes `{"darwin", "arm64", ""}` as a build target. The Go library can cross-compile for darwin/arm64. No work needed here.

### Flutter SDK — NOT a blocker (corrected)

Earlier analysis was wrong. The Flutter SDK now ships arm64 macOS artifacts. Key issues are CLOSED:

| Issue | Status |
|-------|--------|
| #60113 — ARM macOS target umbrella | **CLOSED** |
| #69157 — macOS artifacts with ARM slice | **CLOSED** |
| #101138 — gen_snapshot as arm64 binary | **CLOSED** |
| #69221 — FlutterMacOS.framework arm64 | **CLOSED** |
| #175320 — Debugging fails on arm64 | **SOLVED** |
| #103386 — Engine build without Rosetta | **OPEN (P2)** — only affects engine *contributors* |

The only still-open issue (#103386) is about building the Flutter *engine itself* without Rosetta — this affects engine contributors, not app developers. App developers using the prebuilt Flutter SDK can build arm64 macOS apps today.

### What needs to change (Destiny project only)

1. Remove `EXCLUDED_ARCHS = arm64` from all three Xcode build configs in `project.pbxproj`
2. Change `LSArchitecturePriority` from `x86_64` to `arm64` (or remove for universal)
3. Update README known-issues
4. CI: switch from `macos-latest` (Intel) to `macos-14` (Apple Silicon) runners, or cross-compile
5. The `dart_wormhole_william` macOS CMake build may need `GOARCH=arm64` passed for the Go library

### Build complexity

The Go → C → Dart FFI chain requires all three layers to match architecture. This is the same pattern already solved for Android (arm64-v8a) and iOS (arm64). For universal binaries, the Go library would need to be compiled twice and lipo'd together.

## Tahoe (macOS version codename)

"Tahoe" is the macOS version codename. The trove at `docs/troves/destiny-macos-arm64/` has the full research — see `synthesis.md` for the thematic distillation across 12 sources.

**Bottom line:** The Go layer already supports darwin/arm64. The Flutter SDK is ready (all relevant issues closed). The only blockers are in Destiny's own project configuration: `EXCLUDED_ARCHS = arm64` in Xcode, `LSArchitecturePriority = x86_64` in Info.plist, and CI runner selection. This is a straightforward fix — no upstream dependencies remain.
