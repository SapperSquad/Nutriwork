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

- **Buff-earned text is edge-triggered, gains only** (v1.4.0). `core/notify` compares this
  second's coverage/variety to last second's (`nw.cov_p`/`nw.var_p`) and announces only on
  the way up, so it never repeats while you stay fed. Shown in chat (not the actionbar) so it
  doesn't fight the HUD. Alex chose gains-only (no "you lost X" messages). Prev-scores start
  high (9) so joining with a decent diet isn't announced as "earning."

- **Per-bar toggles treat unset as shown** (v1.4.0). Each bar has an `nw.b_<track>` flag;
  `bars_setvis` shows a bar unless its flag is explicitly 0. Unset = shown means a `/reload`
  or a pack update never hides an already-joined player's bars (init only runs for new
  players). Replaced the old all-on/all-off `bars_show`/`bars_hide` with the flag-aware
  `bars_setvis`. This is the "adjustable HUD" — vanilla fixes bar *position*, so we make
  *which* bars show adjustable instead.

- **Decay is tuned by "minutes of play per food", not by feel** (v1.5.0). The number that
  matters is `value / decay`. At the original decay 4/min a cookie was worth 3 minutes and a
  steak 10, so holding five groups above 50 needed ~16 items per in-game day — nutrition
  became a chore. Now food decays 1/min and water 2/min: low/med/high foods buy 12/25/40
  minutes and a drink 15, so one balanced meal holds the buffs ~2½ in-game days. Water
  decays faster than food on purpose. Middle setting if it ever feels too lenient:
  `decay_food 2`.

- **Sugar must be reachable without a bakery** (v1.5.0). Sugar originally came only from
  cookie / pumpkin pie / honey bottle, so a player who doesn't bake could never fill it —
  which also made the 5-group Haste buff nearly unattainable. Sweet berries, glow berries and
  melon now count as `sugar_low`, making Sugar an early-game track. Foods deliberately sit in
  several tags (melon = fruit + sugar + water); one bite still grants each group once.

- **No cake, ever — it cannot work.** Cake is the obvious `sugar_high` candidate but
  `CakeBlock` feeds the player directly as a block interaction and never consumes an
  ItemStack, so `minecraft:consume_item` never fires. Verified in 1.21.1 source. Any cake
  entry would be a silent dead tag. Same caution applies to any future "eat the block" food.

- **Every tier must contain something** (v1.5.0). `sugar_high` and `grain_high` shipped empty
  for five versions — reachable in the code, unreachable in play. `tools/validate.ps1` now
  reports item counts per tier so an empty one is visible.

- **Junk food drains, it does not damage** (v1.6.0). Rotten flesh / spider eye / pufferfish
  drain Meat; poisonous potato drains Veg. Vanilla already punishes these with hunger and
  poison, so adding damage would double-dip and break "pause, never punish" — the cost is
  nutritional. This also completed the roster: all 41 vanilla foods (per `Foods.java`) are
  now accounted for. **`ominous_bottle` is deliberately excluded** — it is a raid-mechanic
  trigger, not nutrition; classifying it would imply food value it does not have.

- **Monotony is tracked per grant-TAG, not per item** (v1.6.0). A consume reward cannot see
  which item was eaten, so "the same food again" means "the same grant-tag fired again".
  Full value for the first two, half, then a quarter; `core/decay` forgives one step per
  minute so variety restores full value quickly. Serves the "balance is the reward" pillar
  more directly than anything else in the pack.

- **Presets are runtime overrides, not files to swap** (v1.6.0). `config/relaxed|normal|
  hardcore` just set the same constants, so they apply instantly and are undone by the next
  `/reload` (which re-runs `config/defaults`). Each one says so in chat. Permanent changes
  still belong in `config/defaults.mcfunction` — one source of truth for the numbers.

- **The advancement tree uses the `advancements={id=false}` selector as its "not earned"
  test** (v1.6.0), so there are no parallel flag objectives and earned players stop matching
  the selector entirely — the polling cost decays to nothing. Children use
  `minecraft:impossible` and are granted by command; only the root has a real trigger.

- **1.21.1 advancement `background` is a FULL texture path ending in `.png`.** The bare
  sprite id (`minecraft:gui/advancements/backgrounds/x`) is the **MC 26.1** form and renders
  as the black/magenta missing-texture checkerboard with *nothing* in the log. This machine
  caches jars for both 1.21.1 NeoForge and 26.x Fabric projects, so confirm a jar's
  `version.json` before copying any format out of it — reading the 26.1 jar is exactly how
  this got broken twice. `tools/validate.ps1` now enforces the 1.21.1 form.

- **Objective creation is idempotent-by-tolerance.** `core/load` re-adds objectives every
  `/reload`, which logs a harmless "already exists". Accepted deliberately — removing and
  re-adding would wipe player scores.
