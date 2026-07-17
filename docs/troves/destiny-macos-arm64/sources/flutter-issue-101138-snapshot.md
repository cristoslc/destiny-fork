# Source: Flutter issue #101138 — gen_snapshot as arm64 binary (CLOSED)

**URL:** https://github.com/flutter/flutter/issues/101138
**Fetch date:** 2026-07-15

## Verbatim excerpt

"Build macOS desktop gen_snapshot_arm64 and gen_snapshot_x64 as arm64 binary to run natively on Apple Silicon". Filed Mar 2022, **closed**. P3 priority. Closed via engine PR #52885.

The published gen_snapshot_* binaries were all x86_64:

```
./darwin-x64-profile/gen_snapshot_arm64:   Mach-O 64-bit executable x86_64
./darwin-x64-profile/gen_snapshot_x64:     Mach-O 64-bit executable x86_64
```

Dart does not support targeting x64 from a non-x64 host (dart-lang/sdk#49768). However gen_snapshot_arm64 can be compiled as arm64. gen_snapshot_x64 can be compiled as a universal binary for AOT builds.

**Key takeaway:** CLOSED. gen_snapshot_arm64 is now compiled as arm64 and published in the arm64 Flutter install zip. This was a prerequisite for native arm64 macOS app builds.
