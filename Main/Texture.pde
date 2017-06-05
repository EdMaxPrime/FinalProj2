abstract class Texture {
  int txtWidth, txtHeight;
  
  /** Returns a vertical stripe */
  abstract PImage getStripe(float where, double distance);
  /** Make the texture darker to simulate shading */
  abstract Texture darker();
  /** How far away this texture is from the camera */
  /** Returns a copy */
  abstract Texture copy();
}

public class OneColor extends Texture {
  color mycolor;
  public OneColor(color c) {
    mycolor = c;
    txtWidth = 16;
    txtHeight = 16;
  }
  
  public PImage getStripe(float where, double distance) {
    distance = (distance <= 0)? .001 : distance; //cant be negative or zero
    PImage img = createImage(1, (int)(height / distance), RGB);
    img.loadPixels();
    for(int i = 0; i < img.pixels.length; i++) {
      img.pixels[i] = mycolor;
    }
    img.updatePixels();
    return img;
  }
  
  public OneColor darker() {
    colorMode(HSB, 360, 100, 100);
    mycolor = color(hue(mycolor), saturation(mycolor), brightness(mycolor)/2);
    colorMode(RGB, 255, 255, 255);
    return this;
  }
  
  public OneColor copy() {
    OneColor t = new OneColor(mycolor);
    return t;
  }
}