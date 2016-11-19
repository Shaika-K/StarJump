class powerUp {

  private float x, y, top, bottom, left, right;
  private PVector location;
  private boolean touched;//if touched then disappears and points get added
  private PImage image;
  private String type;
  private static final int SIZE = 70;

  powerUp(float x, float bottom, String img, String type) {
    this.type = type;   
    this.image = loadImage(img);
    this.touched = false;    
    this.bottom = bottom;
    this.y = this.bottom - (this.image.height/2);
    this.x = x;
    this.location = new PVector(this.x, this.y);
    this.top = this.y - (this.image.height/2);
    this.left = this.x - (this.image.width/2);
    this.right = this.x + (this.image.width/2);
  }

  void draw() {
    imageMode(CENTER);
    if (type.equals("crystal")) {
      if (!touched) {
        image(this.image, x, y);
      }
    } else if (type.equals("shield")) {      
      image(this.image, x, y);
    }
  }

  void updateLocation (float x, float y) {
    this.x = x;
    this.y = y;
    location = new PVector (x, y);   
    this.top = this.y - (this.image.height/2);
    this.bottom = this.y + (this.image.height/2);
    this.left = this.x - (this.image.width/2);
    this.right = this.x + (this.image.width/2);
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

  void setTouched() {
    this.touched = true;
  }

  boolean hasTouched() {
    return this.touched;
  }

  int getPoint() {
    if (type.equals("sheild")) {
      return 25;
    } else {
      return 20;
    }
  }
}