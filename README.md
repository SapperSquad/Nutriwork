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
| 💧 **Water** | water bottles, milk, honey, soups, juicy fruits |

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

Press **`/trigger nw.hud`** to cycle the HUD through three modes: **off → bossbars →
actionbar**. The bossbar mode shows six colour-coded bars at the top of the screen, one per
track, each filling 0–100 with its live value. **`/function nutriwork:journal`** prints a
full breakdown in chat any time, including which buffs you currently qualify for.

Don't want all six bars? Toggle any of them on/off with
`/function nutriwork:hud/bar/<track>` (fruit/veg/grain/meat/sugar/water). And when you
*earn* a buff, a one-time message tells you which one.

Want food-group icons on the bars instead of words? There's an optional companion resource
pack — see `HUD.md`.

## Install

The download (`Nutriwork-v1.3.0.zip`) contains two packs and an `INSTALL.txt`:

1. **Nutriwork Datapack.zip** (required) — drop into your world's `datapacks/` folder
   (single-player: *Open World Folder → datapacks*; server: `world/datapacks/`), then
   `/reload` (or rejoin). You'll see a green "Nutriwork loaded" message.
2. **Nutriwork HUD Resource Pack.zip** (optional) — drop into `resourcepacks/`, enable it,
   then run `/function nutriwork:hud/icons_on` for food-group icons on the bars. Everything
   works without it (plain text labels).

That's it — nutrition tracks itself from your first bite. To remove cleanly:
`/function nutriwork:admin/uninstall`, then delete the pack and `/reload`.

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
