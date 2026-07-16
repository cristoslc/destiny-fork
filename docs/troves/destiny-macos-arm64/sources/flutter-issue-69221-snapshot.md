# Source: Flutter issue #69221 — FlutterMacOS.framework arm64 (CLOSED)

**URL:** https://github.com/flutter/flutter/issues/69221
**Fetch date:** 2026-07-15

## Verbatim excerpt

"FlutterMacOS.framework engine isn't natively available for desktop for ARM macOS Apple Silicon (including building for all valid architectures on x86)". Filed Oct 2020, **closed**. P3 priority.

The framework only contained x86_64 architecture, so desktop apps ran with Rosetta translation. The fix was to add arm64 to the framework.

**Key takeaway:** CLOSED. FlutterMacOS.framework now includes arm64 architecture. This was a fundamental prerequisite — without it, no Flutter macOS app could run natively on Apple Silicon.
