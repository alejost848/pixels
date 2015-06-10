public class Slider {

  int posX, posY, type;
  color c;

  public Slider(int posX, int posY, color c, int type) {
    this.posX=posX;
    this.posY=posY;
    this.c=c;    
    this.type=type;
  }

  public void draw() {
    noStroke();
    fill(30);
    rect(662, posY, 255, 10);
    if (type==1) {
      fill(c);
      rect(662, posY, (int) posX*6.375, 10);
    } else {
      fill(c);
      rect(662, posY, posX, 10);
    }


    fill(200);
    textAlign(RIGHT);
    text(posX, 917, posY+9);
  }

  public int getPosX() {
    return posX;
  }

  public int getPosY() {
    return posY;
  }

  public void setPosX(int pX) {
    posX = pX;
  }
}

