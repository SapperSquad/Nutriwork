// Regenerates every image in promo/ from code. ASCII-only, Java only (no Python/Node here).
// Same philosophy as ReelRivals/GenCards.java and Pantrywork/GenPromo.java: promo art that
// makes content claims must be regenerable, never a source-less PNG. If a number or feature
// changes, edit it HERE and re-run so the art can never drift from the pack.
//
//   javac tools/GenPromo.java -d build/tools && java -cp build/tools GenPromo promo
//
// Outputs: icon.png 512, banner.png 1920x640, gallery-1..4 1280x720.
// gallery-3 frames a REAL in-game screenshot (promo/hud-bossbars.png) if present.
import java.awt.*;
import java.awt.geom.*;
import java.awt.image.BufferedImage;
import java.io.File;
import javax.imageio.ImageIO;

public class GenPromo {
    // the six nutrition tracks - colours match the in-game bossbar colours
    static final String[] TRACK = { "FRUIT", "VEG", "GRAIN", "MEAT", "SUGAR", "WATER" };
    static final String[] FOODS = { "apples, berries", "carrots, potato", "bread, pie",
                                    "cooked meat, fish", "berries, honey", "drinks, soups" };
    static final Color[] C = {
        new Color(0xE2,0x3B,0x3B), new Color(0x4C,0xAF,0x3E), new Color(0xE0,0xB2,0x3B),
        new Color(0x9B,0x4D,0xCA), new Color(0xE8,0x6A,0xA8), new Color(0x3B,0x8B,0xE2) };
    static final Color BG   = new Color(0x14,0x17,0x1C);
    static final Color BG2  = new Color(0x1E,0x24,0x2B);
    static final Color INK  = new Color(0xF2,0xF5,0xF7);
    static final Color DIM  = new Color(0x9A,0xA5,0xB1);
    static final Color GOLD = new Color(0xE8,0xC0,0x60);

    static Graphics2D g2(BufferedImage img) {
        Graphics2D g = img.createGraphics();
        g.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
        g.setRenderingHint(RenderingHints.KEY_TEXT_ANTIALIASING, RenderingHints.VALUE_TEXT_ANTIALIAS_ON);
        g.setRenderingHint(RenderingHints.KEY_RENDERING, RenderingHints.VALUE_RENDER_QUALITY);
        g.setRenderingHint(RenderingHints.KEY_STROKE_CONTROL, RenderingHints.VALUE_STROKE_PURE);
        g.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BILINEAR);
        return g;
    }
    static Font f(int size, int style) {
        String[] prefer = { "Segoe UI Semibold", "Segoe UI", "Arial" };
        for (String n : prefer) { Font ft = new Font(n, style, size); if (!ft.getFamily().equals("Dialog")) return ft; }
        return new Font(Font.SANS_SERIF, style, size);
    }
    static void center(Graphics2D g, String s, int cx, int y) {
        int w = g.getFontMetrics().stringWidth(s);
        g.drawString(s, cx - w / 2, y);
    }
    static void backdrop(Graphics2D g, int w, int h) {
        g.setPaint(new GradientPaint(0, 0, BG, 0, h, BG2));
        g.fillRect(0, 0, w, h);
        // subtle stripe of the six colours across the bottom edge
        int bw = w / 6;
        for (int i = 0; i < 6; i++) {
            g.setColor(new Color(C[i].getRed(), C[i].getGreen(), C[i].getBlue(), 190));
            g.fillRect(i * bw, h - 8, bw, 8);
        }
    }
    /** a filled nutrition bar like the in-game bossbar */
    static void bar(Graphics2D g, int x, int y, int w, int h, Color c, double pct) {
        g.setColor(new Color(255,255,255,26));
        g.fill(new RoundRectangle2D.Float(x, y, w, h, h, h));
        g.setColor(c);
        g.fill(new RoundRectangle2D.Float(x, y, (int)(w * pct), h, h, h));
    }

    /** Reads a constant straight out of config/defaults.mcfunction so the art can never
     *  drift from the pack's real numbers. Falls back to the default if not found. */
    static int cfg(String name, int fallback) {
        try {
            File f = new File("data/nutriwork/function/config/defaults.mcfunction");
            if (!f.exists()) return fallback;
            for (String line : java.nio.file.Files.readAllLines(f.toPath())) {
                String s = line.trim();
                if (s.startsWith("scoreboard players set #" + name + " nw.const ")) {
                    return Integer.parseInt(s.substring(s.lastIndexOf(' ') + 1).trim());
                }
            }
        } catch (Exception ignored) { }
        return fallback;
    }

    public static void main(String[] args) throws Exception {
        File out = new File(args.length > 0 ? args[0] : "promo");
        out.mkdirs();
        icon(new File(out, "icon.png"));
        banner(new File(out, "banner.png"));
        galleryTracks(new File(out, "gallery-1-tracks.png"));
        galleryBuffs(new File(out, "gallery-2-buffs.png"));
        galleryShot(new File(out, "gallery-3-hud.png"), new File(out, "hud-clean.png"));
        galleryCompat(new File(out, "gallery-4-compat.png"));
        galleryVariety(new File(out, "gallery-5-variety.png"));
        System.out.println("promo art written to " + out.getAbsolutePath());
    }

    /** the six-track ring with an apple in the middle, centred on (cx,cy) with radius r */
    static void ringApple(Graphics2D g, int cx, int cy, int r) {
        int th = Math.max(10, r / 4);
        Stroke old = g.getStroke();
        g.setStroke(new BasicStroke(th, BasicStroke.CAP_BUTT, BasicStroke.JOIN_ROUND));
        for (int i = 0; i < 6; i++) {
            g.setColor(C[i]);
            g.draw(new Arc2D.Float(cx - r, cy - r, r * 2, r * 2, 90 - i * 60 - 4, -52, Arc2D.OPEN));
        }
        g.setStroke(old);
        double s = r / 190.0;
        g.setColor(new Color(0xD8,0x3A,0x3A));
        g.fill(new Ellipse2D.Double(cx - 78*s, cy - 58*s, 156*s, 150*s));
        g.fill(new Ellipse2D.Double(cx - 96*s, cy - 34*s, 84*s, 116*s));
        g.fill(new Ellipse2D.Double(cx + 12*s, cy - 34*s, 84*s, 116*s));
        g.setColor(new Color(0x6B,0x43,0x28));
        g.fill(new RoundRectangle2D.Double(cx - 8*s, cy - 96*s, 16*s, 46*s, 8*s, 8*s));
        g.setColor(new Color(0x6F,0xC0,0x4A));
        g.fill(new Ellipse2D.Double(cx + 6*s, cy - 100*s, 62*s, 34*s));
    }

    // ---- icon: six-segment ring (the six tracks) around an apple ----
    static void icon(File file) throws Exception {
        int S = 512;
        BufferedImage img = new BufferedImage(S, S, BufferedImage.TYPE_INT_ARGB);
        Graphics2D g = g2(img);
        g.setPaint(new GradientPaint(0, 0, new Color(0x1B,0x20,0x27), 0, S, new Color(0x0E,0x11,0x15)));
        g.fill(new RoundRectangle2D.Float(0, 0, S, S, 96, 96));
        // ring segments, one per track, with a gap between each
        int cx = S/2, cy = S/2, r = 190, th = 46;
        g.setStroke(new BasicStroke(th, BasicStroke.CAP_BUTT, BasicStroke.JOIN_ROUND));
        for (int i = 0; i < 6; i++) {
            g.setColor(C[i]);
            g.draw(new Arc2D.Float(cx-r, cy-r, r*2, r*2, 90 - i*60 - 4, -52, Arc2D.OPEN));
        }
        // apple silhouette in the middle
        g.setColor(new Color(0xD8,0x3A,0x3A));
        g.fill(new Ellipse2D.Float(cx-78, cy-58, 156, 150));
        g.fill(new Ellipse2D.Float(cx-96, cy-34, 84, 116));
        g.fill(new Ellipse2D.Float(cx+12, cy-34, 84, 116));
        g.setColor(new Color(0x6B,0x43,0x28));  // stem
        g.fillRoundRect(cx-8, cy-96, 16, 46, 8, 8);
        g.setColor(new Color(0x6F,0xC0,0x4A));  // leaf
        g.fill(new Ellipse2D.Float(cx+6, cy-100, 62, 34));
        g.setColor(new Color(255,255,255,64));  // highlight
        g.fill(new Ellipse2D.Float(cx-52, cy-30, 34, 44));
        g.dispose();
        ImageIO.write(img, "PNG", file);
    }

    // ---- banner: wordmark + tagline + bar motif ----
    static void banner(File file) throws Exception {
        int W = 1920, H = 640;
        BufferedImage img = new BufferedImage(W, H, BufferedImage.TYPE_INT_RGB);
        Graphics2D g = g2(img);
        backdrop(g, W, H);
        g.setFont(f(132, Font.BOLD)); g.setColor(INK);
        g.drawString("NUTRIWORK", 120, 250);
        g.setFont(f(44, Font.PLAIN)); g.setColor(GOLD);
        g.drawString("Your diet finally matters.", 126, 320);
        g.setFont(f(32, Font.PLAIN)); g.setColor(DIM);
        g.drawString("A modern nutrition system - as a pure vanilla datapack. No mods.", 126, 378);
        // six bars, each partly filled, echoing the HUD
        double[] pct = { 0.85, 0.7, 0.55, 0.9, 0.45, 0.65 };
        int bx = 126, by = 430, bw = 520, bh = 18;
        for (int i = 0; i < 6; i++) {
            int y = by + i * 28;
            if (i >= 3) { y = by + (i - 3) * 28; bx = 700; } else bx = 126;
            bar(g, bx, y, bw - 260, bh, C[i], pct[i]);
            g.setFont(f(20, Font.BOLD)); g.setColor(C[i]);
            g.drawString(TRACK[i], bx + bw - 250, y + 16);
        }
        ringApple(g, W - 330, H / 2 - 20, 150);   // balance the empty right side
        g.setFont(f(28, Font.BOLD)); g.setColor(DIM);
        g.drawString("1.21 - 1.21.1", W - 340, H - 60);
        g.setFont(f(24, Font.PLAIN));
        g.drawString("by SapperSquad", W - 340, H - 24);
        g.dispose();
        ImageIO.write(img, "PNG", file);
    }

    // ---- gallery 1: the six tracks ----
    static void galleryTracks(File file) throws Exception {
        int W = 1280, H = 720;
        BufferedImage img = new BufferedImage(W, H, BufferedImage.TYPE_INT_RGB);
        Graphics2D g = g2(img); backdrop(g, W, H);
        g.setFont(f(58, Font.BOLD)); g.setColor(INK); center(g, "Six nutrition tracks", W/2, 110);
        g.setFont(f(28, Font.PLAIN)); g.setColor(DIM);
        center(g, "Every food feeds one or more. Cooked and golden foods are worth more.", W/2, 158);
        int y = 232;
        for (int i = 0; i < 6; i++) {
            g.setFont(f(30, Font.BOLD)); g.setColor(C[i]);
            g.drawString(TRACK[i], 150, y + 26);
            bar(g, 330, y + 6, 520, 26, C[i], new double[]{0.9,0.75,0.6,0.85,0.5,0.7}[i]);
            g.setFont(f(24, Font.PLAIN)); g.setColor(DIM);
            g.drawString(FOODS[i], 880, y + 26);
            y += 68;
        }
        g.dispose(); ImageIO.write(img, "PNG", file);
    }

    // ---- gallery 2: the buff ladder ----
    static void galleryBuffs(File file) throws Exception {
        int W = 1280, H = 720;
        BufferedImage img = new BufferedImage(W, H, BufferedImage.TYPE_INT_RGB);
        Graphics2D g = g2(img); backdrop(g, W, H);
        g.setFont(f(58, Font.BOLD)); g.setColor(INK); center(g, "Eat well, get buffed", W/2, 108);
        g.setFont(f(28, Font.PLAIN)); g.setColor(DIM);
        center(g, "Buffs hold while your diet holds, and fade when it slips.", W/2, 156);
        String[][] rows = {
            { "3 groups at 50+",      "Regeneration",        "0x4CAF3E" },
            { "4 groups at 50+",      "+ Resistance",        "0x3B8BE2" },
            { "all 5 groups at 50+",  "+ Haste",             "0xE0B23B" },
            { "4 groups eaten fresh", "Well-Fed: Absorption","0xE8C060" },
            { "water running low",    "Weakness, Slowness",  "0x9AA5B1" },
            { "gorging when full",    "Stuffed: Slowness",   "0x9AA5B1" },
        };
        int y = 226;
        for (String[] r : rows) {
            Color col = Color.decode(r[2]);
            g.setColor(new Color(255,255,255,14));
            g.fill(new RoundRectangle2D.Float(150, y - 34, 980, 62, 14, 14));
            g.setColor(col); g.fill(new RoundRectangle2D.Float(150, y - 34, 8, 62, 8, 8));
            g.setFont(f(30, Font.PLAIN)); g.setColor(DIM); g.drawString(r[0], 190, y + 6);
            g.setFont(f(30, Font.BOLD)); g.setColor(col);
            g.drawString(r[1], 660, y + 6);
            y += 76;
        }
        g.dispose(); ImageIO.write(img, "PNG", file);
    }

    // ---- gallery 3: frame the real in-game screenshot ----
    static void galleryShot(File file, File shot) throws Exception {
        int W = 1280, H = 720;
        BufferedImage img = new BufferedImage(W, H, BufferedImage.TYPE_INT_RGB);
        Graphics2D g = g2(img); backdrop(g, W, H);
        g.setFont(f(52, Font.BOLD)); g.setColor(INK); center(g, "A HUD you can actually read", W/2, 92);
        g.setFont(f(26, Font.PLAIN)); g.setColor(DIM);
        center(g, "/trigger nw.hud cycles: off - bossbars - actionbar. Hide any bar you don't want.", W/2, 136);
        if (shot.exists()) {
            BufferedImage s = ImageIO.read(shot);
            int tw = 1000, th = (int)((double)s.getHeight() / s.getWidth() * tw);
            if (th > 470) { th = 470; tw = (int)((double)s.getWidth() / s.getHeight() * th); }
            int x = (W - tw) / 2, y = 180;
            g.setColor(new Color(0,0,0,120)); g.fillRoundRect(x - 10, y - 10, tw + 20, th + 20, 16, 16);
            g.drawImage(s, x, y, tw, th, null);
            g.setColor(new Color(255,255,255,40));
            g.draw(new RoundRectangle2D.Float(x - 10, y - 10, tw + 20, th + 20, 16, 16));
        } else {
            g.setFont(f(28, Font.PLAIN)); g.setColor(DIM);
            center(g, "(in-game screenshot missing: promo/hud-bossbars.png)", W/2, 400);
        }
        g.dispose(); ImageIO.write(img, "PNG", file);
    }

    // ---- gallery 5: monotony + junk food (the two systems that enforce variety) ----
    // Every number here is READ FROM config/defaults.mcfunction, so this card cannot
    // silently disagree with the pack. Change the config, re-run, the art follows.
    static void galleryVariety(File file) throws Exception {
        int W = 1280, H = 720;
        int med  = cfg("val_med", 25);
        int junk = cfg("val_junk", 15);
        BufferedImage img = new BufferedImage(W, H, BufferedImage.TYPE_INT_RGB);
        Graphics2D g = g2(img); backdrop(g, W, H);
        g.setFont(f(56, Font.BOLD)); g.setColor(INK); center(g, "Variety is the whole point", W/2, 96);
        g.setFont(f(26, Font.PLAIN)); g.setColor(DIM);
        center(g, "Two systems make sure of it - and neither one ever damages you.", W/2, 140);

        // divider
        g.setColor(new Color(255,255,255,26));
        g.fillRect(W/2 - 1, 190, 2, 400);

        // ---- left: monotony ----
        g.setFont(f(30, Font.BOLD)); g.setColor(GOLD);
        g.drawString("Eat the same thing repeatedly", 70, 224);
        g.setFont(f(23, Font.PLAIN)); g.setColor(DIM);
        g.drawString("and it gives you less each time:", 70, 258);
        int[] seq = { med, med, med/2, med/2, med/4 };
        int y = 300;
        for (int i = 0; i < seq.length; i++) {
            double frac = (double) seq[i] / med;
            g.setFont(f(20, Font.PLAIN)); g.setColor(DIM);
            g.drawString("bite " + (i+1), 70, y + 17);
            bar(g, 160, y, 320, 22, C[1], frac);
            g.setFont(f(21, Font.BOLD));
            g.setColor(frac < 1.0 ? new Color(0xE8,0x6A,0x6A) : INK);
            g.drawString("+" + seq[i], 496, y + 18);
            y += 44;
        }
        g.setFont(f(21, Font.PLAIN)); g.setColor(DIM);
        g.drawString("Eat anything else for a minute", 70, y + 34);
        g.drawString("and it recovers.", 70, y + 62);

        // ---- right: junk food ----
        int rx = W/2 + 60;
        g.setFont(f(30, Font.BOLD)); g.setColor(GOLD);
        g.drawString("Some things were never food", rx, 224);
        g.setFont(f(23, Font.PLAIN)); g.setColor(DIM);
        g.drawString("and they cost you nutrition:", rx, 258);
        String[][] junks = {
            { "Rotten Flesh",     "Meat" },
            { "Spider Eye",       "Meat" },
            { "Pufferfish",       "Meat" },
            { "Poisonous Potato", "Veg"  },
        };
        int jy = 300;
        for (String[] jk : junks) {
            g.setColor(new Color(255,255,255,14));
            g.fill(new RoundRectangle2D.Float(rx - 14, jy - 4, 520, 36, 10, 10));
            g.setFont(f(23, Font.PLAIN)); g.setColor(INK);
            g.drawString(jk[0], rx + 6, jy + 21);
            g.setFont(f(22, Font.BOLD)); g.setColor(new Color(0xE8,0x5A,0x5A));
            g.drawString("-" + junk + "  " + jk[1], rx + 330, jy + 21);
            jy += 44;
        }
        g.setFont(f(21, Font.PLAIN)); g.setColor(DIM);
        g.drawString("Still a fair choice in an emergency.", rx, jy + 34);
        g.drawString("Just never a free one.", rx, jy + 62);

        g.setFont(f(22, Font.PLAIN)); g.setColor(DIM);
        center(g, "Every one of Minecraft's foods is accounted for.", W/2, H - 46);
        g.dispose(); ImageIO.write(img, "PNG", file);
    }

    // ---- gallery 4: compat + tuning ----
    static void galleryCompat(File file) throws Exception {
        int W = 1280, H = 720;
        BufferedImage img = new BufferedImage(W, H, BufferedImage.TYPE_INT_RGB);
        Graphics2D g = g2(img); backdrop(g, W, H);
        g.setFont(f(56, Font.BOLD)); g.setColor(INK); center(g, "Vanilla first. Modded ready.", W/2, 104);
        g.setFont(f(27, Font.PLAIN)); g.setColor(DIM);
        center(g, "Reads the standard c:foods/* tags, so modded foods sort themselves.", W/2, 150);
        center(g, "On a vanilla world the compat layer simply does nothing.", W/2, 188);
        String[] items = {
            "Farmer's Delight", "Croptopia", "Pam's HarvestCraft",
            "Ocean's Delight", "End's Delight", "any c:foods mod",
        };
        int y = 258;
        for (int i = 0; i < items.length; i++) {
            int x = (i % 2 == 0) ? 190 : 690;
            if (i % 2 == 0 && i > 0) y += 74;
            g.setColor(new Color(255,255,255,14));
            g.fill(new RoundRectangle2D.Float(x - 30, y - 30, 420, 56, 12, 12));
            g.setColor(C[i % 6]);
            g.fillOval(x - 12, y - 16, 18, 18);
            g.setFont(f(28, Font.PLAIN)); g.setColor(INK);
            g.drawString(items[i], x + 24, y + 0);
        }
        y += 118;
        g.setFont(f(30, Font.BOLD)); g.setColor(GOLD);
        center(g, "Server-tunable: every value in one config file.", W/2, y);
        g.setFont(f(25, Font.PLAIN)); g.setColor(DIM);
        center(g, "Retag any food by editing a single item tag. Clean uninstall.", W/2, y + 44);
        g.dispose(); ImageIO.write(img, "PNG", file);
    }
}
