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

  
}

void draw() {
  background(0,0,0);
}