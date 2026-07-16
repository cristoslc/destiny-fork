#!/usr/bin/env bash
set -euo pipefail

BRANCH="${1:-$(git branch --show-current)}"
echo "Tearing down staging environment for branch: $BRANCH"
# TODO: implement staging teardown
