#!/bin/sh
# Test 40col.bas: 40 reverse X's, 5x CHR$(20) (DEL), then "@".
# DEL = backspace: cursor left + erase character (\033[D\033[P). In a DCH-capable
# terminal this shows 35 X's then @ (no X's after @).
# Run from repo root: sh tests/40col_test.sh

set -e
cd "$(dirname "$0")/.."

OUT=$(./basic -petscii tests/40col.bas 2>/dev/null)

# Each DEL must emit cursor-left then delete-character (DCH)
LEFT=$(printf '%s' "$OUT" | grep -o '\[D' | wc -l)
DCH=$(printf '%s' "$OUT" | grep -o '\[P' | wc -l)
if [ "$LEFT" -ne 5 ]; then
    echo "FAIL: expected 5 cursor-left (\\033[D), got $LEFT"
    exit 1
fi
if [ "$DCH" -ne 5 ]; then
    echo "FAIL: expected 5 delete-character (\\033[P) for DEL erase, got $DCH"
    exit 1
fi

# Output should end with @ (cursor was moved back 5 and 5 chars erased, then @ printed).
LAST=$(printf '%s' "$OUT" | tail -c 1 | xxd -p)
if [ "$LAST" != "40" ]; then
    echo "FAIL: expected last character @ (hex 40), got $LAST"
    exit 1
fi

echo "OK: 40col.bas — DEL = backspace (cursor left + erase); 5 DELs + @"
exit 0
