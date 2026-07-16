# Source: Go layer — darwin/arm64 support

**URL:** Local file `dart_wormhole_william/wormhole-william/build_release.go`
**Fetch date:** 2026-07-15

## Verbatim excerpt

The Go wormhole-william library already targets darwin/arm64:

```go
{"darwin", "arm64", ""},
```

This is in the build matrix alongside `{"darwin", "amd64", ""}`. The Go layer can cross-compile for Apple Silicon. No work needed here.

However, the CI workflow (`go.yml`) only builds `darwin/amd64` on GitHub runners:

```yaml
- run: env CGO_ENABLED=1 GOOS=darwin GOARCH=amd64 go build -buildmode=c-shared -v -o libwormhole_william.dylib ./c/
```

The comment says: "using amd64 as Github Runners as go fails to build for arm64 iOS" — this refers to iOS, not macOS. The darwin/arm64 build is not exercised in CI.
