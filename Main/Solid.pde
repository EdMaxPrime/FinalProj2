public class Solid{
  int xpos;
  int ypos;
  int sideLength;
  Texture texture;
  double opacity; //transparent or not 0-invisible 1-there

  public Solid(int x, int y, int side, Texture text){
    if (x <0 || y <0){
      throw new IllegalArgumentException("you cannot use negative coordinates");
    }
    else{
      xpos = x;
      ypos = y;
      sideLength = side;
      texture = text;
    }
  }
  
  public PImage getStripe(float where, double distance){
    return texture.getStripe(where, distance);
  }
  
  public int getSide(){
    return sideLength;
  }

  public int getX(){
    return xpos;
  }

  public int getY(){
    return ypos;
  }
  
  
  
}