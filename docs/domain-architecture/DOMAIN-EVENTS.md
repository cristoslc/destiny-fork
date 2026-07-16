# Domain Events

## Cross-Context Events

| Event | Producing Context | Consuming Context(s) | Payload | Delivery |
|---|---|---|---|---|
| `FileTransferStarted` | File Transfer | Platform Integration | `{code, fileName, fileSize}` | In-process event |
| `FileTransferProgressed` | File Transfer | Platform Integration | `{bytesTransferred, totalBytes}` | In-process event |
| `FileTransferCompleted` | File Transfer | Platform Integration | `{fileName, filePath}` | In-process event |
| `FileTransferFailed` | File Transfer | Platform Integration | `{code, error}` | In-process event |
| `SettingsChanged` | Settings | File Transfer | `{rendezvousUrl, transitUrl}` | In-process event |

All events are internal (in-process). No cross-process or cross-service events exist — the Magic Wormhole protocol handles all network communication through the rendezvous and transit servers.
