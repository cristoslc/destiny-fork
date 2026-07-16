# System Context

```mermaid
C4Context
  Person(sender, "Sender", "User who wants to send a file")
  Person(recipient, "Recipient", "User who wants to receive a file")

  System(destiny, "Destiny", "Cross-platform Magic Wormhole graphical client")

  System_Ext(rendezvous, "Rendezvous Server", "Magic Wormhole protocol rendezvous point")
  System_Ext(transit, "Transit Relay", "Peer-to-peer connection relay")
  System_Ext(os, "Operating System", "File system, notifications, permissions")

  Rel(sender, destiny, "Selects file, shares code")
  Rel(recipient, destiny, "Enters code, receives file")
  Rel(destiny, rendezvous, "PAKE handshake, code verification")
  Rel(destiny, transit, "Encrypted file transfer")
  Rel(destiny, os, "File I/O, clipboard, permissions")
  Rel(rendezvous, transit, "Connection coordination")
```

## Actors

- **Sender** — selects a file, gets a short human-memorable code, shares it with the recipient
- **Recipient** — enters the code, receives the end-to-end encrypted file

## External Systems

- **Rendezvous Server** — coordinates the PAKE (Password Authenticated Key Exchange) handshake
- **Transit Relay** — relays encrypted packets when direct P2P connection is not possible
- **Operating System** — file system access, clipboard, permissions, notifications
