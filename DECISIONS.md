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

- **Actionbar HUD, not bossbars (for v1).** A per-player bossbar dashboard needs
  per-player bossbar ids (macros keyed off an assigned integer) and couldn't be verified
  without a live client this pass. The actionbar readout uses live `score` text components,
  no macros, and is rock-solid. Bossbar/resource-pack polish is a documented future option.

- **Incentive over punishment.** Nutriwork withholds buffs and applies only *mild* penalties
  (hidden Weakness when dehydrated, brief Slowness when stuffed). It never deletes items,
  damages the player, or hard-starves — vanilla hunger is the stick.

- **Hydration from an item tag, water bottles deferred.** Milk, honey, soups and juicy
  foods hydrate via `tags/item/water.json` (all guaranteed-valid simple item ids). Plain
  water bottles are all `minecraft:potion` and need a `potion_contents` component predicate
  whose exact shape must be confirmed in-game; shipping an unverified predicate that might
  fail to load wasn't worth it for v1. It's a clean, isolated future add.

- **Players start mid-range**, not empty (fruit/veg/grain/meat 50, sugar 30, water 70), so
  a fresh player isn't instantly penalised and learns the system from a neutral state.

- **Default numbers:** tier values 40/25/12, hydration +30 per drink; decay 4/min (food)
  and 6/min (water); variety window 3 min; coverage threshold 50. All in one config
  function so servers retune freely. Chosen for a "eat a couple of times per Minecraft day
  to stay buffed" cadence; tune from play, not theory.

- **Objective creation is idempotent-by-tolerance.** `core/load` re-adds objectives every
  `/reload`, which logs a harmless "already exists". Accepted deliberately — removing and
  re-adding would wipe player scores.
