public class Player {
  Camera cam;
  float walkingSpeed;
  float turningSpeed;

  public Player(Renderer r) {
    cam = r.rc.camera;
    walkingSpeed = 0.1;
    turningSpeed = (PI / 90);
  }

  public void forward() {
    cam.xpos += cam.direction.x * walkingSpeed;
    cam.ypos += cam.direction.y * walkingSpeed;
    //println(cam.xpos, cam.ypos);
  }

  public void backward() {
    cam.xpos -= cam.direction.x * walkingSpeed;
    cam.ypos -= cam.direction.y * walkingSpeed;
    //println(cam.xpos, cam.ypos);
  }

  /** -1 to turn left, +1 to turn right */
  public void turn(int dir) {
    if (dir == -1) cam.rotate(- turningSpeed);
    if (dir ==  1) cam.rotate(+ turningSpeed);
  }
  
  /** Moves the player to the specified coordinates */
  public void moveto(float x, float y) {
    cam.xpos = x;
    cam.ypos = y;
  }
  
  /** Forces the player to face a certain direction. Angle provided should be in radians */
  public void face(float angle) {
    float currentAngle = cam.direction.heading();
    float deltaAngle = angle - currentAngle;
    cam.rotate(deltaAngle);
  }

  //public boolean closeEnough(float x, float x1) {
  //  if (abs(1 - ((float)x) / x1) < 0.1) {
  //    return true;
  //  }
  //  return false;
  //}

  //public void doordetect() {
  //  for (int i =0; i < solid.size(); i++) {
  //    int xpos = solid.get(i).getX();
  //    int ypos = solid.get(i).getY();
  //    if ( (closeEnough(cam.xpos, xpos)) && (closeEnough(cam.ypos, ypos))) {
        
  //    }
  //  }
  //}
  
  //void grow() {
  //  if(initDistX < initDistY) {
  //    initDistX += deltaDistX;
  //    //mapX += stepX
  //    mapX += stepX;
  //    //side = east/west
  //    sideHit = true;
  //  } else {
  //    initDistY += deltaDistY;
  //    //mapY += setpY
  //    mapY += stepY;
  //    //side = north/south
  //    sideHit = false;
  //  }
  //  //now safe to check if a wall was hit
  //}
  
  //public void doordetect() {
  //  cam.setResolution(1);
  //  if (xpos < ypos){
  //    xpos += deltaDisX;
  //    map.xcoor += stepX;
  //  }
    
  
  
  
}