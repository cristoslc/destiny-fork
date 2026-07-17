#!/usr/bin/env bash
set -euo pipefail

BRANCH="${1:-$(git branch --show-current)}"
echo "Running E2E tests for branch: $BRANCH"
# TODO: implement staging E2E
