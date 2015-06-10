public class Pixel {

  int posX, posY;
  color c, s;
  boolean modified;

  public Pixel(int posX, int posY) {
    this.posX=posX;
    this.posY=posY;
    modified = false;
    c = 255;
    s = 200;
  }

  public void draw() {
    //Content to export (invisible to the user)
    pg.rectMode(CENTER);    
    pg.stroke(s);
    pg.fill(c);
    pg.rect(posX, posY, 20, 20);
    pg.rectMode(CORNER);
    
    //Visible content
    rectMode(CENTER);
    stroke(s);
    fill(c);
    rect(posX, posY, 20, 20);
    rectMode(CORNER);
  }

  public int getPosX() {
    return posX;
  }

  public int getPosY() {
    return posY;
  }

  public color getFill() {
    return c;
  }

  public void setFill(color cT) {
    c = cT;
  }

  public void setStroke(color sT) {
    s = sT;
  }


  public boolean getModified() {
    return modified;
  }

  public void setModified(boolean mT) {
    modified = mT;
  }
}

