# Components

```mermaid
C4Component
  Container_Boundary(flutter, "Flutter App") {
    Component(ui, "UI Layer", "Widgets & Screens", "File selection, code entry, progress, settings")
    Component(bloc, "State Management", "Provider + get_it", "App state, service locator")
    Component(file_svc, "File Service", "Dart", "File picker, drop target, file I/O")
    Component(settings_svc, "Settings Service", "shared_preferences", "Persistent user settings")
    Component(ffi_bridge, "FFI Bridge", "dart:ffi", "Go library bindings")
  }

  Container_Boundary(go, "Go Bridge") {
    Component(ww_client, "Wormhole Client", "Go", "Magic Wormhole protocol implementation")
    Component(pake, "PAKE Engine", "Go", "Password Authenticated Key Exchange")
    Component(encryption, "Encryption", "Go", "End-to-end encryption/decryption")
    Component(transport, "Transport", "Go", "WebSocket + relay management")
  }

  Rel(ui, bloc, "Reads/writes state")
  Rel(bloc, file_svc, "Initiates file operations")
  Rel(bloc, settings_svc, "Reads/writes settings")
  Rel(bloc, ffi_bridge, "Initiates transfers")
  Rel(ffi_bridge, ww_client, "dart:ffi calls")
  Rel(ww_client, pake, "Handshake")
  Rel(ww_client, encryption, "Encrypt/decrypt")
  Rel(ww_client, transport, "Network I/O")
```

## Key Components

- **UI Layer** — Flutter widgets organized by screen (send, receive, settings, intro)
- **State Management** — `Provider` for reactive state, `get_it` for service location
- **FFI Bridge** — Dart FFI bindings to the Go shared library
- **Wormhole Client** — the core protocol implementation from `dart_wormhole_william`
