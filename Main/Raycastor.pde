public class RayCastor {
  FakeWorld world;
  Camera camera;
  
  public RayCastor(Camera c) {
    world = new FakeWorld(new int[][] {
      {0, 1, 0, 0},
      {0, 1, 0, 1},
      {1, 1, 1, 1},
      {1, 1, 1, 1}
    });
    camera = c;
  }
  
  public void beginCasting() {
    camera.reset();
    while(camera.hasNextRay()) {
      Ray r = camera.nextRay();
      for(int i = 0; i < 10; i ++) {
        if(world.whatsThere(r.getMapX(), r.getMapY()) != 0) {
          println("Detected @(" + r.getMapX() + ", " + r.getMapY() + ") " + r.perpWallDist());
          PVector end = r.vector.copy();
          end.setMag((float)r.perpWallDist()); //looks like fish-eye
          stroke(128, 255, 128);
          line(240, 240, 240 + end.x*40, 240 - end.y*40);
          break;
        } else {
          r.grow();
        }
      }
    }
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
}