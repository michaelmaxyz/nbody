class Tree{
  private Body b;
  private Quad q;
  //could easily become 3D with an octree and adding z components
 
  private Tree NW;
  private Tree SW;
  private Tree NE;
  private Tree SE;
  
  public Tree (Quad q) {
    this.q = q;
  }
  
  void drawTree () {
    q.drawQuad();
    if (NW != null) NW.drawTree();
    if (SW != null) SW.drawTree();
    if (NE != null) NE.drawTree();
    if (SE != null) SE.drawTree();
  }
  
  //basically if it is a external or internal node
  public boolean doesTreeContainSingleBody() {
    return NW == null && SW == null && NE == null && SE == null;
  }
  
  public void insert(Body other) {
    if (b == null)
      b = other;
    else if (!doesTreeContainSingleBody()) {
      b = b.combine(other);
      addBodyToQuad(other);
    } else {
      addBodyToQuad(b);
      addBodyToQuad(other);
      b = b.combine(other);
    }
  }
  
  void addBodyToQuad(Body other) {
      Quad qNE = q.NE();
      Quad qNW = q.NW();
      Quad qSE = q.SE();
      Quad qSW = q.SW();
      
      if (other.inQuad(qNE)) {
        if (NE == null) {
          NE = new Tree(qNE);
        }
        NE.insert(other);
      } else if (other.inQuad(q.NW())) {
        if (NW == null) {
          NW = new Tree(qNW);
        }
        NW.insert(other);
      } else if (other.inQuad(q.SE())) {
        if (SE == null) {
          SE = new Tree(qSE);
        }
        SE.insert(other);
      } else if (other.inQuad(q.SW())) {
        if (SW == null) {
          SW = new Tree(qSW);
        }
        SW.insert(other);
      }
  }
  
  public void updateForce(Body b) {
    if (doesTreeContainSingleBody() && this.b != b || q.len / this.b.distance(b) < theta) {
      b.addForce(this.b);
    } else {
      if (NW!=null) NW.updateForce(b);
      if (SW!=null) SW.updateForce(b);
      if (SE!=null) SE.updateForce(b);
      if (NE!=null) NE.updateForce(b);
    }
  }
}
