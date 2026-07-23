# Nutriwork — project state & resume

**What it is:** a **vanilla Minecraft 1.21 / 1.21.1 datapack** (no mod loader) that adds
a Diet-style nutrition system. Foods are sorted into groups; keeping a balanced spread
across groups earns passive buffs, an unbalanced diet earns none. Namespace `nutriwork`,
by **SapperSquad**. There is a dedicated `nutriwork` build agent at
`~/.claude/agents/nutriwork.md` — route work through it.

## Status — v1.0, load-clean, awaiting in-game sign-off

- All 68 data files present; **all JSON parses, no BOM, every cross-reference resolves**
  (function tags → functions, advancement rewards → functions, `advancement revoke` →
  advancements). Static validation passes.
- **Not yet confirmed in a running client** — see "How to test" below. Do that once and
  tick this off. The one API worth watching on first load is the `consume_item`
  advancement item predicate (`item.items: "#tag"`, the post-1.20.5 form); if a
  consume-advancement never fires, that's the thing to check.

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

## Roadmap (post-v1.0)

- **Water bottles:** plain water bottles aren't detected yet (they're all `minecraft:potion`;
  needs a `minecraft:potion_contents` component predicate — verify its exact shape in-game
  before shipping, and keep it in its own advancement so a bad predicate can't affect the
  rest). Milk/honey/soups/juicy foods already hydrate via `tags/item/water.json`.
- **Modded-food compat:** optional, absent-safe grant-tags classifying common Pantrywork /
  Farmer's Delight foods (modded ids in a tag simply no-op when the mod is missing).
- **HUD polish:** optional resource-pack companion with custom glyphs for a nicer bar.
- **GameTests:** on 1.21.5+ the `/test` framework can automate the eat→score checks.

See `DECISIONS.md` before re-opening any of the choices above. Ship store copy with every
release (`PUBLISHING.md`).
