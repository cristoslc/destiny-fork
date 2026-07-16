# Deployment

## Environments

| Environment | Servers | Purpose |
|---|---|---|
| Production (default) | `magic-wormhole.io` | Default rendezvous + transit relay |
| Least Authority | LA-managed servers | `lib/main_la.dart` entry point |
| Local | Docker Compose | `docker/` directory, `lib/main_local.dart` entry point |

## Platform Targets

| Platform | Build Command | Artifact |
|---|---|---|
| Linux | `flutter build linux` | AppImage |
| macOS | `flutter build macos` | DMG |
| Windows | `flutter build windows` | MSIX |
| Android | `flutter build apk` / `flutter build appbundle` | APK / AAB |
| iOS | `flutter build ipa` | IPA |
| Web | `flutter build web` | Web bundle |

## Network Topology

```
[Destiny Client] <--WebSocket--> [Rendezvous Server] <--WebSocket--> [Destiny Client]
       |                                                                    |
       +-----------<WebSocket>---- [Transit Relay] ----<WebSocket>---------+
```

The rendezvous server coordinates the initial handshake. Once keys are exchanged, the transit relay facilitates the encrypted file transfer (direct P2P when possible, relayed otherwise).
