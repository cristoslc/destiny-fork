# Containers

```mermaid
C4Container
  Person(sender, "Sender", "File sender")
  Person(recipient, "Recipient", "File recipient")

  System_Boundary(destiny, "Destiny Application") {
    Container(flutter_app, "Flutter App", "Dart/Flutter", "Cross-platform UI, state management, file handling")
    Container(go_bridge, "Go Bridge", "Go (via dart:ffi)", "Wormhole protocol client, PAKE, encryption")
  }

  System_Ext(rendezvous, "Rendezvous Server", "WebSocket")
  System_Ext(transit, "Transit Relay", "WebSocket")

  Rel(sender, flutter_app, "Selects file, shares code")
  Rel(recipient, flutter_app, "Enters code, receives file")
  Rel(flutter_app, go_bridge, "FFI calls", "dart:ffi")
  Rel(go_bridge, rendezvous, "WebSocket", "PAKE handshake")
  Rel(go_bridge, transit, "WebSocket", "Encrypted file transfer")
```

## Container Descriptions

- **Flutter App** — the cross-platform UI layer. Handles file selection, code entry, progress display, settings, and platform integration (clipboard, permissions, notifications).
- **Go Bridge** — the wormhole-william Go client compiled as a shared library and accessed via Dart FFI. Handles the Magic Wormhole protocol: PAKE handshake, key derivation, encryption/decryption, and transit relay connections.
