public class Renderer{
  RayCastor rc;
  color ground, sky;
  
  public Renderer(RayCastor r){
    rc = r;
    ground = #764D0D;
    sky = #82CAFF;
  }
  
  public Renderer(RayCastor r, color _sky, color _ground) {
    rc = r;
    sky = _sky;
    ground = _ground;
  }
  
  public void render(){
    background(ground);
    fill(sky);
    rectMode(CORNERS);
    rect(0, 0, width, height/2);
    PImage[] buffer = rc.getBuffer();
    imageMode(CENTER);
    for(int i = 0; i < buffer.length; i++) {
      if(buffer[i] == null) continue;
      for(int j = 0; j < height/buffer.length; j++) {
        image(buffer[i], i*(height/buffer.length)+j, height/2);
      }
    }
  }
  
  public void setSky(color c) {sky = c;}
  public color getSky() {return sky;}
  public void setGround(color c) {ground = c;}
  public color getGround() {return ground;}
  
  public void update(){
    rc.beginCasting();
  }
  
  public void setResolution(int resolution){
    rc.camera.resolution = resolution;
  }
  
  public int getResolution(){
    return rc.camera.resolution;
  }
  
  public int getRenderDistance() { return rc.getRenderDistance(); }
  
  public void adjustRenderDistance(int change) {
    rc.setRenderDistance(rc.getRenderDistance() + change);
  }
  
  public void adjustResolution(int change) {
    rc.camera.setResolution(rc.camera.getResolution() + change);
  }
  
  public void drawMap(int side) {
    int w = rc.world.getWidth(), h = rc.world.getHeight();
    for(int x = 0; x < w; x++) {
      for(int y = 0; y < h; y++) {
        Solid s = rc.world.whatsThere(x, y);
        if(s != null) {
          s.texture.preview(x * side, y * side, side);
        }
      }
    }
  }
  
  
}