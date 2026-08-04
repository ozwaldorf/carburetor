#!/usr/bin/env bash
# Update every flake package with a fetched upstream source to the latest commit.
set -uo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")" || exit 1

# Packages nix-update cannot handle:
#   docs, patch          - built from this repo, no version/src to update
#   gtk, papirus-folders - src is another nixpkgs derivation's output, not a fetcher
skip=(docs patch gtk papirus-folders)

system=$(nix eval --impure --raw --expr builtins.currentSystem)
mapfile -t packages < <(
  nix eval --json ".#packages.${system}" --apply builtins.attrNames |
    tr -d '[]"' | tr ',' '\n'
)

failed=()
for pkg in "${packages[@]}"; do
  for s in "${skip[@]}"; do
    [ "$pkg" = "$s" ] && continue 2
  done

  echo "==> $pkg"
  nix-update -F --build --commit --version=branch "$pkg" || failed+=("$pkg")
done

if [ ${#failed[@]} -gt 0 ]; then
  echo "failed: ${failed[*]}" >&2
  exit 1
fi
