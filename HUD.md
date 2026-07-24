# Nutriwork — HUD

Nutriwork can show your nutrition three ways. Cycle them with **`/trigger nw.hud`**:

1. **Off** — no on-screen HUD.
2. **Bossbars** (first press) — six labelled bars at the top of the screen, one per track
   (Fruit, Veg, Grain, Meat, Sugar, Water). Each fills 0–100 and shows its live value in the
   label, coloured to match the group.
3. **Actionbar** — one compact line above the hotbar with all six numbers.

**`/function nutriwork:journal`** prints the full breakdown in chat any time, including which
buffs you currently qualify for. And when you actually **earn** a buff (cross into
Regeneration, Resistance, Haste or Well-Fed), a one-time line tells you which — only on the
way up, so it never spams.

## Choosing which bars show

Don't want all six? Toggle any bar on or off, per player:

    /function nutriwork:hud/bar/fruit     (or veg / grain / meat / sugar / water)

Chat confirms "shown"/"hidden". Hiding a couple (say Sugar + Water) keeps the rest fitting
cleanly at any GUI scale — the tracks still update in the background, they're just not drawn.
(Vanilla fixes *where* bossbars appear, so this controls *which* show, not their position.)

**Only seeing four or five bars?** Minecraft only draws bossbars in the top third of the
screen, so at a high GUI Scale (or in a small window) the bottom bars (Sugar, Water) get cut
off — they still exist and update, they're just not drawn. Lower your **GUI Scale to 2** (or
smaller) in Options → Video Settings to fit all six, or press `/trigger nw.hud` again to
switch to the **actionbar** mode, which shows all six on one line at any scale.

## How the bossbars work (for pack authors)

Each player gets six bossbars named `nutriwork:h<id>_<track>`, where `<id>` is a small
integer assigned on first join (counter `#next nw.id`, so ids never collide or get reused).
They're built once (`hud/bars_create`), refreshed each second while in bars mode
(`hud/bars_update`, via a macro keyed on the player's id), and shown/hidden by the toggle.
Values come straight off the `nw.*` scoreboards, so the bars can't drift out of sync.
`/function nutriwork:admin/uninstall` removes every bossbar.

## Optional resource pack — food-group icons

`dist/Nutriwork-HUD-ResourcePack-v1.0.zip` adds a custom font (`nutriwork:hud`) of six small
colour-coded glyphs, one per track (U+E000–U+E005). It is **optional and purely cosmetic** —
the datapack works fully without it.

To use it:
1. Apply the resource pack (drop the zip into `resourcepacks/` and enable it, or set it as a
   server resource pack).
2. Per player: **`/function nutriwork:hud/icons_on`** switches your bar labels to the icons;
   **`/function nutriwork:hud/icons_off`** goes back to text.

Icons are **opt-in per player and default off** on purpose: without the pack applied the
glyphs render as missing-character boxes, so only players who've applied it should turn them
on.

Regenerate the icons with `tools/GenHudIcons.java`
(`javac tools/GenHudIcons.java -d build/tools && java -cp build/tools GenHudIcons <textures/font dir>`)
— Java only, matching the rest of the toolchain. The glyph vertical alignment
(`ascent`/`height` in `assets/nutriwork/font/hud.json`, currently 7/8) is set to sensible
defaults but is the one thing worth eyeballing in a client and nudging if an icon sits a
pixel high or low beside the number. Resource-pack format is **34** (MC 1.21/1.21.1) — bump
it for other versions.
