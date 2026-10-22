# ccc-reload

[![Compile plugin](https://github.com/MoeVsMachine/ccc-reload/actions/workflows/compile-plugin.yml/badge.svg?branch=live)](https://github.com/MoeVsMachine/ccc-reload/actions/workflows/compile-plugin.yml)

Reloads the Custom Chat Colors cache on demand, so a player's tag colour picks up without an
admin doing it by hand.

## What it does

Registers one console command. When a player runs it, the server executes `sm_reloadccc`,
which makes the Custom Chat Colors plugin re-read its cache.

| Command | Who can run it | Effect |
| --- | --- | --- |
| `joinclass` | any player (bots are ignored) | runs `sm_reloadccc` on the server |

The plugin does no caching or colouring itself — it is a thin trigger for CCC's own reload.

## Install

1. Take `compiled/executeonjoin.smx` from this repo.
2. Drop it in `addons/sourcemod/plugins/` on the server.
3. `sm plugins load executeonjoin`, or change map.

Built against **SourceMod 1.12** (1.12.0.7255). Older branches are not tested.

## Building

CI does it automatically — see below. To build by hand:

```sh
curl -fsSL -o sm.tar.gz \
  https://github.com/alliedmodders/sourcemod/releases/download/1.12.0.7255/sourcemod-1.12.0-git7255-linux.tar.gz
tar xzf sm.tar.gz

mkdir -p compiled
./addons/sourcemod/scripting/spcomp sourcemod/scripting/executeonjoin.sp \
  -i addons/sourcemod/scripting/include \
  -i sourcemod/scripting \
  -o compiled/executeonjoin.smx
```

`spcomp` is a 32-bit binary; on a 64-bit Debian/Ubuntu host you need `lib32stdc++6` and
`lib32z1`. On Debian 13 those resolve to native amd64 multilib packages, so no
`dpkg --add-architecture i386` is required.

## Repository layout

```
sourcemod/scripting/executeonjoin.sp   plugin source
compiled/executeonjoin.smx             build output, committed
.github/workflows/compile-plugin.yml   CI
```

## CI

`.github/workflows/compile-plugin.yml` runs on the org's self-hosted runner
(`self-hosted, linux, x64, sourcemod`). On any push to `live` that touches
`sourcemod/scripting/`, it compiles every `*.sp` and commits the resulting `.smx` to
`compiled/`. The commit only touches `compiled/`, which is not in the trigger paths, so it
cannot loop. Compiler version is pinned to 1.12.0.7255 — the `smdrop/1.12/sourcemod-latest`
pointer 404s, and 7257 ships a Windows-only archive.

Runs can also be started by hand from the Actions tab (`workflow_dispatch`).
