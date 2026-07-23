# Nutriwork — decisions log

Judgment calls already made, with reasons. Reopen only with new evidence.

- **Vanilla datapack, no mod.** The whole point. Everything is built from commands,
  advancements, tags, scoreboards. No custom items/effects/GUI. If a request needs those,
  it's a mod, not this pack.

- **Value lives in the grant-tag intersection.** A `consume_item` reward function can't
  read *which* item was eaten, so a food's group and worth are encoded by which grant-tag
  it's in (`<group>_<tier>`). This is why classification is the entire data model, and why
  "read the item and look up its value" is not on the table — that path doesn't exist in
  vanilla.

- **Short, hidden, refreshed ambient effects — not long ones.** Buffs are re-applied every
  second with a 3s duration. Gives responsiveness (they fade when your diet slips) and the
  correct milk behaviour (a milk chug clears them, they return next tick). Long durations
  would be a false economy and let players eat once and coast.

- **HUD is a 3-mode cycle: off → bossbars → actionbar** (`/trigger nw.hud`). v1 shipped only
  the actionbar (rock-solid, no macros) because per-player bossbars need per-player ids;
  v1.3.0 added the bossbar dashboard. Per-player ids come from an integer counter
  (`#next nw.id`, assigned once on first join) so bossbar names (`nutriwork:h<id>_<track>`,
  path-safe) never collide — cleaner than name/UUID-based ids. Bars are macro-updated from
  the `nw.*` scores each second. The actionbar stays as mode 2 for players who prefer it and
  as the macro-free fallback. Both are static-validated; the bossbar/macro path is the part
  most worth a live-client glance.

- **Resource-pack icons are opt-in per player.** The companion pack (`resourcepack/`) adds a
  custom font of six glyphs (U+E000–E005). A datapack can't detect whether a client applied
  a pack, and unknown glyphs render as boxes — so icon mode is a per-player flag
  (`nw.icons`, `hud/icons_on`/`icons_off`) defaulting off, and the default bars use plain,
  vanilla-safe text labels. Glyph PNGs are code-generated (`tools/GenHudIcons.java`, Java
  only) rather than hand-drawn; their font alignment is the one thing flagged for a human
  eye since it can't be verified headless.

- **Incentive over punishment.** Nutriwork withholds buffs and applies only *mild* penalties
  (hidden Weakness when dehydrated, brief Slowness when stuffed). It never deletes items,
  damages the player, or hard-starves — vanilla hunger is the stick.

- **Hydration comes from an item tag, plus a verified water-bottle predicate.** Milk,
  honey, soups and juicy foods hydrate via `tags/item/water.json` (simple item ids). Plain
  water bottles (all `minecraft:potion`) get their own advancement (`eat/water_bottle`)
  using `minecraft:potion_contents: ["minecraft:water"]`. The predicate is **not a guess** —
  its shape was read from 1.21.1 source: `ItemPotionsPredicate` registers as `potion_contents`
  with a `HolderSet<Potion>` value (hence the list form), and `ItemPredicate` nests
  sub-predicates under `predicates`. Kept isolated so even a wrong predicate could only ever
  affect water bottles. Only `minecraft:water` matches — awkward/mundane brewing bases are
  intentionally left out.

- **Players start mid-range**, not empty (fruit/veg/grain/meat 50, sugar 30, water 70), so
  a fresh player isn't instantly penalised and learns the system from a neutral state.

- **Default numbers:** tier values 40/25/12, hydration +30 per drink; decay 4/min (food)
  and 6/min (water); variety window 3 min; coverage threshold 50. All in one config
  function so servers retune freely. Chosen for a "eat a couple of times per Minecraft day
  to stay buffed" cadence; tune from play, not theory.

- **Modded-food compat is included *into* the grant-tags, not parallel advancements.**
  Adding separate compat advancements keyed on `#c:foods/*` would double-count every
  vanilla food (those tags also carry vanilla items on modded platforms), since the item
  would fire both its core advancement and the compat one. Instead each `compat/<tier>`
  tag is nested into the matching core grant-tag, so an item present via several routes is
  deduplicated in one tag and grants once. Cost: the 9 grant-tags now reference their
  compat tag — but with `required:false`, so the `compat/` folder stays deletable.

- **Compat refs are all `{"id":…,"required":false}`** (Pantrywork's rule #1). The pack
  must load on vanilla with zero modded tags present. Verified: 20 cross-mod refs, all
  optional.

- **Meats routed by per-species tags, not the broad parent.** `#c:foods/cooked_meat` /
  `#c:foods/raw_meat` mix tiers (beef is high, chicken is med), so routing the parent
  double-counted vanilla meats on modded servers. Replaced with species tags matched to
  each vanilla tier (`cooked_beef`/`cooked_pork`→high, `chicken`/`mutton`/`rabbit`/`fish`→
  med, raws→low), so vanilla meats dedup in one tag and never double-count. Exotic modded
  meats kept via their own species tags (`roasted_dragon_meat`, `roasted_shulker_meat`).
  Trade: a meat tagged *only* into the broad parent isn't caught — acceptable, add it to
  `compat/protein_*` if needed.

- **A tiny same-group residual remains for fruit/veg only, on purpose.** `#c:foods/fruit`
  and `#c:foods/vegetable` are broad with no per-tier species tags, so a low-tier vanilla
  item inside them (e.g. potato) can get a small same-group top-up on modded servers.
  Always same-group, capped at 100, zero effect on vanilla. Kept because dropping the broad
  fruit/veg tags would lose most modded fruit/veg coverage — a far bigger loss than a few
  points on a vanilla potato. Details in `COMPAT.md`.

- **Six bossbars, accepting the vanilla top-third cap.** In-game testing (2026-07-23)
  confirmed the client only renders bossbars in the top third of the GUI
  (`BossHealthOverlay`: stops at `j >= guiHeight()/3`). Six bars fit at GUI Scale ≤ 2 or in
  a tall window, but the bottom one or two (Sugar, Water) clip at high GUI scale / small
  windows. Kept six bars (the full dashboard is the point) rather than dropping tracks; the
  actionbar HUD mode shows all six on one line regardless and is the documented fallback for
  clipped setups. All six bars always exist and update — clipping is display-only.

- **Objective creation is idempotent-by-tolerance.** `core/load` re-adds objectives every
  `/reload`, which logs a harmless "already exists". Accepted deliberately — removing and
  re-adding would wipe player scores.
