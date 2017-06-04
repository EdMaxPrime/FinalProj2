import java.util.ArrayList;

public class World{
   private Solid[][] world;
   private ArrayList<Solid> solids;
   
   //possible problems is cols and rols swich w x and y 
   public World(ArrayList<Solid> solidList, int dimensionX, int dimensionY){
     solids = solidList;
     world = new Solid[dimensionY][dimensionX];
     for (int i =0; i < solids.size(); i++){
       addSolid(solids.get(i));
     }
   }
   
   public Solid whatsThere(int x, int y){
    if(y < 0 || y >= world.length){
      return null;
    }
    if(x < 0 || x >= world[y].length){
      return null;
    }
    return world[y][x];
   }
   
   public void addSolid(Solid current){
     if (current.getX() < world[0].length && current.getY() < world.length){
       world[current.getY()][current.getX()] = current;
     }
     else{
       throw new IllegalArgumentException("coordinates must be within the dimensions of the world");
     }
   }
   
   public String toString(){
     String ans = "[ \n";
     String identity = "";
     for (int row = 0; row < world.length; row++){
       ans += "[";
       for (int col = 0; col < world[0].length; col++){
         if (world[row][col] instanceof Solid){
           identity = "solid";
         }
         else if (world[row][col]  == null){
           identity = "null";
         }
         ans += " " + identity + ",";
       }
       ans += "] \n";
     }
     return ans + "]";
   }
   //public Texture getTexture(int x, int y, double distance) {
   // int which = whatsThere(x, y);
   // if(which == 0) return new OneColor(color(0), distance);
   // if(which == 1) return new OneColor(color(255,0,0), distance);
   // if(which == 2) return new OneColor(color(0,255,0), distance);
   // if(which == 3) return new OneColor(color(0,100,0), distance);
   // if(which == 4) return new OneColor(color(0,0,255), distance);
   // return new OneColor(color(200), distance);
  //}//
     
}