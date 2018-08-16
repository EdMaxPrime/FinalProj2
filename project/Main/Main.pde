Camera cam;
Renderer render;
Player p;
String state;

void setup() {
  size(500, 500);
  state = "world";
  /*Ray r = new Ray(0, 0, -.5, 1);
  println(r);
  r.grow();
  println(r);
  r.grow();
  println(r);
  r.grow();
  println(r);
  int x0 = 3, y0 = 3, x1 = 8, y1 = 16;
  cam = new Camera(0, 0, 0, 10); //@origin facing right, 10 rays
  Ray r2 = cam.nextRay();
  drawGrid(40);
  drawRay(40, r2);
  println(r2.perpWallDist());*/
  RayCastor rc = new RayCastor(new Camera(0, 0, radians(45), 100));
  render = new Renderer(rc);
  p = new Player(render);
  //SaveFile sf = new SaveFile(join(loadStrings("data/world2.txt"), "\n"));
  //println("-------");
  SaveFile w2 = new SaveFile(loadBytes("data/world3.dat"));
  render = w2.load();
  p = new Player(render);
}

void draw() {
  if(state.startsWith("world")) {
    render.update();
    render.render();
  }
  else if(state.equals("map")) {
    background(0);
    int side = width / render.getRenderDistance();
    render.drawMap(side);
    fill(255, 0, 0);
    ellipseMode(CENTER);
    ellipse(p.getX() * side, p.getY() * side, side, side);
    stroke(255, 255, 255);
    float a = p.getAngle();
    line(p.getX() * side, p.getY() * side, p.getX() * side + cos(a) * side, p.getY() * side + sin(a) * side);
    noStroke();
  }
  fill(0);
  rect(0, height-20, width, height);
  fill(255);
  textAlign(CENTER);
  text("render-distance: " + render.getRenderDistance() + "    resolution: " + render.getResolution() + "    <" + state + ">", width/2, height-2);
}

void drawGrid(float scale) {
  background(0);
  stroke(255, 0, 0);
  for(int line = 0; line < max(width, height)/scale; line++) {
    line(line*scale, 0, line*scale, height); //vertical
    line(0, line*scale, width, line*scale); //horizontal
  }
}

void drawRay(int scale, Ray r) {
  println("Ray: " + r);
  fill(255);
  ellipseMode(CENTER);
  ellipse(240, 240, 5, 5);
  println("Pos: "+r.getPosX() + ", " + r.getPosY() + ", " + r.startY);
  ellipse(240+r.getPosX()*scale, 240-r.getPosY()*scale, 5, 5);
  text("Dir", 250+r.getPosX()*scale, 250-r.getPosY()*scale);
  for(int i = 0; i < 5; i++) {
    r.grow();
    println(i+") "+r.where());
    ellipse(240+r.getMapX()*scale + scale/2, 240-r.getMapY()*scale - scale/2, 5, 5);
    text(i+"", 250+r.getMapX()*scale + scale/2, 250-r.getMapY()*scale - scale/2);
  }
  stroke(150, 150, 255);
  float x = (float)r.startX, y = (float)r.startY;
  for(int step = 0; step < max(width, height)/(2*scale); step++) {
    line(240+x*scale, 240-y*scale, 240+(x+r.vector.x)*scale, 240-(y+r.vector.y)*scale);
    x += r.vector.x;
    y += r.vector.y;
  }
}

void keyReleased() {
  /*if(cam.hasNextRay()) {
    drawGrid(40);
    drawRay(40, cam.nextRay());
  }*/
  if (keyCode == UP) {
      println("up");
  } else if (keyCode == DOWN) {
      println("down");
  } else if (keyCode == RIGHT) {
      println("right");
  } else if (keyCode == LEFT) {
     println("left");
  } else if(key == '.') {
    render.adjustRenderDistance(1);
  } else if(key == ',') {
    render.adjustRenderDistance(-1);
  }
  else if (key == ' ') {
    Solid entrance = render.rc.lookingAt(); //render.rc.world.whatsThere(2, 1);
    if(entrance != null && entrance instanceof Door) ((Door)entrance).toggle();
  }
  else if(key >= '0' && key <= '9') {
    SaveFile sf = new SaveFile(loadBytes("data/world" + key + ".dat"));
    render = sf.load();
    p = new Player(render);
  }
  else if(key == 'm') {
    if(state.equals("world")) state = "map";
    else state = "world";
  }
}

void keyPressed() {
  if(keyCode == UP) {
    p.forward();
  } else if(keyCode == DOWN) {
    p.backward();
  } else if(keyCode == LEFT) {
    p.turn(-1);
  } else if(keyCode == RIGHT) {
    p.turn(1);
  }
}