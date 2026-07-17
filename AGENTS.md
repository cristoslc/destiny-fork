# AGENTS.md — destiny-fork

Project-specific guidance for AI agents working on this fork.

## Purpose

See `PURPOSE.md` for the one-paragraph outcome.

## Project navigation

See `docs/agents-detail/project-navigation.md` for how to orient yourself in this codebase.

## Branch strategy

- **`main`** — tracks upstream `LeastAuthority/destiny`. Only receives upstream merges. Do not commit fork-specific changes here.
- **`trunk`** — the fork's primary development branch. Fork-specific infrastructure, docs, and non-upstreamable changes live here. Created from `main` + scaffolding.
- **`<topic>/<slug>`** — sashay branches for feature work. Created from `trunk`, merged back to `trunk` when complete.

## Test command

```bash
flutter test
```

Integration tests:

```bash
flutter test integration_test/
```

## Key conventions

- Dart/Flutter project with Go submodule (`dart_wormhole_william`)
- Multiple entry points: `lib/main.dart` (default), `lib/main_la.dart` (Least Authority servers), `lib/main_local.dart` (local instances)
- Platform directories: `android/`, `ios/`, `linux/`, `macos/`, `windows/`, `web/`
- State management via `provider` and `get_it` (service locator)
- All docs live under `docs/` — see the hub files for architecture, domain model, and workflows
