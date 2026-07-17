# Overnight Briefing — 2026-07-16

## Summary

Processed 4 remaining platform CI failures sequentially. Each branch had a single root cause fix pushed.

## Results

### ✅ flutter-bump/android
- **Root cause:** `compileSdkVersion` and `targetSdkVersion` at 31 — Flutter 3.22 plugins require 34
- **Fix:** Bumped to 34
- **Commit:** `b11f4dc`

### ✅ flutter-bump/linux
- **Root cause:** `DESTINY_VERSION` contained `/` from branch name `flutter-bump/root`, breaking `cp` directory creation
- **Fix:** Sanitize version string with `tr '/' '-'`
- **Commit:** `30446b8`

### ✅ flutter-bump/ios
- **Root cause:** Missing Go installation on `macos-latest` runner (same as macOS job)
- **Fix:** Added `actions/setup-go@v5` step, cherry-picked DESTINY_VERSION sanitization
- **Commits:** `b32e583`, `6fa3202`

### ✅ flutter-bump/windows
- **Root cause:** `windows-latest` runner no longer has Visual Studio 2019 — uses newer image
- **Fix:** Changed to `windows-2022` runner
- **Commit:** `696c8cf`

## Needs Human Review

- Each branch needs CI verification — push triggers should fire automatically
- If any CI run still fails, deeper investigation needed (especially iOS where the Go 1.22+ cgo issue may manifest differently on the CMake-based iOS build)
- The android golden test failures may still block the build step (goldens were generated locally on arm64 macOS, may differ on x86_64 Linux CI runner)

## Logs

All commits pushed to respective branches on github.com/cristoslc/destiny-fork
