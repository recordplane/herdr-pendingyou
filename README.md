# Pending You for Herdr

What your coding agents are waiting on you for, in [Herdr](https://herdr.dev). [Pending You](https://www.pendingyou.com)
is one queue for everything your assistants need from you: when an agent in a Herdr pane puts a question to you there,
its row in Herdr's sidebar says so, a toast tells you when one arrives, and one key takes you to the pane that's
waiting.

Sign it in, and its popup answers your cards with a key: the agent is woken in its pane seconds later, through Pending
You, never by typing into its terminal. High-stakes cards (they spend money, can't be undone or go public) still open
in Pending You, where you hold to approve.

## What you get

- **The card on the agent's row.** Each agent waiting on you carries the card's title on its row in Herdr's sidebar,
  and its state reads "waiting on you" instead of idle or done.
- **A toast when a card arrives**, for a pane in another tab than the one you're looking at. Cards that arrive together
  make one toast. A card the agent also asked you in its conversation waits three minutes first, so you can answer it
  there.
- **Next pane waiting on you**: one key goes to the most pressing (blocking cards first, then by urgency), then the next.
- **The popup**: your cards, the chosen one open, answered with a key once Herdr is signed in (below). Before that it
  lists the panes waiting on you: Enter opens the card in Pending You, `t` takes you to its pane.
- **The Agents view** (optional): agents waiting on you first in Herdr's Agents panel.
- **Your phone stays quiet** while you're active in Herdr, as it does while Pending You is open on your desk.

## Answering from the popup

Setup offers to sign Herdr in to Pending You (or run `npx pendingyou app login herdr`): your phone or browser shows one
card naming Herdr and this computer, and you press and hold Allow. Herdr sees the cards of this computer's agents (tick
"all" there for every card), and its popup answers them:

| Key | What it does |
|---|---|
| `1`–`9` | Answer with that option (a card that takes several: choose, then Enter) |
| `y` / `n` | Approve or decline; looks good or needs changes; a step done, or not (then which and what happened); got it |
| Enter | Write an answer (Enter sends, Esc goes back) |
| Tab | The next question of a card with several (Enter sends them all) |
| `r` | Write to the agent that asked |
| `l` | Later: in an hour, tonight or tomorrow morning |
| `d` | Hand it to another of your agents, then how much it may do |
| `u` | Undo, for 5 seconds |
| `t` | Go to the agent's pane |
| `o` | Open the card in Pending You |
| `a` | Open all your cards in Pending You |
| ↑ ↓ (`j` `k`) | Choose a card |
| `q` (Esc) | Close |

Pending You labels each answer "Answered in Herdr on" this computer, on the card and to the agent, and lists Herdr in
Settings › Apps and devices, where Remove signs it out at once. Its sign-in lasts 30 days; the plugin says when it's
about to end.

## What it needs

- Herdr 0.9.0 or later, on Linux or macOS.
- The `pendingyou` command line set up for your agents on the computer Herdr runs on:

  ```sh
  npx -y pendingyou@latest init
  ```

  It's what writes each agent's badges onto its pane (Claude Code with its wake mod, Codex, OpenCode and Pi), and what
  every command of this plugin runs.

## Install

```sh
herdr plugin install recordplane/herdr-pendingyou
```

Then run its setup (**Pending You: set up**) from a pane of that Herdr server:

```sh
herdr plugin action invoke setup --plugin pendingyou.herdr
```

Herdr has no command palette of its own, so this command (or a key bound to `pendingyou.herdr.setup`) is the way in. It
checks that toasts reach you (Herdr's are off until you turn them on), offers to add the sidebar row to Herdr's
config.toml (only if you say yes), offers to sign Herdr in so its popup can answer (`npx -y pendingyou@latest app login
herdr` does that part alone), and prints the keybindings to add yourself:

```toml
[[keys.command]]
key = "prefix+y"
type = "plugin_action"
command = "pendingyou.herdr.open"
description = "Pending You: what's waiting on you"

[[keys.command]]
key = "prefix+shift+y"
type = "plugin_action"
command = "pendingyou.herdr.next"
description = "Pending You: next pane waiting on you"
```

Attaching to Herdr from another computer (`herdr --remote`)? The sidebar's rows, toasts and your keys are read from
config.toml on the computer you attach from: add them there.

More than one Herdr server (your laptop's own, and one on another computer)? Each needs the plugin and Herdr signed in;
the keys on the computer you attach from work for both.

## What it sees, and where it goes

Each agent writes onto its own pane, through Herdr's command line: the app, the name it goes by with Pending You, how
many cards wait on you, the most pressing one's title (with anything that looks like a secret taken out, at most 80
characters) and their request ids. Herdr keeps them on this computer, shows them where you ask, and forgets them after
15 minutes unless the agent says them again. Never an answer, a note or anything else of a card.

Signed in, the popup reads your cards from Pending You while it's open and sends what you press, with Herdr's own
sign-in, kept with a key that never leaves this computer in `~/.config/pendingyou/apps/herdr.json` (readable only by
you). It writes no card anywhere but your screen. Not signed in, the plugin never asks Pending You anything.

## Remove it

**Pending You: remove** stops its watcher, takes the badges off every pane (and stops writing them on this computer),
clears its Agents view, takes its sidebar row out of config.toml and signs Herdr out of Pending You. Then `herdr plugin uninstall pendingyou.herdr`.

Apache-2.0. Copyright 2026 RecordPlane.
