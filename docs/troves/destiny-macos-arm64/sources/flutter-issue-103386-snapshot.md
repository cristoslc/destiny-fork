# Source: Flutter issue #103386 — Engine on Apple Silicon without Rosetta (OPEN)

**URL:** https://github.com/flutter/flutter/issues/103386
**Fetch date:** 2026-07-15

## Verbatim excerpt

Umbrella issue for "[macOS] Support building engine on Apple Silicon without Rosetta". Filed May 2022, **still open**. P2 priority, status **In Progress** in the Flutter Desktop project. Assigned to cbracken.

> "Currently, in order to build the engine on an Apple Silicon Mac, either as a host build or a target build, we need to build under Rosetta. This is for several reasons: The Fuchsia clang toolchain for arm64 macOS is not yet available. Swiftshader (used by our engine tests) doesn't support building as an arm64 binary."

The engine hardcodes `host_cpu` to `x64` for all macOS engine builds (including cross-compiles targeting arm64). These builds run under Rosetta.

**Key takeaway:** This is the *current* active blocker. It affects Flutter engine contributors who want to build the engine natively on Apple Silicon. For app developers (like Destiny), the prebuilt Flutter SDK artifacts may now include arm64 slices — this issue is about building the engine itself without Rosetta.
