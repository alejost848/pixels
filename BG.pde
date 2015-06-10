public class BG {

  int posX, posY;
  color c;

  public BG(int posX, int posY, int type) {
    this.posX=posX+690;
    this.posY=posY;

    switch(type) {
    case 0:
      c = color(245, 145, 34);
      break;

    case 1:
      c = color(3, 180, 122);
      break;
    case 2:
      c = color(17, 177, 219);
      break;

    case 3:
      c = color(241, 26, 37);
      break;
    case 4:
      c = color(116, 30, 208);
      break;

    case 5:
      c = color(40, 145, 222);
      break;
    case 6:
      c = color(197, 29, 161);
      break;

    case 7:
      c = color(247, 65, 33);
      break;
    }
  }

  public void draw() {
    rectMode(CENTER);
    noStroke();
    fill(c);
    rect(posX, posY, 25, 25);
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
}

