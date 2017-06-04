import java.util.ArrayList;

public class RayCastor {
  FakeWorld world;
  Camera camera;
  Texture[] stripes;
  
  public RayCastor(Camera c) {
    world = new FakeWorld(new int[][] {
      {0, 0, 0, 1},
      {0, 0, 2, 1},
      {5, 4, 3, 1},
      {1, 1, 1, 1}
    });
    camera = c;
    stripes = new Texture[camera.resolution];
  }
  
  public void beginCasting() {
    camera.reset();
    stripes = new Texture[camera.resolution];
    int rayNumber = 0;
    while(camera.hasNextRay()) {
      Ray r = camera.nextRay();
      for(int i = 0; i < 10; i ++) {
        if(world.whatsThere(r.getMapX(), r.getMapY()) != 0) {
          //println("Detected @(" + r.getMapX() + ", " + r.getMapY() + ") " + r.perpWallDist());
          PVector end = r.vector.copy();
          end.setMag((float)r.perpWallDist()); //looks like fish-eye
          stroke(128, 255, 128);
          line(240, 240, 240 + end.x*40, 240 - end.y*40);
          break;
        } else {
          r.grow();
        }
      }
      stripes[rayNumber] = world.getTexture(r.getMapX(), r.getMapY(), r.perpWallDist());
      rayNumber++;
    }
  }
  
  public Texture[] getBuffer() {
    return stripes;
  }
}

public class FakeWorld {
  private int[][] stuff;
  
  FakeWorld(int[][] terrain) {
    stuff = terrain;
  }
  
  public int whatsThere(int x, int y) {
    if(y < 0 || y >= stuff.length) return 0;
    if(x < 0 || x >= stuff[y].length) return 0;
    return stuff[y][x];
  }
  
  public Texture getTexture(int x, int y, double distance) {
    int which = whatsThere(x, y);
    if(which == 0) return new OneColor(color(0), distance);
    if(which == 1) return new OneColor(color(255,0,0), distance);
    if(which == 2) return new OneColor(color(0,255,0), distance);
    if(which == 3) return new OneColor(color(0,100,0), distance);
    if(which == 4) return new OneColor(color(0,0,255), distance);
    return new OneColor(color(200), distance);
  }
}