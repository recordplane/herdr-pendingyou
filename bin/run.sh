#!/bin/sh
# Pending You for Herdr: every command of the plugin runs `pendingyou <args>` through this script. It runs the command
# line `npx pendingyou init` set up on this computer (the script its agents' hooks run, which never moves), once that
# one can answer from Herdr (it knows `app`); else pendingyou 0.30.0, through npx. Generated from packages/herdr-plugin/src/manifest.ts in
# recordplane/pendingyou.
config=${PENDINGYOU_CONFIG_DIR:-${XDG_CONFIG_HOME:-$HOME/.config}/pendingyou}
shim="$config/bin/pendingyou-hook"

# An agent changed state: nothing to do while the watcher runs (its lease touched in the last minute), or while the
# plugin is off (its unconfigure).
if [ "$1 $2" = "herdr event" ] && [ -n "${HERDR_PLUGIN_STATE_DIR:-}" ]; then
  if [ -f "$HERDR_PLUGIN_STATE_DIR/off" ]; then
    exit 0
  fi
  lease="$HERDR_PLUGIN_STATE_DIR/watch.lease"
  if [ -f "$lease" ] && [ -n "$(find "$lease" -mmin -1 2>/dev/null)" ]; then
    exit 0
  fi
fi

if [ -x "$shim" ] && "$shim" app --help >/dev/null 2>&1; then
  exec "$shim" "$@"
fi
if command -v npx >/dev/null 2>&1; then
  exec npx -y pendingyou@0.30.0 "$@"
fi
echo "Pending You: this needs Node and its command line. Run: npx -y pendingyou@latest init" >&2
exit 0
