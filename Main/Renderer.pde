public class Renderer{
  RayCastor rc;
  
  public Renderer(RayCastor r){
    rc = r;
  }
  
  public void render(){
    background(0,0,0);
    PImage[] buffer = rc.getBuffer();
    imageMode(CENTER);
    for(int i = 0; i < buffer.length; i++) {
      for(int j = 0; j < height/buffer.length; j++) {
        image(buffer[i], i*(height/buffer.length)+j, height/2);
      }
    }
  }
  
  public void update(){
    rc.beginCasting();
  }
  
  public void setResolution(int resolution){
    rc.camera.resolution = resolution;
  }
  
  public int getResolution(){
    return rc.camera.resolution;
  }
  
  
}