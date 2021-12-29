class Body {
  float x;
  float y;
  float vx;
  float vy;
  float fx;
  float fy;
  color col;
  float mass;
  
  Body (float x, float y, float mass, color col) {
    this.x = x;
    this.y = y;
    this.mass = mass;
    this.col = col;
  }
  
  void move () {
    vx += dt * fx / mass;
    vy += dt * fy / mass;
    x += dt * vx;
    y += dt * vy;
  }
  
  float distance (Body other) {
    float xDiff = other.x - x;
    float yDiff = other.y - y;
    return sqrt(xDiff * xDiff + yDiff * yDiff);
  }
  
  void addForce (Body b) {
    float d = distance(b);
    float F = (-G * b.mass * mass) / (d * d + soft * soft); 
    fx += F * (x - b.x) / d;
    fy += F * (y - b.y) / d;
  }
  
  Body combine(Body other) {
    float m = other.mass + mass;
    float newX = (x*mass + other.x*other.mass) / m;
    float newY = (y*mass + other.y*other.mass) / m;
    return new Body(newX, newY, m, col);
  }
  
  boolean inQuad (Quad q) {
    return q.isPointInQuad(x, y); 
  }
  
  void reset () {
    fx = 0;
    fy = 0;
  }
  
}
