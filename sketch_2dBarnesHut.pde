final float dt = .05;
final float soft = 10000;
final float G = 60;
final float mass = 5000;
final int n = 1000;
final int len = 1000;
boolean showLines = false;
Quad q;
ArrayList<Body> bodies;
void keyPressed() {
  print(keyCode);
  if (keyCode == 112) 
    showLines = !showLines;
}

void setup() {
   size(1000, 1000);
   initialize();
}

void draw() {
  background(255);
   Tree t = new Tree(q);
   for (int i = 0; i < n; i++) {
     if (bodies.get(i).inQuad(q)) {
       t.insert(bodies.get(i));
     }
     circle(bodies.get(i).x, bodies.get(i).y, 10);
   }
   
   if (showLines)
     t.drawTree();

   for (int i = 0; i < n; i++) {
     bodies.get(i).reset();
     if (bodies.get(i).inQuad(q)) {
       t.updateForce(bodies.get(i));
       bodies.get(i).move();
     }
     
     circle(bodies.get(i).x, bodies.get(i).y, 2);
   }
   
}

void initialize() {
  q = new Quad (len / 2, len / 2, len / 2);
  bodies = new ArrayList<Body>();
  for (int i = 0; i < n; i++) {
    bodies.add(new Body(random((len / 3), ((2 * len) / 3)), random((len / 3), ((2 * len) / 3)), mass, color(0)));  
  }
  
}
