abstract class Texture {
  int txtWidth, txtHeight;
  double distance;
  
  /** Returns a vertical stripe */
  abstract PImage getStripe(float where);
  /** How far away this texture is from the camera */
  public float distance() {return (float)distance;}
}

public class OneColor extends Texture {
  color mycolor;
  public OneColor(color c, double d) {
    mycolor = c;
    txtWidth = 16;
    txtHeight = 16;
    distance = (d <= 0)? d : .001; //cant be negative or zero
  }
  
  public PImage getStripe(float where) {
    PImage img = createImage(1, (int)(height / distance), RGB);
    img.loadPixels();
    for(int i = 0; i < img.pixels.length; i++) {
      img.pixels[i] = mycolor;
    }
    img.updatePixels();
    return img;
  }
}