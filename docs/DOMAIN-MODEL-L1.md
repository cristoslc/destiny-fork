# Domain Model — L1

## Bounded Contexts

### File Transfer (Core)

The primary domain. A **Sender** selects a **File** on their device, which generates a short human-memorable **Code**. The Sender shares this code out-of-band with a **Recipient**, who enters it into their own Destiny instance. The system performs a **PAKE** (Password Authenticated Key Exchange) handshake via the rendezvous server, derives a 256-bit symmetric key, and transfers the file end-to-end encrypted through a transit relay.

Key terms:
- **Code** — a short human-memorable string (e.g. "7-cactus-suitcase") that serves as the shared secret for the PAKE handshake
- **PAKE** — Password Authenticated Key Exchange; allows two parties to derive a shared key using a low-entropy password, with only one guess allowed per attempt
- **Rendezvous Server** — the coordination point for the PAKE handshake
- **Transit Relay** — relays encrypted packets when direct P2P connection is not possible

### Settings

Persistent user preferences: rendezvous server URL, transit relay URL, appearance, and app behavior.

### Platform Integration

Interfacing with the operating system: file system access, clipboard, permissions, notifications, and window management.

## Business Rules

- Only one guess is allowed per code attempt (brute-force protection)
- Files are encrypted before leaving the sender's device and decrypted only on the recipient's device
- No identity information is required to transfer files
- The server never sees unencrypted file contents
