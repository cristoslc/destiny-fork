# Developer Workflows

## Build

```bash
# Default (magic-wormhole.io servers)
flutter build linux
flutter build apk
flutter build appbundle
flutter build macos
flutter build ipa

# Least Authority servers
flutter build linux -t lib/main_la.dart

# Local instances
flutter build linux -t lib/main_local.dart
```

## Test

```bash
# Unit tests
flutter test

# Integration tests
flutter test integration_test/
```

## Dependencies

- Go >= 1.19
- Flutter >= 3.0.0
- Android SDK >= 24 (for Android builds)

## Local Development

Start wormhole services locally:

```bash
cd docker
docker-compose up -d
```

## CI/CD

GitHub Actions workflows live in `.github/`. See the repository's Actions tab for pipeline status.

## Release

See `docs/releases.md` for signing and release procedures.
