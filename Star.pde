/*
 Shaika Khan
 3003024293
 */

class Star {

  private static final int SIZE = 65;  //star size
  private float x, y, yVelocity, top, right, bottom, left, setY, speed;  //centre x and y positions, angle of rotation, velocity
  private static final float acceleration = 0.1;  //thrust for traveling upwards 
  private PVector location;  // boundingbox points  
  private boolean jumping, landing, stationary, slowDown, touchedAlien;  //states of the star
  private static final float angle = TWO_PI / 5;
  private static final float halfAngle = angle/2.0;

  Star() {   
    //initialize starting point
    x = width/2;
    y = height - (SIZE/2);
    //intialize fields
    location = new PVector (x, y);
    left = x - (SIZE/2);
    top = y - (SIZE/2) + SIZE;
    bottom = y + (SIZE/2) + SIZE;
    right = x + (SIZE/2);
    touchedAlien = false;
  }

  void draw() {    
    checkState();   
    //rectMode(CENTER);
    //stroke(#FFF06A);
    //noFill();
    //rect(0, 0, SIZE, SIZE);
    
    noStroke();
    beginShape();
    fill(#FFE340);
    for (float a = 0; a < TWO_PI; a += angle) {
      float sx = 0 + cos(a) * 32;
      float sy = 0 + sin(a) * 32;
      vertex(sx, sy);
      sx = 0 + cos(a+halfAngle) * 15;
      sy = 0 + sin(a+halfAngle) * 15;
      vertex(sx, sy);
    }
    endShape(CLOSE);
    beginShape();
    fill(#FFEF90);
    for (float a = 0; a < TWO_PI; a += angle) {
      float sx = 0 + cos(a) * 32;
      float sy = 0 + sin(a) * 32;
      vertex(sx, sy);
      sx = 0 + cos(a+halfAngle) * 5;
      sy = 0 + sin(a+halfAngle) * 5;
      vertex(sx, sy);
    }
    endShape(CLOSE);
  }

  //HELPER METHODS////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  /*Updates the x and y location and position of the bounding box */
  void updateLocation (float x, float y) {
    //position update
    this.x = x;
    this.y = y;
    location = new PVector (x, y);
    //bounding box update
    left = x - (SIZE/2);
    top = y - (SIZE/2) + SIZE;
    bottom = y + (SIZE/2) + SIZE;
    right = x + (SIZE/2);
  }  

  /*Returns the location x and y*/
  PVector getLocation () {
    return location;
  }

  /*returns the top of the star*/
  float getTop() {
    return top;
  }

  /*returns the bottom of the star*/
  float getBottom() {
    return bottom;
  }

  /*returns the left of the star*/
  float getLeft() {
    return left;
  }

  /*returns the right of the star*/
  float getRight() {
    return right;
  }

  /*gets the state of the state of the star to and incremnts or decrements yVelocity accordingly*/
  void checkState() {
    if (jumping && !landing && !stationary) {  //if jumping then decrement so star moves upwards
      yVelocity += (yVelocity * acceleration);
      y -= yVelocity;
    } else if (!jumping && landing && !stationary) {  //if landing then increment so star moves downwards      
      yVelocity += (yVelocity * acceleration)-0.06;
      y += yVelocity;
    } else if (!jumping && !landing && stationary) {  //if stationary then yVelocity is 0      
      this.slowDown = false;
      yVelocity = 0;
      y += speed;
      println(y);
    }
    if (jumping && !landing && !stationary && yVelocity > 15 || y <= 0) {//limit to how high star can jump
      setState(false, true, false);
    }
    updateLocation(x, y);  // call update to reset the fields and x and y
  }

  /*returns the yVelcocity*/
  float getYVelocity() {
    return this.yVelocity;
  }

  /*sets the current state of the star*/
  public void setState(boolean jumping, boolean landing, boolean stationary) {
    this.yVelocity = 1;
    this.jumping = jumping;
    this.landing = landing;
    this.stationary = stationary;
  }

  boolean isJumping() {
    return jumping;
  }

  boolean isLanding() {
    return landing;
  }

  boolean isStationary() {
    return stationary;
  }

  void setYFromBottom(float bottomOfPlatform, float speed) {
    this.setY = bottomOfPlatform - (SIZE/2);
    this.speed = speed;
  }

  void slowDown(boolean slowDown) {
    this.slowDown = slowDown;
    this.yVelocity = 0.1;
  }
  
  void setTouchedAlien(boolean touched){
  touchedAlien = touched;
  }
  
  boolean touchedAlien(){
  return touchedAlien;
  }
}