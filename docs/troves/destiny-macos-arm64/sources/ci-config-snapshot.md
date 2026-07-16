# Source: CI build configuration

**URL:** Local file `.github/workflows/build.yml`
**Fetch date:** 2026-07-15

## Verbatim excerpt

The macOS CI job:

```yaml
macos:
  runs-on: macos-latest
  steps:
    - name: "Build mac app"
      run: "flutter build macos lib/main_la.dart --debug --dart-define version=${{ env.DESTINY_VERSION }}"
```

Key observations:
- Runs on `macos-latest` (Intel x86_64 GitHub runners)
- No architecture flags — builds default x86_64
- No `macos-14` (Apple Silicon) runner option
- No universal binary or lipo step
- No arm64 cross-compilation

The CI would need `macos-14` runners for native arm64 builds, or a cross-compilation setup on Intel runners.
