#!/bin/bash
set -euo pipefail

git checkout --orphan temp-branch
git add -A
git commit -m "update on $(date -u +%Y-%m-%dT%H:%M:%SZ)" --no-verify
git branch -D main
git branch -m main
git push -f origin main
git gc --aggressive --prune=all
git branch --set-upstream-to=origin/main
