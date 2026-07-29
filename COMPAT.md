# Nutriwork — modded food compatibility

Nutriwork is a **vanilla datapack** and stays 100% standalone. Modded-food support is an
**optional, absent-safe** layer: it references other mods' item tags with
`{"id": …, "required": false}`, so on vanilla (or with any mod missing) those refs simply
resolve to nothing and the pack loads clean. Delete the whole
`data/nutriwork/tags/item/compat/` folder to turn compat off — the core grant-tags point
to it with `required:false`, so they keep loading without it.

## How it plugs in (why it doesn't double-count)

Each compat tag is **included into the matching core grant-tag**, not given its own
advancement. So a modded steak in `#c:foods/cooked_beef` becomes a member of
`#nutriwork:grant/protein_high` and fires that one existing advancement — same path a
vanilla food takes. Because it's one tag, an item that appears via several routes is
deduplicated and still grants **once** per bite.

## Integration point

Built against **Pantrywork** (`C:\Users\alexh\Documents\Pantrywork`), Alex's food-interop
mod. Pantrywork is the "ore dictionary for food": it bridges Farmer's Delight, Croptopia,
Pam's, Ocean's/End's Delight and more into two standard tag axes, and Nutriwork consumes
both:

- **Identity tags** `c:foods/*` — what a food *is*. This is the FD/NeoForge convention
  Pantrywork extends, so hooking it also picks up any other mod that follows it.
- **Role tags** `pantrywork:food_component/*` — what a food *does in a dish*. Used where an
  identity tag doesn't cleanly exist (sweetener, liquid base).

## Mapping (`compat/<grant-tag>` ← modded tags)

| Nutriwork grant-tag | Points | Modded tags routed in |
|---|---|---|
| `fruit_low`   | +12 | `#c:foods/berry` |
| `fruit_med`   | +25 | `#c:foods/fruit` |
| `veg_med`     | +25 | `#c:foods/vegetable`, `#c:foods/leafy_green` |
| `grain_med`   | +25 | `#c:foods/bread`, `#c:foods/pasta`, `#c:foods/cooked_rice` |
| `protein_high`| +40 | `#c:foods/cooked_beef`, `#c:foods/cooked_pork` |
| `protein_med` | +25 | `#c:foods/cooked_chicken`, `#c:foods/cooked_mutton`, `#c:foods/cooked_rabbit`, `#c:foods/cooked_bacon`, `#c:foods/cooked_fish`, `#c:foods/roasted_dragon_meat`, `#c:foods/roasted_shulker_meat`, `#c:foods/cheese`, `#c:foods/soup` |
| `protein_low` | +12 | `#c:foods/raw_beef`, `#c:foods/raw_pork`, `#c:foods/raw_chicken`, `#c:foods/raw_mutton`, `#c:foods/raw_rabbit`, `#c:foods/raw_fish`, `#c:eggs` |
| `sugar_low`   | +12 | `#c:foods/cookie` |
| `sugar_med`   | +25 | `#c:foods/pie`, `#pantrywork:food_component/sweetener` |
| `water`       | +30 | `#c:drinks/milk`, `#c:foods/soup`, `#pantrywork:food_component/liquid_base` |

Soups intentionally feed **both** protein and water — the modded echo of vanilla stews.

## Double-count: meats are exact, fruit/veg have a tiny residual

The `c:foods/*` convention also carries **vanilla** items on modded platforms (NeoForge/FD
populate it), so a broad category tag routed to one tier can top up a vanilla food that
sits at a different tier.

**Meats are handled exactly.** Each species tag is routed to the tier of its vanilla
counterpart (`cooked_beef`/`cooked_pork` → high, `cooked_chicken`/`mutton`/`rabbit`/`fish`
→ med, all raws → low), so a vanilla cooked steak lands in `protein_high` via both its
explicit entry and `#c:foods/cooked_beef` — one tag, deduplicated, granted once. No
double-count. (The trade: a modded meat tagged *only* into the broad `#c:foods/cooked_meat`
parent, with no species tag, isn't picked up — add it to the relevant `compat/protein_*`
file if a mod does that.)

**Fruit & veg keep a deliberate residual.** `#c:foods/fruit` and `#c:foods/vegetable` are
broad and have no per-tier species tags, so a low-tier vanilla item that also sits in them
(e.g. a potato, at `veg_low`, inside `#c:foods/vegetable` → `veg_med`) can gain a small
**same-group** top-up on a modded server. It's always the same group, never a
mis-categorisation, capped at 100, and zero effect on vanilla. Kept on purpose: dropping
the broad fruit/veg tags would lose most modded fruit/veg coverage (Croptopia alone adds
hundreds). Worth far more than trimming a few points off a vanilla potato. See
`DECISIONS.md`.

## Verified working (2026-07-28)

Run headless against Pantrywork's dev server (all compat mods loaded) with
`tools/modded-tagtest.txt` via its RCON harness — see `CLAUDE.md` "Release checks".
**12/12 passed**, proving modded foods land in the right grant tags:

| Mod | Item | Lands in |
|---|---|---|
| Farmer's Delight | cooked_bacon / bacon | protein_med / protein_low |
| Farmer's Delight | cabbage, tomato | veg_med |
| Croptopia | strawberry / cabbage | fruit_med / veg_med |
| Pam's HarvestCraft | fresh milk | water |
| Ocean's Delight | cooked_guardian_tail | protein_med |
| End's Delight | roasted / raw dragon meat | protein_med / protein_low |
| *vanilla control* | cooked_beef, sweet_berries | protein_high, sugar_low |

That test found a real gap: dropping the broad `#c:foods/raw_meat` parent (to stop
double-counting) meant **exotic raw meats** — dragon, endermite, shulker — matched nothing.
They now have explicit species entries in `compat/protein_low`.

**Known upstream gap (not ours):** some Ocean's Delight dishes, e.g.
`oceansdelight:cooked_stuffed_cod`, aren't classified by Pantrywork, so nothing routes them.
Fixing that belongs in Pantrywork's `c:foods/cooked_fish`.

## Adding another mod

If a mod already follows the `c:foods/*` convention (most modern food mods do, and
Pantrywork bridges the big ones), **it already works** — no change needed. For a mod that
uses its own tags, add its tag to the relevant `compat/<grant-tag>.json` as
`{"id": "#thatmod:its_tag", "required": false}`, or to classify specific items,
`{"id": "thatmod:some_food", "required": false}`. Always `required:false`. Then `/reload`.
