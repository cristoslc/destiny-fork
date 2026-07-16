# Overnight Plan — 2026-07-16

## Work queue

Process remaining platform CI failures sequentially, one branch at a time:

### 1. flutter-bump/android
- **Root cause:** Golden tests fail (1-2% pixel diff from Flutter 3.22 font changes) + Gradle AAR metadata mismatch
- **Fix:** Regenerate goldens on CI runner, update Android Gradle config
- **Branch:** `flutter-bump/android`

### 2. flutter-bump/linux
- **Root cause:** `DESTINY_VERSION` contains slash (`flutter-bump/root`), breaks `cp` directory creation
- **Fix:** Sanitize version string for filesystem use
- **Branch:** `flutter-bump/linux`

### 3. flutter-bump/ios
- **Root cause:** Xcode build failure — needs investigation
- **Fix:** TBD after log inspection
- **Branch:** `flutter-bump/ios`

### 4. flutter-bump/windows
- **Root cause:** Visual Studio 2019 not found on CI runner
- **Fix:** Update CMake generator or runner image
- **Branch:** `flutter-bump/windows`

## Boundaries
- Do NOT modify `lib/` Dart code (TextTheme migration already done)
- Do NOT modify `docs/` scaffolding files
- Do NOT modify Go/C code in submodules
- Do NOT merge to trunk — leave branches for operator review

## Failure handling
- If a task fails: log the error, skip to next task
- Max 3 retries per task
- If all tasks fail: write briefing and stop

## Morning artifacts
- `docs/musings/overnight-briefing.md` — summary of what ran, what succeeded, what failed
- Commits on each platform branch
