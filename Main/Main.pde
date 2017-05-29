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
}

void draw() {
  background(255);
}