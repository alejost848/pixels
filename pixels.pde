/**
 * Pixels is a tool for creating 8-bit characters 
 * and illustrations inside a 31x33 canvas.
 * You can also export your creations in a PNG and PDF file.
 *
 * @author  Alejandro Sanclemente (alejost848)
 * @version 0.2
 * June 6th 2015
 */

import javax.swing.JOptionPane;
import processing.pdf.*;

PGraphicsPDF pdf;
PGraphics pg;
int number = 1 ;

PShape logo;
boolean record;

ArrayList<Pixel> allPixels;
ArrayList<BG> allBGs;
Slider r, g, b, brushSize;
int rValue, gValue, bValue;

int diameter;
PImage button1, button2, button3, username, maker, save, trash;

color actualColor;

int tool;

void setup() {
  size(960, 660);
  allPixels = new ArrayList<Pixel>();
  allBGs = new ArrayList<BG>();

  pg = createGraphics(620, 660);

  diameter = 10;

  tool = 1;

  brushSize = new Slider(diameter, 220, color(100, 200), 1);

  r = new Slider(125, 390, color(255, 0, 0, 200), 0);
  g = new Slider(125, 420, color(0, 255, 0, 200), 0);
  b = new Slider(125, 450, color(0, 0, 255, 200), 0);

  rValue = (int) random(0, 255);
  gValue = (int) random(0, 255);
  bValue = (int) random(0, 255);

  actualColor = color(rValue, gValue, bValue);

  r.setPosX((int)rValue);
  g.setPosX((int)gValue);
  b.setPosX((int)bValue);

  button1 = loadImage("button1.png");
  button2 = loadImage("button2.png");
  button3 = loadImage("button3.png");
  username = loadImage("username.png");
  maker = loadImage("maker.png");
  save = loadImage("save.png");
  logo = loadShape("logo.svg");
  trash = loadImage("trash.png");

  for (int i=0; i<31; i++) {
    for (int j=0; j<33; j++) {
      allPixels.add(new Pixel(10+i*20, 10+j*20));
    }
  }

  for (int i=0; i<8; i++) {
    allBGs.add(new BG(i*30, 560, i));
  }

  shapeMode(CENTER);
}
void draw() {
  background(20);

  if (record) {
    pdf = (PGraphicsPDF) createGraphics(620, height, PDF, "pixels" + nf(number, 2) + ".pdf");
    beginRecord(pdf);
  }

  pg.beginDraw();

  for (int i=0; i<allPixels.size (); i++) {
    allPixels.get(i).draw();
  }

  if (record) {
    pg.shapeMode(CENTER);
    pg.shape(logo, 310, 620);
    pdf.shapeMode(CENTER);
    pdf.shape(logo, 310, 620);
    endRecord();
    pg.endDraw();

    pg.save("pixels" + nf(number, 2) + ".png");
    number++;

    record = false;
  }

  for (int i=0; i<allBGs.size (); i++) {
    allBGs.get(i).draw();
  }

  fill(200);
  text("Brush size", 922, 205);
  text("Actual color", 922, 270);
  text("Background color", 922, 540);

  noStroke();
  fill(actualColor);
  rect(662, 280, 255, 70);

  r.draw();
  g.draw();
  b.draw();
  brushSize.draw();

  image(maker, 725, 40);
  image(username, 662, 610);
  image(save, 888, 607);
  image(trash, 920, 18);


  if (tool==1) {
    image(button1, 670, 95);
  }
  if (tool==2) {
    image(button2, 670, 95);
  }
  if (tool==3) {
    image(button3, 670, 95);
  }

  if (mouseX<625) {

    if (tool==1) {
      noCursor(); 
      fill(0, 40);
      ellipse(mouseX, mouseY, diameter*2, diameter*2);
    }
    if (tool==2) {
      noCursor(); 
      noFill();
      stroke(80);
      ellipse(mouseX, mouseY, diameter*2, diameter*2);
    }
    if (tool==3) {
      cursor(ARROW);
    }
  } else  if (mouseX>880 && mouseY>600 && mouseX<915 && mouseY<630) {
    cursor(HAND);
  } else if (mouseX>920 && mouseY>18 && mouseX<940 && mouseY<45) {
    cursor(HAND);
  } else if (mouseX>660 && mouseX<750 && mouseY>90 && mouseY<140) {
    cursor(HAND);
    tint(255, 150);
    image(button1, 670, 95);
    tint(255, 255);
  } else if (mouseX>750 && mouseX<850 && mouseY>90 && mouseY<140) {
    cursor(HAND);
    tint(255, 150);
    image(button2, 670, 95);
    tint(255, 255);
  } else if (mouseX>850 && mouseX<900 && mouseY>90 && mouseY<140) {
    cursor(HAND);
    tint(255, 150);
    image(button3, 670, 95);
    tint(255, 255);
  } else if (mouseX>660 && mouseY>600 && mouseX<770 && mouseY<630) {
    cursor(HAND);
  } else {
    if (mouseX>662 && mouseX<916) {
      if ((mouseY>210 && mouseY<235) || (mouseY>380 && mouseY<400) || (mouseY>410 && mouseY<430) || (mouseY>440 && mouseY<460)) {

        if (mouseY>210 && mouseY<235) {
          cursor(HAND);
          brushSize.setFill(color(100, 255));
        } else if (mouseY>380 && mouseY<400) {
          cursor(HAND);
          r.setFill(color(255, 0, 0, 255));
        } else if (mouseY>410 && mouseY<430) {
          cursor(HAND);
          g.setFill(color(0, 255, 0, 255));
        } else if (mouseY>440 && mouseY<460) {
          cursor(HAND);
          b.setFill(color(0, 0, 255, 255));
        }
      } else {      

        cursor(ARROW);
        brushSize.setFill(color(100, 200));
        r.setFill(color(255, 0, 0, 200));
        g.setFill(color(0, 255, 0, 200));
        b.setFill(color(0, 0, 255, 200));

        for (int i=0; i<allBGs.size (); i++) {
          if (dist(mouseX, mouseY, allBGs.get(i).getPosX(), allBGs.get(i).getPosY())<20) {
            cursor(HAND);
          }
        }
      }
    } else {
      cursor(ARROW);
    }
  }
}

void mousePressed() {
  if (tool==1) {
    paint();
  }
  if (tool==2) {
    erase();
  }
  if (tool==3) {
    picker();
  }

  for (int i=0; i<allBGs.size (); i++) {
    if (dist(mouseX, mouseY, allBGs.get(i).getPosX(), allBGs.get(i).getPosY())<20) {
      color bgTemp = allBGs.get(i).getFill();
      for (int j=0; j<allPixels.size (); j++) {
        if (allPixels.get(j).getModified()==false) {
          allPixels.get(j).setFill(bgTemp);
          allPixels.get(j).setStroke(bgTemp);
        }
      }
    }
  }

  if (mouseX>660 && mouseX<750 && mouseY>90 && mouseY<140) {
    tool = 1;
  }

  if (mouseX>750 && mouseX<850 && mouseY>90 && mouseY<140) {
    tool = 2;
  }

  if (mouseX>850 && mouseX<900 && mouseY>90 && mouseY<140) {
    tool = 3;
  }

  //Save button
  if (mouseX>880 && mouseY>600 && mouseX<915 && mouseY<630) {
    record=true;
    javax.swing.JOptionPane.showMessageDialog(null, "A PNG image and a PDF file have been saved. Check the sketch folder.");
  }

  if (mouseX>660 && mouseY>600 && mouseX<770 && mouseY<630) {
    link("www.facebook.com/arrrcades");
  }

  if (mouseX>920 && mouseY>18 && mouseX<940 && mouseY<45) {
    int response = javax.swing.JOptionPane.showConfirmDialog(null, "Do you want to delete all?", "Delete all", JOptionPane.YES_NO_OPTION, JOptionPane.QUESTION_MESSAGE);

    if (response == JOptionPane.YES_OPTION) {
      deleteAll();
    }
  }
}

void mouseDragged() {
  if (mouseX>725 && mouseX<906) {
    if (mouseY>210 && mouseY<235) {
      diameter = (int) map(mouseX, 725, 905, 10, 40);      
      brushSize.setPosX((int)diameter);
    }
  }
  if (mouseX>661 && mouseX<906) {
    if (mouseY>380 && mouseY<400) {
      rValue = (int) map(mouseX, 662, 905, 0, 255);
      r.setPosX((int)rValue);
      actualColor = color(rValue, gValue, bValue);
    }
    if (mouseY>410 && mouseY<430) {
      gValue = (int) map(mouseX, 662, 905, 0, 255);
      g.setPosX((int)gValue);
      actualColor = color(rValue, gValue, bValue);
    }
    if (mouseY>440 && mouseY<460) {
      bValue = (int) map(mouseX, 662, 905, 0, 255);
      b.setPosX((int)bValue);
      actualColor = color(rValue, gValue, bValue);
    }
  }

  if (mousePressed) {
    if (tool==1) {
      paint();
    }
    if (tool==2) {
      erase();
    }
    if (tool==3) {
      picker();
    }
  }
}

void paint() {
  for (int i=0; i<allPixels.size (); i++) {
    if (dist(mouseX, mouseY, allPixels.get(i).getPosX(), allPixels.get(i).getPosY())<diameter) {
      allPixels.get(i).setFill(actualColor);
      allPixels.get(i).setStroke(actualColor);
      allPixels.get(i).setModified(true);
    }
  }
}

void erase() {
  for (int i=0; i<allPixels.size (); i++) {
    if (dist(mouseX, mouseY, allPixels.get(i).getPosX(), allPixels.get(i).getPosY())<diameter) {
      allPixels.get(i).setFill(color(255));
      allPixels.get(i).setStroke(color(200));
      allPixels.get(i).setModified(false);
    }
  }
}

void picker() {
  for (int i=0; i<allPixels.size (); i++) {
    if (dist(mouseX, mouseY, allPixels.get(i).getPosX(), allPixels.get(i).getPosY())<10) {
      actualColor = allPixels.get(i).getFill();
      if (actualColor==255) {
        r.setPosX(255);
        g.setPosX(255);
        b.setPosX(255);
        rValue = 255;
        gValue = 255;
        bValue = 255;
      } else {
        r.setPosX((int) red(actualColor));
        g.setPosX((int) green(actualColor));
        b.setPosX((int) blue(actualColor));
        rValue = (int) red(actualColor);
        gValue = (int) green(actualColor);
        bValue = (int) blue(actualColor);
      }

      println(actualColor);
    }
  }
}

void deleteAll() {
  for (int i=0; i<allPixels.size (); i++) {
    allPixels.get(i).setFill(color(255));
    allPixels.get(i).setStroke(color(200));
    allPixels.get(i).setModified(false);
  }
}

