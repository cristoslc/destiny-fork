# Source: Flutter Apple Silicon docs

**URL:** https://github.com/flutter/flutter/blob/master/docs/platforms/desktop/macos/Developing-with-Flutter-on-Apple-Silicon.md
**Fetch date:** 2026-07-15

## Verbatim excerpt

Key points from Flutter's official docs:

1. **Host support is mature:** "You can use Apple Silicon-based Mac devices as a developer workstation (host) for building Flutter apps. While some tools still use Rosetta, Apple Silicon-based Macs are fully supported as a host."

2. **Target support is Rosetta-only:** "Compiled Intel macOS binaries work on Apple Silicon without change thanks to the Rosetta 2 translation environment, which converts x86_64 instructions to ARM64 equivalents."

3. **Native arm64 compilation is planned:** "We also plan to offer support for compilation directly to ARM64, as well as universal binaries that combine x86_64 and ARM64 assets. Issue 60113 is the umbrella bug tracking this work."

4. **Flutter 2.5+ recommended** on Apple Silicon machines.

The umbrella issue (flutter/flutter#60113) tracks native arm64 macOS target support. As of 2026, Flutter 3.35+ has made progress but the engine build still has Rosetta dependencies (flutter/flutter#103386).
