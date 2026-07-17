# Source: Upstream README — Apple Silicon status

**URL:** https://github.com/LeastAuthority/destiny
**Fetch date:** 2026-07-15

## Verbatim excerpt

From the README at the root of the upstream repo:

> **Known Issues:**
> - Flutter currently does not support x86 for android builds, so x86 emulators or devices are not supported.
> - MacOS M1/M2 (arm64) chip build is not supported yet.

The latest release (v1.0.3, January 2026) ships macOS builds as `destiny_macos.dmg` — no architecture suffix, implying x86_64 only. The release notes say "macOS (M1 or Intel chip based)" but the build itself is x86_64 running under Rosetta 2.
