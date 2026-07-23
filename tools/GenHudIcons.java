// Generates the six Nutriwork HUD font glyphs (one per nutrition track) as 16x16 PNGs.
// Clean colored discs matching each bar's colour — pixel-exact, no hand art.
// Usage:  javac GenHudIcons.java && java -cp . GenHudIcons <outputDir>
// (Java only; this machine has no Python/Node. Same philosophy as ReelRivals' GenCards.java.)
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import javax.imageio.ImageIO;

public class GenHudIcons {
    public static void main(String[] args) throws Exception {
        File out = new File(args.length > 0 ? args[0] : ".");
        out.mkdirs();
        String[] names = { "fruit", "veg", "grain", "meat", "sugar", "water" };
        Color[] cols = {
            new Color(0xE2, 0x3B, 0x3B), // fruit  – red
            new Color(0x4C, 0xAF, 0x3E), // veg    – green
            new Color(0xE0, 0xB2, 0x3B), // grain  – gold
            new Color(0x9B, 0x4D, 0xCA), // meat   – purple
            new Color(0xE8, 0x6A, 0xA8), // sugar  – pink
            new Color(0x3B, 0x8B, 0xE2), // water  – blue
        };
        int S = 16;
        for (int i = 0; i < names.length; i++) {
            BufferedImage img = new BufferedImage(S, S, BufferedImage.TYPE_INT_ARGB);
            Graphics2D g = img.createGraphics();
            g.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
            Color c = cols[i];
            g.setColor(c.darker());          // 1px ring
            g.fillOval(1, 1, S - 2, S - 2);
            g.setColor(c);                   // body
            g.fillOval(2, 2, S - 4, S - 4);
            g.setColor(new Color(255, 255, 255, 130)); // highlight
            g.fillOval(4, 4, 4, 4);
            g.dispose();
            ImageIO.write(img, "PNG", new File(out, names[i] + ".png"));
        }
        System.out.println("Generated " + names.length + " HUD glyph PNGs in " + out.getAbsolutePath());
    }
}
