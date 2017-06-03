public class RayCastor {
  FakeWorld world;
  Camera camera;
  
  public RayCastor(Camera c) {
    world = new FakeWorld(new int[][] {
      {0, 0, 0, 0},
      {0, 0, 0, 0},
      {0, 0, 0, 0},
      {0, 0, 0, 0}
    });
    camera = c;
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