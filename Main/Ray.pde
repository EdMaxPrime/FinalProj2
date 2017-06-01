public class Ray {
  double startX, startY;
  double originalMagnitude;
  PVector vector;
  
  Ray(float x1, float y1, float x2, float y2) {
    startX = x1;
    startY = y2;
    vector = new PVector(x2 - x1, y2 - y1);
    originalMagnitude = vector.mag();
  }
  

  void grow() {
        
  }
  
  /** The length of this ray from its vertex */
  double magnitude() {
    return vector.mag();
  }
  
  /** The length of this ray if it began at the camera plane */
  double planeMagnitude() {
    return vector.mag() - originalMagnitude;
  }
  
  String toString() {
    return "<" + vector.x + "," + vector.y + ">";
  }
}