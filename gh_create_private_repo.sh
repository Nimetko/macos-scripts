#!/usr/bin/env bash
#
# gh-create-and-sync.sh
# --------------------------------------------------------------
# Usage:
#   mkkdir <project name>
#   cd <project name>
#   git init
#   ./gh-create-and-sync.sh <project-name>
#
# Example:
#   mkdir Silo_app
#   cd Sio_app
#   git init
#   ./gh-create-and-sync.sh Silo_app
#
# --------------------------------------------------------------

# set -euo pipefail — makes the script exit on any error (-e),
# on use of unset variables (-u),
# and if any command in a pipeline fails (-o pipefail).
set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <project-name>"
  exit 1
fi

REPO_NAME="$1"
USER_LOGIN="Nimetko"
REMOTE_URL="https://github.com/${USER_LOGIN}/${REPO_NAME}.git"

# --- check dependencies ---
command -v gh >/dev/null || { echo "GitHub CLI (gh) not found. Install: https://cli.github.com/"; exit 1; }
command -v git >/dev/null || { echo "git not found."; exit 1; }

# --- ensure GitHub authentication ---
if ! gh auth status >/dev/null 2>&1; then
  echo "Logging into GitHub…"
  gh auth login
fi

# --- check if repo already exists ---
if gh repo view "${USER_LOGIN}/${REPO_NAME}" >/dev/null 2>&1; then
  echo "Repo already exists: ${REMOTE_URL}"
else
  echo "Creating private repo ${USER_LOGIN}/${REPO_NAME}..."
  gh repo create "${USER_LOGIN}/${REPO_NAME}" --private --add-readme --confirm
  echo "Created: ${REMOTE_URL}"
fi

# --- init git if needed ---
if [[ ! -d .git ]]; then
  echo "Initializing local git repository..."
  git init
fi

# --- initial commit (even if empty) ---
git add . >/dev/null 2>&1 || true
git commit -m "Initial commit" --allow-empty || true

# --- set master branch ---
git branch -M master

# --- set remote ---
if git remote get-url origin >/dev/null 2>&1; then
  git remote set-url origin "$REMOTE_URL"
else
  git remote add origin "$REMOTE_URL"
fi

# --- push master branch ---
echo "Pushing master branch to GitHub..."
git push --set-upstream origin master -f

echo ""
echo "Done!"
echo "Repo URL: ${REMOTE_URL}"
echo "Local path: $(pwd)"
