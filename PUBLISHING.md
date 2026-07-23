# Nutriwork — store copy & changelog

Publish target: **Modrinth** + **CurseForge** (datapack). Creator: **SapperSquad**.
Environment: Data Pack. Loaders: Datapack. MC versions: **1.21, 1.21.1**.

## Tagline

> Your diet finally matters — a modern nutrition system in a vanilla datapack.

## Short description (≤ 256 chars)

> Eat a balanced diet, earn buffs. Nutriwork sorts every food into six tracks — fruit,
> veg, grain, meat, sugar, water — and rewards variety with Regeneration, Resistance,
> Haste and more. Diet-style depth, zero mods. 1.21–1.21.1.

## Long description

**Nutriwork brings the Diet mod's idea to vanilla — as a pure datapack.** No Fabric, no
Forge. Drop it into any 1.21 world or server and your meals start to count.

Every food feeds one or more of **six tracks** — 🍎 Fruit, 🥕 Veg, 🌾 Grain, 🍖 Meat,
🍬 Sugar, 💧 Water — and cooked or golden foods are worth more than raw. Keep several
tracks topped up and you'll hold **Regeneration, Resistance and Haste**; eat **four
different groups** in a sitting for the **Well-Fed** absorption bonus. Let your water run
low and you'll feel it. Gorge on one thing and you'll just get **stuffed** — variety beats
volume, always.

- **Six nutrition tracks**, balanced-diet buffs that scale with how varied you eat
- **Hydration**, over-eating and cuisine-variety systems on top of the classic groups
- A cycling **HUD** (`/trigger nw.hud`): bossbar dashboard or compact actionbar, plus a full
  **journal** readout — with an optional resource pack for food-group icons
- **Server-tunable** — every value in one config function, `/reload` to apply
- **Data-driven foods** — reclassify anything by editing one item tag
- **Modded-food ready** — reads `c:foods/*` and Pantrywork tags; no-ops on vanilla
- Clean uninstall, no leftover scoreboards

Runs anywhere vanilla does. Made by SapperSquad.

## Changelog

### v1.3.0 — bossbar HUD + optional icon pack
- `/trigger nw.hud` now cycles three HUD modes: off → a six-bar bossbar dashboard →
  the compact actionbar line.
- Optional companion resource pack adds food-group icons to the bars (opt in with
  `/function nutriwork:hud/icons_on`; the datapack is fully playable without it).

### v1.2.0 — water bottles hydrate
- Drinking a plain water bottle now fills the hydration track, alongside milk, honey,
  soups and juicy foods.

### v1.1.0 — modded food support
- Optional, absent-safe compatibility with the `c:foods/*` convention and **Pantrywork**'s
  interop tags — foods from Farmer's Delight, Croptopia, Pam's HarvestCraft, Ocean's/End's
  Delight and any mod following the convention are sorted automatically.
- Per-species meat tiering (cooked beef & pork outrank chicken, fish and the rest), so
  vanilla foods are never double-counted when a food mod is present.
- Zero impact on vanilla worlds: compat tags no-op when the mods aren't present, and the
  `compat/` folder is deletable to switch it off.

### v1.0.0 — first release
- Six nutrition tracks (fruit, veg, grain, meat/protein, sugar, hydration) with per-food
  point tiers, covering the vanilla food roster.
- Balanced-diet buffs: coverage tiers (Regen / Resistance / Haste), Well-Fed cuisine
  variety (Absorption), hydration penalties, and an over-eating "stuffed" penalty.
- Actionbar HUD (`/trigger nw.hud`) and `/function nutriwork:journal` readout.
- One-function tuning surface; data-driven food classification via item tags.
- Admin helpers (fill/clear/reset/help) and a clean uninstall.

> Maintenance reminder: bump this file's copy and changelog with **every** release, and
> re-check any promo screenshots/art for numbers that have since changed.
