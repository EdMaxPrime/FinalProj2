void setup() {
  size(500, 500);
  Ray r = new Ray(0, 0, -.5, 1);
  println(r);
  r.grow();
  println(r);
  r.grow();
  println(r);
  r.grow();
  println(r);
  int x0 = 3, y0 = 3, x1 = 8, y1 = 16;

  Camera cam = new Camera(0, 0, 0, 10); //@origin facing left, 10 rays
  while(cam.hasNextRay()) {
    println("!!"+cam.nextRay());
  }
}

void draw() {
  background(0,0,0);
}