# Nutriwork — project state & resume

**What it is:** a **vanilla Minecraft 1.21 / 1.21.1 datapack** (no mod loader) that adds
a Diet-style nutrition system. Foods are sorted into groups; keeping a balanced spread
across groups earns passive buffs, an unbalanced diet earns none. Namespace `nutriwork`,
by **SapperSquad**. There is a dedicated `nutriwork` build agent at
`~/.claude/agents/nutriwork.md` — route work through it.

## Status — v1.3.0 (bossbar HUD + resource pack), load-clean, IN-GAME VERIFIED 2026-07-23

- All 93 data files present; **all JSON parses, no BOM, every cross-reference resolves**
  (function tags → functions, advancement rewards → functions, `advancement revoke` →
  advancements). Static validation passes.
- **Verified in a running 1.21.1 client** (loaded in a NeoForge dev world): pack loads
  clean, player init + bootstrap fire, all six bossbars render with correct
  colours/labels/values and progress fill, decay ticks down at the configured rates, and
  `admin/uninstall` removes the bars + objectives. The `consume_item` predicate and the
  bossbar macros all work.
- **Found: the vanilla top-third bossbar cap.** `BossHealthOverlay.render()` stops drawing
  once `j >= guiHeight()/3`, so bossbars only fill the top third of the GUI. With six bars
  the last one or two (Sugar, Water) **clip at high GUI scale / small windows**; at GUI
  Scale ≤ 2 (or a tall window) all six show. Not a datapack bug — all six exist and update,
  and the actionbar HUD (mode 2) shows all six regardless. See `DECISIONS.md`/`HUD.md` and
  [[mc-bossbar-render-cap]] in memory.

## How it works

- **Tracks** (scoreboards, 0–100): `nw.fruits nw.veg nw.grains nw.protein nw.sugar
  nw.hydration`.
- **Detection:** one `consume_item` advancement per grant-tag (`advancement/eat/*.json`).
  Its reward function (`function/eat/*.mcfunction`) adds that food's points, refreshes the
  cuisine-variety timer, runs the over-eating check, then **`advancement revoke @s`** to
  re-arm. Forgetting the revoke = it fires once ever — the classic bug; don't reintroduce it.
- **Engine loop:** `#minecraft:tick` → `core/tick` (counter) → `core/second` (buffs + HUD,
  as `@a`) → `core/minute` (decay). Buffs are **short, hidden, ambient effects re-applied
  every second** so they feel permanent but fade seconds after your diet slips. Do NOT
  lengthen the durations.
- **Buffs:** groups at 50+ = "coverage": 3+ Regen I, 4+ Resistance I, 5 Haste I. Cuisine
  variety (4+ distinct groups eaten recently) = Well-Fed Absorption. Low hydration =
  Weakness/Slowness. Over-eating while full = brief "stuffed" Slowness.
- **HUD:** `/trigger nw.hud` toggles a compact actionbar dashboard (`hud/show`).

## Single source of truth — the food table

`data/nutriwork/tags/item/grant/<group>_<tier>.json`. A food's group **and** value tier
are which grant-tag it sits in; a food may be in several on purpose (pumpkin_pie = grain +
sugar). **Add or reclassify a food by editing one tag JSON, then `/reload`** — nothing
else. `tools/scaffold.ps1` only *bootstrapped* the 15 tier families; the files under
`data/` are the living source of truth now (don't re-run it over hand edits).

## Tuning

Everything is in `data/nutriwork/function/config/defaults.mcfunction` (tier point values,
hydration value, variety window, decay rates). Edit and `/reload`. That's the whole
server-facing surface.

## How to test (60 seconds, in-game)

1. Symlink/copy the pack into a creative test world's `datapacks/` folder, `/reload`.
2. `/function nutriwork:admin/help` — lists everything.
3. `/trigger nw.hud` to show the HUD, then eat a cooked steak / carrot / bread / apple /
   cookie and watch the numbers rise. `/function nutriwork:journal` for the full readout.
4. `/function nutriwork:admin/fill` then check you gain Regen/Resistance/Haste/Absorption;
   `/function nutriwork:admin/clear`, drop hydration, confirm Weakness kicks in.

Known harmless quirk: on `/reload` the console prints "objective already exists" for each
track — expected (re-adding is how load stays idempotent without wiping scores).

## Building a release

`powershell -File tools\build-release.ps1` (re)builds `dist/`:
- `Nutriwork-v<ver>.zip` — the **release bundle**: `Nutriwork Datapack.zip` +
  `Nutriwork HUD Resource Pack.zip` + `INSTALL.txt`. This is the download.
- standalone `Nutriwork-Datapack-v<ver>.zip` and `Nutriwork-HUD-ResourcePack-v<ver>.zip`
  for stores that prefer separate files.

Bump the `$ver` / `$rpver` at the top of the script per release. Regenerate the RP glyph
PNGs first with `tools/GenHudIcons.java` if they're missing. `dist/` and `build/` are
gitignored.

## Roadmap (post-v1.0)

- **Water bottles — DONE (v1.2.0).** `advancement/eat/water_bottle.json` matches
  `minecraft:potion` filtered by `minecraft:potion_contents: ["minecraft:water"]`. The
  predicate shape was **verified against 1.21.1 source** (`ItemPotionsPredicate` is
  registered `potion_contents` with a `HolderSet<Potion>` value; `ItemPredicate` nests
  sub-predicates under `predicates`), so it's not a guess. Isolated in its own
  advancement + `eat/water_bottle` function. Milk/honey/soups/juicy foods still hydrate
  via `tags/item/water.json`.
- **Modded-food compat — DONE (v1.1.0).** Optional `tags/item/compat/*` route the
  `c:foods/*` + `pantrywork:food_component/*` tags into the grant-tags (all
  `required:false`, absent on vanilla). Included *into* the grant-tags, not via parallel
  advancements, so nothing double-counts. Delete the `compat/` folder to disable. Full
  mapping and the known bounded same-group top-up on modded servers are in `COMPAT.md`.
- **HUD polish — DONE (v1.3.0).** `/trigger nw.hud` now cycles off → bossbars → actionbar.
  Bossbars are per-player (`nutriwork:h<id>_<track>`, id from `#next nw.id`), macro-updated
  each second (`hud/bars_update` → `_bars_text_m`). Optional resource pack
  (`resourcepack/`, zipped to `dist/Nutriwork-HUD-ResourcePack-v1.0.zip`, format 34) adds a
  custom-font icon per track (U+E000–E005, PNGs from `tools/GenHudIcons.java`); opt in per
  player with `hud/icons_on`. **The bossbar/macro behaviour and the glyph alignment are the
  parts most worth eyeballing in a client** — static-validated only so far. See `HUD.md`.
- **GameTests:** on 1.21.5+ the `/test` framework can automate the eat→score checks.

See `DECISIONS.md` before re-opening any of the choices above. Ship store copy with every
release (`PUBLISHING.md`).
