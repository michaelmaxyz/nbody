//constants do not reflect REAL life physics, i just chose values 
//that would be the easiest to work with / debug
final float dt = .1;
final float soft = 10000;
final float G = 70;
final float mass = 5000;
final int n = 40000;
final int smallSize = 2;
final int len = 1000;
final float circleRad = 300;

//when theta is a large number the simulation becomes faster
//but less accurate. when theta is 0 it degenerates into brute force
final float theta = 2;
int centerX;
int centerY;
boolean showLines = false;
Quad q;
ArrayList<Body> bodies;

void keyPressed() {
  if (keyCode == 112)
    showLines = !showLines;
}

void setup() {
  size(1000, 1000);
  centerX = len / 2;
  centerY = len / 2;
  
  //future ideas for initialization:
  //colliding galaxies
  //elliptical galaxies
  //random size stars
  //
  initializeLargeMass();
}

void draw() {
  background(0);
  Tree t = new Tree(q);
  
  //insert into quadtree
  for (Body b: bodies) {
    if (b.inQuad(q)) t.insert(b);  
  }
  
  noStroke();

  for (Body b: bodies) {
    b.reset();
    if (b.inQuad(q)) {
      t.updateForce(b);
      b.move();
    }
    fill(b.col);
    circle(b.x, b.y, b.size);
  }
  
  if (showLines)
    t.drawTree();
}

void initializeLargeMass() {
  
  float radius;
  float theta;
  float x;
  float y;
  float dist;
  
  q = new Quad (centerX, centerY, len);
  bodies = new ArrayList<Body>();
  //black hole! colored red b/c background is black
  bodies.add(new Body(centerX, centerY, 0, 0, 100000000, smallSize , color(255, 0, 0)));
  for (int i = 0; i < n - 1; i++) {
    
    //could be optimized but its only running this function once, so whatever
    do {
       radius = circleRad * sqrt(random(0, 1));
       theta = random(0, 1) * 2 * PI;
       x = radius * cos(theta) + centerX;
       y = radius * sin(theta) + centerY;
       dist = distance(x, y, centerX, centerY);
    } while (dist < 100);
    
    //just a bunch of math to get initial velocities to be tangent to circle
    float dx = x - centerX;
    float dy = y - centerY;
    float a = asin(100 / dist);
    float b = atan2(dy, dx);
    float t = b - a;
    float vx = radius * sin(t);
    float vy = radius * -cos(t);    
    bodies.add(new Body(x, y, vx, vy, mass, smallSize, color(255, 204, 0)));
  }
}

float distance (float x1, float y1, float x2, float y2) {
  float xDiff = x1 - x2;
  float yDiff = y1 - y2;
  return sqrt(xDiff * xDiff + yDiff * yDiff);
}

void initializeRandom() {
  q = new Quad (centerX, centerX, len / 2);
  bodies = new ArrayList<Body>();
  
  //put em randomly
  for (int i = 0; i < n; i++) {
    bodies.add(new Body(random((len / 3), ((2 * len) / 3)), random((len / 3), ((2 * len) / 3)), 0, 0, mass, smallSize, color(255, 204, 0)));
  }
}
