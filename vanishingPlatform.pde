/*
 Shaika Khan
 3003024293
 */

class vanishingPlatform {

  private float x, y, top, bottom, left, right;
  private static final int HEIGHT = 20;
  private int LENGTH;
  private PVector location;
  private boolean hasLandedOnce, vanished;  //if landed then platform vanishes in less than 2 seconds
  private float time;

  vanishingPlatform(float y) {
    LENGTH = (int) random(80, 600);
    //initialize positions
    x = random(0, 700);
    this.y = y;  
    location = new PVector (x, y);
    left = x - (LENGTH/2);
    top = y - (HEIGHT/2);
    bottom = y + (HEIGHT/2);
    right = x + (LENGTH/2);
    vanished = false;
  }

  void draw() {      
    for (int i = 0; i < HEIGHT; i++) {//to make platform look like a gradient
      if (hasLandedOnce) {
        if (millis() - time < 150) {//opacity of platform chnages after star has landed to lookl ike its vanishing
          stroke(255-(i*4), 255-(i*8), 255-i, 255);
        } else if (millis() - time >= 150 && millis() - time < 300) {
          stroke(255-(i*4), 255-(i*8), 255-i, 204);
        } else if (millis() - time >= 300 && millis() - time < 450) {
          stroke(255-(i*4), 255-(i*8), 255-i, 153);
        } else if (millis() - time >= 450 && millis() - time < 600) {
          stroke(255-(i*4), 255-(i*8), 255-i, 102);
        } else if (millis() - time >= 600 && millis() - time < 750) {
          stroke(255-(i*4), 255-(i*8), 255-i, 51);
        } else if (millis() - time >= 750) {
          stroke(255-(i*4), 255-(i*8), 255-i, 0);
          vanished = true;
        }
      } else {
        stroke(255-(i*4), 255-(i*8), 255-i, 255);
      }      
      strokeWeight(3);
      line(left, top+i, right, top+i);
    }
  }

  void updateLocation (float x, float y) {
    //update positions
    this.x = x;
    this.y = y;
    location = new PVector (x, y);   
    left = x - (LENGTH/2);
    top = y - (HEIGHT/2);
    bottom = y + (HEIGHT/2);
    right = x + (LENGTH/2);
  }

  PVector getLocation () {
    return location;
  }

  float getTop() {
    return top;
  }

  float getBottom() {
    return bottom;
  }

  /*returns the left of the platform*/
  float getLeft() {
    return this.left;
  }

  /*returns the right of the platform*/
  float getRight() {
    return this.right;
  }

  void setLanded() {
    this.hasLandedOnce = true;
    time = millis();
  }

  boolean hasLandedOnce() {
    return this.hasLandedOnce;
  }

  boolean hasVanished() {
    return this.vanished;
  }
}