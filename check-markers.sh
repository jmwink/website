#!/bin/sh
# Refuse to publish while park-and-continue markers are live in the source.
#
# Why this exists: Joel drafts with [CHECK: …] / [TODO: …] / [LINK HERE] markers
# and they are still in the text when a post arrives. On 2026-08-07 a scaffold
# shipped an href of the literal string "TODO" to the live site. The notebook
# makes that failure mode structural rather than accidental, so it gets a guard.
#
# Usage:  ./check-markers.sh          → exit 0 if clean, 1 if markers found
# Run it before `quarto render`, not after.
#
# Only source .qmd is scanned. docs/ is build output; fixing it there is
# fixing the wrong file.

set -u
cd "$(dirname "$0")" || exit 2

hits=$(grep -rnE '\[CHECK:|\[TODO:?\]?|\[LINK HERE\]|\bDICTATION PENDING\b|href="TODO"' \
        --include='*.qmd' . 2>/dev/null | grep -v '^\./docs/')

if [ -n "$hits" ]; then
    echo "BLOCKED — unresolved markers in source. Not safe to publish:"
    echo
    echo "$hits"
    echo
    echo "Resolve them, or delete the marker if the text is final."
    exit 1
fi

echo "clean — no unresolved markers."
exit 0
