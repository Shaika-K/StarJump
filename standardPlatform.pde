/*
 Shaika Khan
 3003024293
 */

class standardPlatform {

  private float x, y, top, bottom, left, right;
  private static final int HEIGHT = 30;
  private int LENGTH;
  private PVector location;
  private boolean hasLandedOnce;

  standardPlatform(float y) {
    LENGTH = (int) random(80, 500);
    //initialize positions
    x = random(0, 700);
    this.y = y;  
    location = new PVector (x, y);
    left = x - (LENGTH/2);
    top = y - (HEIGHT/2);
    bottom = y + (HEIGHT/2);
    right = x + (LENGTH/2);
    hasLandedOnce = false;
  }

  void draw() {
    fill(#F08F5E);
    noStroke();
    rectMode(CENTER);
    rect(x, y, LENGTH, HEIGHT);    
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
  }
  
  boolean hasLandedOnce(){
  return this.hasLandedOnce;
  }
}