public class RayCastor {
  FakeWorld world;
  Camera camera;
  
  public RayCastor(Camera c) {
    world = new FakeWorld(new int[][] {
      {0, 0, 1, 1},
      {0, 0, 1, 1},
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