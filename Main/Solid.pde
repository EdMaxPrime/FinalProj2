public class Solid{
  int xpos;
  int ypos;
  int sideLength;
  double opacity; //transparent or not 0-invisible 1-there

  public Solid(int x, int y, int side){
    if (x <0 || y <0){
      throw new IllegalArgumentException("you cannot use negative coordinates");
    }
    else{
      xpos = x;
      ypos = y;
      sideLength = side;
    }
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