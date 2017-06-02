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
  
  background(0);
  stroke(255, 0, 0);
  for(int line = 0; line < max(width, height)/15.0; line++) {
    line(line*40, 0, line*40, height); //vertical
    line(0, line*40, width, line*40); //horizontal
  }
  Camera cam = new Camera(0, 0, 0, 10); //@origin facing right, 10 rays
  Ray r2 = cam.nextRay();
  println("Ray: " + r);
  int gray = 255;
  fill(gray);
  ellipseMode(CENTER);
  ellipse(240, 240, 5, 5);
  gray -= 20;
  fill(gray);
  ellipse(240+r2.getPosX()*40, 240-r2.getPosY()*40, 5, 5);
  for(int i = 0; i < 5; i++) {
    r2.grow();
    println(i+") "+r2.where());
    gray -= 20;
    fill(gray);
    ellipse(240+r2.getMapX()*40, 240-r2.getMapY()*40, 5, 5);
  }
}

void draw() {
  //background(0,0,0);
}