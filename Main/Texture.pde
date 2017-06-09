abstract class Texture {
  int txtWidth, txtHeight;
  
  /** Returns a vertical stripe */
  abstract PImage getStripe(float where, double distance);
  /** Make the texture darker to simulate shading */
  abstract Texture darker();
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

class ImageTexture extends Texture {
  PImage img;
  
  public ImageTexture(PImage _img) {
    img = _img;
    txtWidth = img.width;
    txtHeight = img.height;
  }
  
  /** Returns a vertical stripe */
  PImage getStripe(float where, double distance) {
    distance = (distance <= 0)? .001 : distance; //cant be negative or zero
    if(where > 1.0) where -= floor(where);
    PImage stripe = createImage(1, (int)(height / distance), RGB);
    int xCoord = (int)(img.width * where);
    stripe.loadPixels();
    for(int i = 0; i < stripe.pixels.length; i++) {
      //int yCoord = i * 256 - height * 128 + stripe.pixels.length * 128;
      //stripe.pixels[i] = img.get(xCoord, ((yCoord * txtHeight) / stripe.pixels.length) / 256);
      stripe.pixels[i] = scaledTexel(xCoord, i, ((float)txtHeight) / stripe.height);
    }
    stripe.updatePixels();
    return stripe;
  }
  /** Resize image by scaling coordinates to get colors from the original image */
  private color scaledTexel(int xCoord, int scaledYCoord, float howMany) {
    if(howMany < 1) {
      return img.get(xCoord, round(scaledYCoord * howMany));
    } else {
      //somehow average colors together
    }
    return color(255);
  }
  /** Make the texture darker to simulate shading */
  Texture darker() {
    PImage darkened = img.copy();
    colorMode(HSB, 360, 100, 100);
    darkened.loadPixels();
    for(int i = 0; i < darkened.pixels.length; i++) {
      darkened.pixels[i] = color(hue(darkened.pixels[i]), saturation(darkened.pixels[i]), brightness(darkened.pixels[i])/2);
    }
    darkened.updatePixels();
    colorMode(RGB);
    return new ImageTexture(darkened);
  }
  /** Returns a copy */
  Texture copy() {
    return this;
  }
}