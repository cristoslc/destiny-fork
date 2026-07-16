# Tech Stack

## Languages & Runtimes

- **Dart** — application logic (Flutter framework)
- **Go** — core protocol implementation (via `dart_wormhole_william` submodule)
- **Flutter** — cross-platform UI framework

## State Management

- `provider` — widget-level state
- `get_it` — service locator for dependency injection

## Key Dependencies

- `dart_wormhole_william` — Dart FFI bindings to the Go wormhole-william client
- `shared_preferences` / `streaming_shared_preferences` — persistent settings
- `file_picker` — native file selection dialogs
- `desktop_drop` — drag-and-drop file import
- `permission_handler` — runtime permission requests
- `url_launcher` — external URL handling
- `package_info_plus` — app version metadata

## Infrastructure

- **Rendevous server** — Magic Wormhole protocol relay (default: `magic-wormhole.io`)
- **Transit relay** — peer-to-peer connection relay (default: `magic-wormhole.io`)
- **Docker Compose** — local development of wormhole services (`docker/`)

## Build & CI

- Flutter build system (`flutter build`)
- GitHub Actions (`.github/`)
- Platform targets: Android, iOS, Linux, macOS, Windows, Web
