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
  
  private float nextXScale() {
    if(vector.x < 0) {
      return (float)(Math.ceil(vector.x + startX - 1) / (vector.x + startX));
    } else {
      return (float)(Math.floor(vector.x + startX + 1) / (vector.x + startX));
    }
  }
  
  private float nextYScale() {
    if(vector.y < 0) {
      return (float)(Math.ceil(vector.y + startY - 1) / (vector.y + startY));
    } else {
      return (float)(Math.floor(vector.y + startY + 1) / (vector.y + startY));
    }
  }
  
  /** Should make this ray extend to either the next intger X
      or the next integer Y, depending on which is closer.
      Currently broken. */
  void grow() {
    println(nextXScale() + " " + nextYScale());
    if(abs(nextXScale()) > abs(nextYScale())) {
      vector.mult(nextXScale());
    } else {
      vector.mult(nextYScale());
    }
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