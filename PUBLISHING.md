# Nutriwork — store copy & changelog

Publish target: **Modrinth** + **CurseForge** (datapack). Creator: **SapperSquad**.
Environment: Data Pack. Loaders: Datapack. MC versions: **1.21, 1.21.1**.
License: split policy (Alex, 2026-07-28) - set **All Rights Reserved** in the
Modrinth/CurseForge project settings; the GitHub repo's LICENSE is **MIT**.

**UPLOAD THIS FILE to Modrinth/CurseForge:** `dist/Nutriwork-Datapack-v1.6.0.zip`
(pack.mcmeta at the zip root - stores require that). Attach
`Nutriwork-HUD-ResourcePack-v1.0.zip` as an *additional file* on the same version.
**Do NOT upload `Nutriwork-v1.6.0.zip`** - it is a zip-of-zips for GitHub/direct download
only; Modrinth rejects it with "No pack.mcmeta present for resourcepack file".

Legacy note: `Nutriwork-v1.6.0.zip` (built by `tools/build-release.ps1`) bundles the
**datapack** (required) + the **optional HUD resource pack** + an `INSTALL.txt`. Standalone
`Nutriwork-Datapack-v1.6.0.zip` and `Nutriwork-HUD-ResourcePack-v1.0.zip` are also in `dist/`
if a store prefers separate uploads.

## Tagline

> Your diet finally matters — a modern nutrition system in a vanilla datapack.

## Short description (≤ 256 chars)

> Eat a balanced diet, earn buffs. Six food tracks, real hydration, and a monotony penalty
> so variety actually wins. Junk food costs you. Diet-style depth as a pure vanilla
> datapack — no mods. 1.21–1.21.1.

## Long description

**Nutriwork brings the Diet mod's idea to vanilla — as a pure datapack.** No Fabric, no
Forge. Drop it into any 1.21 world or server and your meals start to count.

Every food feeds one or more of **six tracks** — 🍎 Fruit, 🥕 Veg, 🌾 Grain, 🍖 Meat,
🍬 Sugar, 💧 Water — and cooked or golden foods are worth more than raw. Keep several
tracks topped up and you'll hold **Regeneration, Resistance and Haste**; eat **four
different groups** in a sitting for the **Well-Fed** absorption bonus. Let your water run
low and you'll feel it. Gorge on one thing and you'll just get **stuffed** — variety beats
volume, always.

**Eat the same thing every day and it stops working.** A food you keep repeating gives
less and less — full value twice, then half, then a quarter. Eat something else for a
minute and it recovers. A varied plate always pays best; that's the whole point.

**And some things were never food.** Rotten flesh, spider eyes and pufferfish *drain* your
Meat track; poisonous potatoes drain Veg. Eating them in an emergency is still a fair
choice — it just isn't a free one. Every single vanilla food is accounted for.

- **Six nutrition tracks**, balanced-diet buffs that scale with how varied you eat
- **Hydration**, over-eating and cuisine-variety systems on top of the classic groups
- **Monotony penalty** — repetition gives diminishing returns, so variety genuinely wins
- **Junk food costs you** — spoiled and toxic food drains nutrition instead of doing nothing
- **Its own advancement tab** — Balanced Breakfast, Well Rounded, Full Plate and more
- A cycling **HUD** (`/trigger nw.hud`): bossbar dashboard or compact actionbar, plus a full
  **journal** readout — with an optional resource pack for food-group icons
- **Server-tunable** — every value in one config function, plus one-command balance presets
  (`relaxed` / `normal` / `hardcore`)
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
| `promo/gallery-5-variety.png` | gallery 5 - monotony + junk food (numbers read from config) |

Gallery order to upload: **3** (real gameplay), **1** (the six tracks), **5** (monotony +
junk food - the biggest differentiator), **2** (buff ladder), **4** (modded compat).

GenPromo reads `config/defaults.mcfunction` for the numbers on card 5, so retuning the
pack and re-running the generator keeps the art honest automatically.

## Version changelog — PASTE THIS into the upload form

Modrinth and CurseForge each have a **per-version** changelog field, and Modrinth builds the
project's Changelog tab by aggregating them. So paste **only the current version's block**,
never the whole history below (that section is the internal dev log).

v1.0–v1.5.1 were never published, so 1.6.0 ships as a **first release** — don't paste the
older entries; they advertise bugs no player ever had.

> **Nutriwork 1.6.0 — first release**
>
> Six nutrition tracks (fruit, veg, grain, meat, sugar, water) with balanced-diet buffs,
> hydration, over-eating and cuisine-variety systems.
>
> - **Monotony penalty** — eating the same food repeatedly gives diminishing returns, so
>   variety genuinely wins
> - **Junk food costs you** — rotten flesh, spider eyes, pufferfish and poisonous potatoes
>   drain nutrition instead of doing nothing
> - **Three HUD modes** — bossbar dashboard, compact actionbar, or off; hide any bar you
>   don't want
> - **Its own advancement tab**, an in-game guide book, and a full journal readout
> - **Server-tunable** — every value in one config file, plus `relaxed` / `normal` /
>   `hardcore` presets
> - **Modded-food ready** — reads `c:foods/*` and Pantrywork tags, verified against Farmer's
>   Delight, Croptopia, Pam's HarvestCraft and Ocean's/End's Delight
>
> **Optional:** the companion HUD resource pack (attached to this version) adds food-group
> icons to the bars. The datapack is complete without it.
>
> Vanilla 1.21–1.21.1. No mods required.

From 1.6.1 onward, paste only that release's new section and let the tab accumulate.

## Upload form settings

| Field | Value |
|---|---|
| Primary file | `dist/Nutriwork-Datapack-v1.6.0.zip` |
| Additional file | `dist/Nutriwork-HUD-ResourcePack-v1.0.zip` |
| Version number | `1.6.0` |
| Loaders | **Datapack** only (raw zip, no mod loader involved) |
| Game versions | **1.21**, **1.21.1** (pack_format 48 — verified against 1.21.1 `version.json`) |
| Server side | **Required** (the pack lives in the world; all logic is server-side) |
| Client side | **Unsupported** (nothing installs client-side; the HUD is vanilla bossbars) |
| License | **All Rights Reserved** (split policy — the GitHub repo stays MIT) |
| Modrinth categories | Game Mechanics (main), Food, Utility |
| CurseForge categories | Quality of Life (or Utility), + Miscellaneous |

**The resource pack is an ADDITIONAL FILE, not a dependency.** Modrinth's
required/optional flags apply to *dependencies* (other projects), not to extra files on a
version — additional files carry no flag, users just choose whether to download it. Say it's
optional in the changelog text (above) so nobody thinks they need it. Only split it into its
own Modrinth project + optional dependency if you later want it findable on its own.

## Changelog (internal dev log — do NOT paste wholesale)

### v1.6.0 - junk food, monotony, presets and an advancement tab
- **Junk food now costs you.** Rotten flesh, spider eyes and pufferfish drain your Meat
  track; poisonous potatoes drain Veg. Every one of Minecraft's 41 foods is now accounted
  for. (Vanilla already punishes these with hunger and poison - Nutriwork's cost is
  nutritional, never direct damage.)
- **Variety beats repetition.** Eating the same food over and over gives less: full value
  twice, then half, then a quarter. A minute of eating anything else forgives a step.
- **Balance presets:** `/function nutriwork:config/relaxed | normal | hardcore`.
- **A real advancement tab** - Balanced Breakfast, Well Rounded, Full Plate, Well Hydrated,
  Varied Palate, and two you earn the hard way.

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
