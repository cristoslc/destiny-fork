# Source: Flutter issue #69157 — macOS artifacts with ARM slice (CLOSED)

**URL:** https://github.com/flutter/flutter/issues/69157
**Fetch date:** 2026-07-15

## Verbatim excerpt

"Build Flutter macOS artifacts with ARM architecture slice". Filed Oct 2020, **closed**. P2 priority. Closed via engine PR #52885.

Goal: "Stop requiring developers to install Rosetta on Apple Silicon, and ship macOS artifacts with both x86_64 and arm64 capabilities."

Sub-issues tracked:
- Roll ios-deploy iOS artifact to arm slice version (#115042)
- Unit Tests flutter_tests processes should run natively on Mac M1 processor (#106763)
- libpath_ops.dylib should run natively on Apple Silicon arm machines (#110227)
- font-subset should run natively on Apple Silicon arm machines (#110226)
- impellerc and libtessellator should run natively on Apple Silicon arm machines (#109892)
- Build macOS desktop gen_snapshot_arm64 and gen_snapshot_x64 as arm64 binary (#101138)
- Build iOS gen_snapshot_arm64 as arm64 binary (#152280)
- Build Android gen_snapshot as arm64 binary (#152281)
- Build idevicesyslog, idevicescreenshot, and iproxy binaries with macOS arm64 and x86_64 (#121178)
- Update website to remove Rosetta setup instructions

**Key takeaway:** CLOSED. The Flutter SDK now ships macOS artifacts with arm64 slices. The website should have been updated to remove Rosetta setup instructions.
