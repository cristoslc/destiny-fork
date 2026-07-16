# Default Download Destination

## Issue

Received files are stored in the app's sandboxed Documents directory instead of `~/Downloads`. On macOS, this means users have to navigate into the app's container folder in Finder to find downloaded files.

## Impact

- Users expect downloaded files to appear in `~/Downloads` (standard macOS convention)
- On iOS, files are stored in the app's Documents folder visible in Files app, which is acceptable but not ideal
- The README notes: "iOS downloaded files are stored in the app/Documents folder, which is displayed in Files App as a dedicated application folder"

## Location

- `lib/views/shared/receive.dart` — likely where the download path is set
- `lib/views/shared/util.dart` — utility functions for file paths

## Remediation

Add a platform-specific default: `~/Downloads` on macOS/Linux, app Documents on mobile. This is a UX improvement, not a bug fix.
