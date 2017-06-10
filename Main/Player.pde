public class Player{
  int xpos;
  int ypos;
  Camera cam;
  float speed;
  
  public Player(Renderer r) {
    cam = r.rc.camera;
    speed = 0.4;
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
  
  public void turn(int dir) {
    if(dir == -1) cam.rotate(- PI/90);
    if(dir ==  1) cam.rotate(+ PI/90);
  }
  
}