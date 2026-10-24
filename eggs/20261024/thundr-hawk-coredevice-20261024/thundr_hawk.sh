#!/bin/zsh
# ThundR HAWK v2.1.9 — watches Xcode CoreDevice install cache + Configurator temp + free disk.
# Rule: check hourly; WARN >5GB; auto-clear items older than 24h or all (not-open) when >10GB; ALERT free <15GB.
# Usage: thundr_hawk.sh [--dry-run]   ЯBEE · ЯID-0004-ZYZ0 · 2026-10-24
DRY=0; [[ "$1" == "--dry-run" ]] && DRY=1
H=$HOME/ЯLAB/RFORGE/SERVICES/THUNDR-HAWK
WLOG=$HOME/ЯLAB/LOGS/WALIS-20261024.log; [[ -d $HOME/ЯLAB/LOGS ]] && WLOG=$HOME/ЯLAB/LOGS/WALIS-HAWK.log
ALERTS=$HOME/ЯLAB/THUNDR-MESH/hawk-alerts.jsonl
STATUS=$HOME/ЯLAB/RFORGE/RCONTRALROOM/THUNDR-FLOAT/hawk-status.json
DONE=$HOME/ЯLAB/RFORGE/WALIS-DONE-HAWK.tsv
WARN_KB=$((5*1024*1024)); CLEAR_KB=$((10*1024*1024)); MINFREE_KB=$((15*1024*1024))
HAWKDIRS=(
 "$HOME/Library/Containers/com.apple.CoreDevice.CoreDeviceService/Data/Library/Caches/AppInstallationBinaryDeltas"
 "$HOME/Library/Containers/com.apple.configurator.xpc.DeviceService/Data/tmp/TemporaryItems"
)
TS=$(date '+%Y-%m-%dT%H:%M:%S%z')
log(){ print -r -- "$TS thundr-hawk $*" >> $WLOG; print -r -- "$*"; }
alert(){ print -r -- "{\"node\":\"thundr-hawk\",\"kind\":\"$1\",\"detail\":\"$2\",\"ts\":\"$TS\",\"host\":\"$(hostname)\",\"dry\":$DRY}" >> $ALERTS; log "$1: $2"; }
busy=$(pgrep -f 'devicectl|xcodebuild|Apple Configurator' | wc -l | tr -d ' ')
total=0; cleared=0
for d in $HAWKDIRS; do
  [[ -d $d ]] || continue
  kb=$(du -sk "$d" 2>/dev/null | cut -f1); total=$((total+kb))
  (( kb > WARN_KB )) && alert warn "$d is $((kb/1048576)) GB (>5 GB)"
  for p in "$d"/*(N); do
    old=$(find "$p" -prune -mmin +1440 | wc -l | tr -d ' ')
    (( kb > CLEAR_KB || old > 0 )) || continue
    if (( busy > 0 )) || lsof +D "$p" >/dev/null 2>&1; then log "skip in-use $p"; continue; fi
    s=$(du -sk "$p" | cut -f1)
    if (( DRY )); then log "DRY would clear $p ${s}KB"; else
      printf '%s\thawk-clear\t%s\t%sKB\n' "$TS" "$p" "$s" >> $DONE; rm -rf "$p"; cleared=$((cleared+s)); log "cleared $p ${s}KB"; fi
  done
done
free=$(df -k / | awk 'NR==2{print $4}')
(( free < MINFREE_KB )) && alert lowdisk "free space $((free/1048576)) GB (<15 GB)"
mkdir -p ${STATUS:h}
print -r -- "{\"ts\":\"$TS\",\"watched_kb\":$total,\"cleared_kb\":$cleared,\"free_kb\":$free,\"dry\":$DRY,\"bar\":\"HAWK cache $((total/1048576))GB · free $((free/1048576))GB\"}" > $STATUS
log "ok watched=${total}KB cleared=${cleared}KB free=${free}KB dry=$DRY"
