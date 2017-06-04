import java.util.ArrayList;

public class RayCastor {
  World world;
  Camera camera;
  PImage[] stripes;
  ArrayList<Solid> solids = new ArrayList<Solid>();
  
  public RayCastor(Camera c) {
    solids.add(new Solid(1, 1, 3, new OneColor(color(255))));
    world = new World(solids, 5, 5);
    camera = c;
    stripes = new PImage[camera.resolution];
  }
  
  public void beginCasting() {
    camera.reset();
    stripes = new PImage[camera.resolution];
    int rayNumber = 0;
    Solid s = null;
    while(camera.hasNextRay()) {
      Ray r = camera.nextRay();
      for(int i = 0; i < 10; i ++) {
        //if(world.whatsThere(r.getMapX(), r.getMapY()) != 0) {
        //  //println("Detected @(" + r.getMapX() + ", " + r.getMapY() + ") " + r.perpWallDist());
        //  PVector end = r.vector.copy();
        //  end.setMag((float)r.perpWallDist()); //looks like fish-eye
        //  stroke(128, 255, 128);
        //  line(240, 240, 240 + end.x*40, 240 - end.y*40);
        //  break;
        //} 
        s = world.whatsThere(r.getMapX(), r.getMapY());
        
        if (s == null){
          r.grow();
        }
        else{
          break;
        }
      }
      if (s == null) s = new Solid(1,1,2,new OneColor(color(0)));
      stripes[rayNumber] = s.getStripe(-1, r.perpWallDist());
      //if(r.sideHit) stripes[rayNumber].darker(); //if it hit an east-west side, make it shaded
      
      rayNumber++;
    }
  }
  
  public PImage[] getBuffer() {
    return stripes;
  }
}

//public class FakeWorld {
//  private int[][] stuff;
  
//  FakeWorld(int[][] terrain) {
//    stuff = terrain;
//  }
  
//  public int whatsThere(int x, int y) {
//    if(y < 0 || y >= stuff.length) return 0;
//    if(x < 0 || x >= stuff[y].length) return 0;
//    return stuff[y][x];
//  }
  
//  public Texture getTexture(int x, int y, double distance) {
//    int which = whatsThere(x, y);
//    if(which == 0) return new OneColor(color(0), distance);
//    if(which == 1) return new OneColor(color(255,0,0), distance);
//    if(which == 2) return new OneColor(color(0,255,0), distance);
//    if(which == 3) return new OneColor(color(0,100,0), distance);
//    if(which == 4) return new OneColor(color(0,0,255), distance);
//    return new OneColor(color(200), distance);
//  }