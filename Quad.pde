class Quad {
  
  //points reflect center of quad
  float x;
  float y;
  
  //represents the length from center of quad to edge
  float len;
  
  public Quad(float x, float y, float len) {
    this.x = x;
    this.y = y;
    this.len = len;
  }
  
  void drawQuad() {
    stroke(255);
    line(x-len,y+len,x+len,y+len);
    line(x-len,y-len,x+len,y-len);
    line(x-len,y+len,x-len,y-len);
    line(x+len,y+len,x+len,y-len);
  }
  
  public boolean isPointInQuad(float xloc, float yloc) {
    if (xloc > x + len) 
      return false;
    else if (xloc < x - len)
      return false;
    else if (yloc > y + len)
      return false;
    else if (yloc < y - len)
      return false;
    return true;
  }
  
  public Quad NW() {
    return new Quad(x - len / 2, y - len / 2, len / 2); 
  }
  
  public Quad SW() {
    return new Quad(x - len / 2, y + len / 2, len / 2); 
  }
  
  public Quad NE() {
    return new Quad(x + len / 2, y - len / 2, len / 2); 
  }
  
  public Quad SE() {
    return new Quad(x + len / 2, y + len / 2, len / 2); 
  }
  
}
