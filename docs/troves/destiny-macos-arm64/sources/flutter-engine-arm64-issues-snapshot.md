# Source: Flutter engine arm64 build issues

**URL:** https://github.com/flutter/flutter/issues/103386
**Fetch date:** 2026-07-15

## Verbatim excerpt

Umbrella issue for building the Flutter engine on Apple Silicon without Rosetta:

> "Currently, in order to build the engine on an Apple Silicon Mac, either as a host build or a target build, we need to build under Rosetta. This is for several reasons: The Fuchsia clang toolchain for arm64 macOS is not yet available."

Related issues:
- flutter/flutter#69157 — "Build Flutter macOS artifacts with ARM architecture slice"
- flutter/flutter#101138 — "Build macOS desktop gen_snapshot_arm64 and gen_snapshot_x64 as arm64 binary"
- flutter/flutter#175320 — "Debugging on apple silicon for macos device fails" (2025)

Status: The Flutter engine team has been working on this for years. As of 2025-2026, the engine still ships x86_64 binaries that run under Rosetta on Apple Silicon. The `gen_snapshot_*` tools are x86_64. This is a Flutter SDK issue, not specific to Destiny.
