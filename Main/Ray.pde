public class Ray {
  float startX, startY;
  double originalMagnitude;
  PVector vector;
  
  Ray(float x1, float y1, float x2, float y2) {
    startX = x1;
    startY = y2;
    vector = new PVector(x2 - x1, y2 - y1);
    originalMagnitude = vector.mag();
  }
  
  String toString() {
    return "<" + vector.x + "," + vector.y + ">";
  }
}