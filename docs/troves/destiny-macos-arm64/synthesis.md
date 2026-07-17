# Synthesis: Destiny macOS Apple Silicon (Tahoe) Readiness

## Key Findings

**Destiny's macOS build is not ready for native Apple Silicon.** It runs under Rosetta 2 via three independent blockers, all in Destiny's own project configuration:

1. **Xcode explicitly excludes arm64** — `EXCLUDED_ARCHS = arm64` in all build configs
2. **Info.plist prefers x86_64** — `LSArchitecturePriority` set to x86_64
3. **README documents the gap** — "MacOS M1/M2 (arm64) chip build is not supported yet"

## What's Already Working

- **Go layer** (`wormhole-william`) already targets `darwin/arm64` in its build matrix
- **Flutter SDK now ships arm64 macOS artifacts** — issues #60113, #69157, #101138, and #69221 are all CLOSED. FlutterMacOS.framework includes arm64. gen_snapshot_arm64 is compiled as arm64. The Flutter SDK is NOT a blocker.
- **Rosetta 2 works** — the x86_64 build runs fine on Apple Silicon, just not natively

## What Needs to Change

### Easy fixes (in this repo only)

1. Remove `EXCLUDED_ARCHS = arm64` from all three Xcode build configs in `project.pbxproj`
2. Update `LSArchitecturePriority` to `arm64` (or remove for universal binary)
3. Update README known-issues

### CI changes

- Current CI runs on `macos-latest` (Intel x86_64). For native arm64 builds, switch to `macos-14` (Apple Silicon) runners
- For universal binaries: build twice (amd64 + arm64), lipo together
- The Go library needs `GOARCH=arm64` for the darwin/arm64 build (already supported in `build_release.go`)

### Build complexity

The Go → C → Dart FFI chain requires all three layers to match architecture. This is the same pattern already solved for Android (arm64-v8a) and iOS (arm64). The CMake build system in `dart_wormhole_william/macos/CMakeLists.txt` would need to pass the correct `GOARCH`.

## Flutter SDK Status (Corrected)

**The Flutter SDK is NOT a blocker for Destiny arm64 macOS builds.** Earlier analysis was wrong. The key issues:

| Issue | Status | What it means |
|-------|--------|---------------|
| #60113 — ARM macOS target umbrella | **CLOSED** | Flutter considers basic arm64 macOS target support complete |
| #69157 — macOS artifacts with ARM slice | **CLOSED** | Flutter SDK ships macOS artifacts with arm64 slices |
| #101138 — gen_snapshot as arm64 | **CLOSED** | gen_snapshot_arm64 is now compiled as arm64 |
| #69221 — FlutterMacOS.framework arm64 | **CLOSED** | Framework includes arm64 architecture |
| #175320 — Debugging fails on arm64 | **SOLVED** | Recent bug (Sep 2025) fixed |
| #103386 — Engine build without Rosetta | **OPEN (P2)** | Only affects engine *contributors* building the engine from source, not app developers using prebuilt SDK |

The only still-open issue (#103386) is about building the Flutter *engine itself* without Rosetta — this affects Flutter engine contributors, not app developers. App developers using the prebuilt Flutter SDK can build arm64 macOS apps today.

## Points of Agreement

All sources agree: the app works on Apple Silicon via Rosetta, but native arm64 support requires removing the Xcode exclusion and updating the build pipeline. The Flutter SDK is ready; Destiny's project config is not.

## Gaps

- No upstream issues or PRs specifically about arm64 macOS support for Destiny
- No discussion of universal binary distribution strategy
- The `dart_wormhole_william` macOS CMake build system may need updates to pass `GOARCH=arm64` for the Go library
