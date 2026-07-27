// Generates the Nutrition Guide book item texture (16x16 PNG) for the resource pack.
// A green-covered book with a spine, cream page edge, and a small apple emblem.
// Placeholder-quality pixel art (refine in Blockbench if desired) - pixel-exact, no guesswork.
// Usage:  javac GenBookTexture.java && java -cp . GenBookTexture <textures/item dir>
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import javax.imageio.ImageIO;

public class GenBookTexture {
    public static void main(String[] args) throws Exception {
        File out = new File(args.length > 0 ? args[0] : ".");
        out.mkdirs();
        int S = 16;
        BufferedImage img = new BufferedImage(S, S, BufferedImage.TYPE_INT_ARGB);
        Graphics2D g = img.createGraphics();
        Color cover     = new Color(0x2E, 0x7D, 0x32);
        Color coverDark = new Color(0x1B, 0x5E, 0x20);
        Color coverLite = new Color(0x43, 0xA0, 0x47);
        Color page      = new Color(0xF3, 0xE9, 0xC6);
        Color pageEdge  = new Color(0xCB, 0xB9, 0x8A);
        Color appleRed  = new Color(0xD3, 0x2F, 0x2F);
        Color leaf      = new Color(0x8B, 0xC3, 0x4A);

        g.setColor(cover);      g.fillRect(3, 2, 10, 12);   // cover body
        g.setColor(coverDark);  g.fillRect(3, 2, 2, 12);    // spine (left)
        g.setColor(coverLite);  g.fillRect(5, 2, 8, 1);     // top highlight
        g.setColor(page);       g.fillRect(12, 3, 2, 10);   // page block (right)
        g.setColor(pageEdge);   g.fillRect(13, 3, 1, 10);   // page edge line
        // apple emblem on the cover
        g.setColor(appleRed);   g.fillRect(7, 8, 3, 3); g.fillRect(6, 9, 1, 1); g.fillRect(10, 9, 1, 1);
        g.setColor(coverDark);  g.fillRect(8, 7, 1, 1);     // stem
        g.setColor(leaf);       g.fillRect(9, 7, 1, 1);     // leaf
        g.dispose();
        ImageIO.write(img, "PNG", new File(out, "guide.png"));
        System.out.println("wrote guide.png to " + out.getAbsolutePath());
    }
}
