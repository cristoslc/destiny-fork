#!/usr/bin/env bash
set -euo pipefail

BRANCH="${1:-$(git branch --show-current)}"
echo "Deploying staging environment for branch: $BRANCH"
# TODO: implement staging deploy
