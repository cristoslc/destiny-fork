# Context Map

```mermaid
flowchart LR
  subgraph "File Transfer (Core)"
    S[Sender]
    R[Recipient]
    F[File]
    C[Code]
  end

  subgraph "Settings"
    P[Preferences]
  end

  subgraph "Platform Integration"
    FS[File System]
    CB[Clipboard]
    PM[Permissions]
    N[Notifications]
  end

  subgraph "External"
    RV[Rendezvous Server]
    TR[Transit Relay]
  end

  S -- "Uses" --> F
  S -- "Generates" --> C
  R -- "Enters" --> C
  File Transfer -- "Reads" --> Settings
  File Transfer -- "Uses" --> Platform Integration
  File Transfer -- "Connects to" --> RV
  File Transfer -- "Connects to" --> TR
```

## Relationship Types

- **File Transfer → Settings**: upstream/downstream (Settings is a shared kernel read by File Transfer)
- **File Transfer → Platform Integration**: conformist (File Transfer adapts to OS conventions)
- **File Transfer → Rendezvous/Transit**: open host service (external protocol, published language)
