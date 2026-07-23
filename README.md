# Nutriwork

**A modern nutrition system for Minecraft — as a vanilla datapack.** No mods, no Fabric,
no Forge. Drop it in and your diet starts to matter: eat a balanced spread of foods and
you earn passive buffs; live on cookies alone and you won't.

Inspired by the **Diet** mod, rebuilt with commands so it runs on any vanilla 1.21 / 1.21.1
world or server.

## The six tracks

Every food you eat feeds one or more of six tracks (0–100):

| Track | Fed by (examples) |
|-------|-------------------|
| 🍎 **Fruit** | apple, melon, sweet/glow berries, golden apple |
| 🥕 **Veg** | carrot, potato, baked potato, beetroot, dried kelp |
| 🌾 **Grain** | bread, cookie, pumpkin pie |
| 🍖 **Meat / Protein** | cooked & raw meats and fish, stews |
| 🍬 **Sugar** | cookie, pumpkin pie, honey bottle |
| 💧 **Water** | milk, honey, soups, juicy fruits |

Cooked foods and "golden" foods are worth more than raw. Some foods count twice — a
pumpkin pie feeds **grain and sugar**, a melon slice feeds **fruit and water**.

## What a balanced diet gets you

Buffs refresh continuously while your diet holds and fade a few seconds after it slips:

- **3+ groups at 50%** → Regeneration
- **4+ groups at 50%** → + Resistance
- **all 5 groups at 50%** → + Haste
- **ate 4+ different groups recently** → **Well-Fed**: Absorption hearts
- **low on water** → Weakness (and Slowness if you're really parched) — so drink up
- **gorging when already full** → briefly "stuffed" (Slowness); variety beats volume

## The HUD

Run **`/trigger nw.hud`** to toggle a compact readout of all six tracks above your
hotbar. **`/function nutriwork:journal`** prints a full breakdown, including which buffs
you currently qualify for.

## Install

1. Download and drop `Nutriwork` into your world's `datapacks/` folder (single-player:
   *Open World Folder → datapacks*; server: `world/datapacks/`).
2. `/reload` (or rejoin). You'll see a green "Nutriwork loaded" message.
3. That's it — nutrition tracks itself from your first bite.

To remove cleanly: `/function nutriwork:admin/uninstall`, then delete the pack and
`/reload`.

## Server tuning

Open `data/nutriwork/function/config/defaults.mcfunction` — every number (food values,
decay rates, the variety window) is there. Edit and `/reload`.

## Adding or re-tagging foods

Nutrition classification is plain item tags in `data/nutriwork/tags/item/grant/`. Want
sweet berries to count as a bigger fruit? Move `minecraft:sweet_berries` from `fruit_low`
to `fruit_med`. One line, then `/reload`.

## Compatibility

Pure vanilla data — no conflicts with other datapacks unless they also use the `nw.*`
scoreboard names or the `#minecraft:tick`/`#minecraft:load` tags (both merge fine).

**Modded foods are supported** (optional, absent-safe). Nutriwork reads the standard
`c:foods/*` food tags and Alex's **Pantrywork** interop tags, so foods from Farmer's
Delight, Croptopia, Pam's HarvestCraft, Ocean's/End's Delight and any mod following the
convention get sorted automatically — install Pantrywork for the widest coverage. On
vanilla, or with those mods absent, the compat tags simply do nothing. See `COMPAT.md`
for the mapping and how to add more mods.

---

Made by **SapperSquad**. Part of a wider suite of Minecraft mods and packs.
