# Nutriwork — store copy & changelog

Publish target: **Modrinth** + **CurseForge** (datapack). Creator: **SapperSquad**.
Environment: Data Pack. Loaders: Datapack. MC versions: **1.21, 1.21.1**.
License: **All Rights Reserved** (see README) - personal use only, no redistribution or
modpack inclusion without permission. Set this in the Modrinth/CurseForge project settings.

Release file: `Nutriwork-v1.5.1.zip` (built by `tools/build-release.ps1`) bundles the
**datapack** (required) + the **optional HUD resource pack** + an `INSTALL.txt`. Standalone
`Nutriwork-Datapack-v1.5.1.zip` and `Nutriwork-HUD-ResourcePack-v1.0.zip` are also in `dist/`
if a store prefers separate uploads.

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

## Promo art

Regenerate everything with `javac tools/GenPromo.java -d build/tools && java -cp build/tools GenPromo promo`.
Art that states numbers or features must stay regenerable - edit GenPromo.java, never the PNG.

| File | Use |
|---|---|
| `promo/icon.png` (512) | project icon |
| `promo/banner.png` (1920x640) | header / social card |
| `promo/gallery-1-tracks.png` | gallery 1 - the six tracks |
| `promo/gallery-2-buffs.png` | gallery 2 - buff ladder |
| `promo/gallery-3-hud.png` | gallery 3 - REAL in-game HUD |
| `promo/gallery-4-compat.png` | gallery 4 - vanilla + modded |

Gallery order to upload: 3 (real gameplay), 1, 2, 4.

## Changelog

### v1.5.1 - test coverage + modded compat verified
- Added an in-game smoke test (/function nutriwork:test/smoke) that proves eating works on
  every track; run it before every release.
- **Modded compat verified for the first time** against Farmer's Delight, Croptopia, Pam's
  HarvestCraft, Ocean's Delight and End's Delight - 12/12 checks pass.
- Fixed: exotic raw meats (dragon, endermite, shulker) matched no tag and granted nothing.

### v1.5.0 — balance pass: nutrition now lasts
- **Decay slowed to a sane pace.** Food drains 1/min (was 4) and water 2/min (was 6). A
  balanced meal now keeps you buffed for roughly 2½ in-game days instead of demanding
  a dozen-plus items per day. One steak = ~2 days of protein; one drink = ~15 minutes.
- **Sugar is reachable early.** Sweet berries, glow berries and melon now count toward
  Sugar, so you no longer need a bakery to complete a balanced diet (and to reach Haste).
- **Filled the unreachable tiers.** `sugar_high` (honey bottle, enchanted golden apple)
  and `grain_high` (pumpkin pie) had no foods at all — every tier is now attainable.
- Cuisine-variety window widened 3 → 5 minutes so Well-Fed fits a normal meal.

### v1.4.1 — critical fix: eating now actually feeds your diet
- **Fixed:** every food's reward function failed to load (an `advancement revoke` was
  missing its required mode keyword), so eating never added to your nutrition tracks.
  All 17 are fixed. **This is the fix that makes the pack work as intended.**
- Upgrading from an earlier version? Run `/function nutriwork:admin/rearm` once — it
  clears eat-detection that got stuck while the bug was live.
- Guide book split into shorter pages so no page overflows, and it now uses a custom book
  model (with the resource pack applied).

### v1.4.0 — buff notifications, adjustable bars, in-game guide
- On-screen text now announces each buff the moment you earn it (Regeneration, Resistance,
  Haste, Well-Fed) — once, on the way up, never spammy.
- Each HUD bar can be toggled on/off per player (`/function nutriwork:hud/bar/<track>`), so
  you can trim the dashboard to the tracks you care about and dodge the top-third clip.
- New players receive a **Nutrition Guide** book explaining the six groups, the buffs and
  their thresholds, hydration, decay and the commands — grab a copy any time with
  `/function nutriwork:book`.

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
