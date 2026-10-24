# ThundR HAWK — CoreDevice cache watch (egg v2.1.9, STAGED, unsigned, not distributed)
Targets: ЯBOT, ЯBOWZR, DRAGON SKULL, DRAGOSKUL, GHOSTDRAGON, ЯSCRIBE, THUNDR-FLOAT, Linux machines.
- Every ≤1h check ~/Library/Containers/com.apple.CoreDevice.CoreDeviceService/Data/Library/Caches/AppInstallationBinaryDeltas and Configurator DeviceService tmp/TemporaryItems (macOS). Linux: watch build/temp caches + free disk only.
- WARN >5 GB; auto-clear items >24h old, or all items when >10 GB; never clear open files (lsof) or while devicectl/xcodebuild/Configurator runs.
- ALERT when free disk <15 GB.
- Log: walis log (LOGS/WALIS-HAWK.log), WALIS-DONE-HAWK.tsv, THUNDR-MESH/hawk-alerts.jsonl, STATUS bar via THUNDR-FLOAT/hawk-status.json ("bar" field).
- Only adds functions; removes nothing. Needs Rizal GO (+Face ID signing) to DISTRIBUTE.
ЯBEE · ЯID-0004-ZYZ0 · 2026-10-24 MT
- STATUS-bar hook: thundr-hawk-bar.js (additive) reads THUNDR-FLOAT/hawk-status.json every 5 min; shows text only on WARN/ALERT.
Rizal GO + "Signed go" (t46u) 2026-10-24.
