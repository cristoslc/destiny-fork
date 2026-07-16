# Sashay: Flutter Version Bump + Dart API Migration for Apple Silicon

You are working in a PR-tracked branch. The draft PR URL is https://github.com/cristoslc/destiny-fork/pull/1.

## Chronicle rules

1. **Intent posts before work** — before starting each work unit, post an intent comment on the PR via `gh pr comment 1 --body "..."`.
2. **Commit and push regularly** — after each checkpoint, commit and push.
3. **Narrative bridging** — if >3 commits land without a PR comment, post a bridging comment summarizing the gap.
4. **Surfacing operator intent** — when work is operator-initiated, say "Per operator request: ...".
5. **The word "final" is reserved** — do not use it until the sashay closure step. Use "checkpoint" or "status update".
6. **When done** — ensure all tests pass, update the PR body with the final chronicle, and signal completion.

## Task

Implement Phase 2 of the Apple Silicon macOS build: Flutter version bump + Dart API migration.

The plan is at `docs/plans/flutter-version-bump-migration.md`. Follow it step by step.

### Step 0: Write snapshot tests (before migration)

Write golden tests for the 4 key screens:
1. Send screen (desktop + mobile)
2. Receive screen (desktop + mobile)
3. Settings screen
4. Info screen

Each golden test renders the widget tree, captures a screenshot, and compares against the stored golden. Run them to establish baselines. Commit the goldens.

### Step 1: Install fvm locally

```bash
brew install fvm
fvm install 3.22.3
fvm flutter pub get
```

All subsequent `flutter` commands use `fvm flutter`.

### Step 2: Tech-debt entry already filed

Already done at `docs/tech-debt/pinned-dependency-forks.md`.

### Step 3: Fix pinned dependencies first (before Flutter bump)

- `win32` — bump from `3.1.3` to compatible version
- `expand_widget` fork — spike: check if upstream has a compatible version
- `flutter-intro-slider` fork — spike: check if upstream has a compatible version
- `window_size` — spike: check if the pinned commit is compatible with Flutter 3.22

### Step 4: Bump CI Flutter pin

`.github/workflows/build.yml`: `FLUTTER_VERSION: "3.3.10"` → `"3.22.3"`

### Step 5: TextTheme rename (bulk)

Migrate all files using the mapping:
- `headline1` → `displayLarge`
- `headline2` → `displayMedium`
- `headline3` → `displaySmall`
- `headline4` → `headlineLarge`
- `headline5` → `headlineMedium`
- `headline6` → `headlineSmall`
- `subtitle1` → `titleLarge`
- `subtitle2` → `titleMedium`
- `bodyText1` → `bodyLarge`
- `bodyText2` → `bodyMedium`
- `caption` → `bodySmall`

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

### Step 6: Fix custom_theme.dart

- `BottomAppBarTheme(...)` → `BottomAppBarThemeData(...)`
- All TextTheme renames
- Remove `backgroundColor:` parameter

### Step 7: Update snapshot goldens

Run the golden tests. If the visual output is correct, update the golden files. If not, fix the migration.

### Step 8: Verify

```bash
fvm flutter build macos --debug
lipo -info build/macos/Build/Products/Debug/Destiny.app/Contents/MacOS/Destiny
# Expected: architecture: arm64
```

## When done

1. Ensure all tests pass
2. Push all commits
3. Post a final chronicle comment on the PR with:
   - Summary of what was done
   - Test results
   - Architecture verification (lipo output)
   - Deferred work section
4. Signal completion
