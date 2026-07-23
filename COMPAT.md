# Nutriwork — modded food compatibility

Nutriwork is a **vanilla datapack** and stays 100% standalone. Modded-food support is an
**optional, absent-safe** layer: it references other mods' item tags with
`{"id": …, "required": false}`, so on vanilla (or with any mod missing) those refs simply
resolve to nothing and the pack loads clean. Delete the whole
`data/nutriwork/tags/item/compat/` folder to turn compat off — the core grant-tags point
to it with `required:false`, so they keep loading without it.

## How it plugs in (why it doesn't double-count)

Each compat tag is **included into the matching core grant-tag**, not given its own
advancement. So a modded steak that lives in `#c:foods/cooked_meat` becomes a member of
`#nutriwork:grant/protein_med` and fires that one existing advancement — same path a
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
| `protein_low` | +12 | `#c:foods/raw_meat`, `#c:foods/raw_fish`, `#c:eggs` |
| `protein_med` | +25 | `#c:foods/cooked_meat`, `#c:foods/cooked_fish`, `#c:foods/cheese`, `#c:foods/soup` |
| `sugar_low`   | +12 | `#c:foods/cookie` |
| `sugar_med`   | +25 | `#c:foods/pie`, `#pantrywork:food_component/sweetener` |
| `water`       | +30 | `#c:drinks/milk`, `#c:foods/soup`, `#pantrywork:food_component/liquid_base` |

Soups intentionally feed **both** protein and water — the modded echo of vanilla stews.

## Known, bounded quirk (modded servers only)

The `c:foods/*` convention also carries **vanilla** items on modded platforms (NeoForge/FD
populate it). Where a vanilla food's exact tier differs from the tier its broad `c:` group
routes to — e.g. `minecraft:cooked_beef` is `protein_high` for us, but `#c:foods/cooked_meat`
routes to `protein_med` — that food gains a small **same-group** top-up on a modded server
(here, +25 protein on top of its +40). It is always the same group, never a
mis-categorisation, and everything caps at 100. On vanilla there is no overlap and no
effect. Accepted as a fair trade for zero-maintenance breadth; see `DECISIONS.md`.

## Adding another mod

If a mod already follows the `c:foods/*` convention (most modern food mods do, and
Pantrywork bridges the big ones), **it already works** — no change needed. For a mod that
uses its own tags, add its tag to the relevant `compat/<grant-tag>.json` as
`{"id": "#thatmod:its_tag", "required": false}`, or to classify specific items,
`{"id": "thatmod:some_food", "required": false}`. Always `required:false`. Then `/reload`.
