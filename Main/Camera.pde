public class Camera{
  float xpos; //camera position in world
  float ypos; //camera position in world
  PVector direction; //direction of the camera
  float planeLength; //length of the camera plane, about 0.66
  int resolution; //at most = WIDTH, controls how many rays we need to generate
  int current; //which ray we are doing right now
  
  public Camera(float x, float y, PVector dir, int res) {
    xpos = x;
    ypos = y;
    direction = dir;
    resolution = res;
    current = 0;
    planeLength = 0.66;
  }
  

  public void rotate(float angle){
    direction.rotate(angle);
  }

  public void zoomIn(){
    resolution *= 0.9;
  }
  
  public void zoomOut() {
    resolution /= 0.9;
  }

  public void setResolution(int res){
    resolution = res;
  }

  public Ray nextRay(){
    float cameraPlaneX = 2 * current / (float)resolution - 1;
    PVector cameraPlane = direction.copy().rotate(HALF_PI);
    cameraPlane.setMag(planeLength);
    Ray ray = new Ray(xpos, ypos, direction.x + cameraPlane.x * cameraPlaneX, direction.y + cameraPlane.y * cameraPlaneX);
    current++;
    return ray;
  }

  public void reset(){
    current = 0;
    direction.normalize();
  }

  public boolean hasNextRay(){
    return current < resolution;
  }

}