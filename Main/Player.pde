public class Player{
  int xpos;
  int ypos;
  Camera cam;
  ArrayList<Solid> solid;
  float speed;
  
  public Player(Renderer r) {
    cam = r.rc.camera;
    solid = r.rc.solids;
    speed = 0.1;
  }
  
  public void forward(){
    cam.xpos += cam.direction.x * speed;
    cam.ypos += cam.direction.y * speed;
    println(cam.xpos, cam.ypos);
  }
  
  public void backward() {
    cam.xpos -= cam.direction.x * speed;
    cam.ypos -= cam.direction.y * speed;
    println(cam.xpos, cam.ypos);
  }
  
  /** -1 to turn left, +1 to turn right */
  public void turn(int dir) {
    if(dir == -1) cam.rotate(- PI/90);
    if(dir ==  1) cam.rotate(+ PI/90);
  }
  
  public boolean closeEnough(float x, float x1){
    if (x - x1 < .5){
      return true;
    }
  }
  
  public void doordetect(){
    for (int i =0; i < solid.size; i++){
      int xpos = solid.get(i).getX();
      int ypos = solid.get(i).getY();
      if ( (closeEnough(cam.xpos, xpos)) && (closeEnough(cam.ypos, ypos))){
        if (solid.get(i)instanceof Door){
        }
        else{
          
        }
  }
}