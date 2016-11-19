/*
CGRA 151 Assignment 5 - Start Jump
 Shaika Khan
 3003024293
 */

private float time, bg;  //time in milliseconds when game started
private ArrayList <standardPlatform> standardPlatforms;  //standardPlatforms 
private ArrayList <vanishingPlatform> vanishingPlatforms;  //vanishingPlatforms
private ArrayList <powerUp> crystals;  //crystals
private ArrayList <obstacle> aliens;  //aliens
private Star star;  //Star
private float levelSpeed, platformSpeed, backgroundSpeed, angle;  //Level glider speed 
private int level, score; //level recorder
private PImage background, toDisplay, homeBackground, htpBackground, scoreBackground; // backgrounds for each state
private boolean timeToDrawLevel, gameOver, howtoplay, homepage, scorepage, playgame, gotToTheEnd; //game state booleans
private PFont font, font2, font3;  //fonts for game

void setup() {
  //initialize game world  
  size(700, 700);
  frameRate(30);
  homeBackground = loadImage("home.png"); 
  htpBackground  = loadImage("Instructions.png"); 
  scoreBackground = loadImage("Score.png"); 
  //intialize game states
  homepage = true;
  scorepage = false;
  howtoplay = false;
  playgame = false;
  gotToTheEnd = false;  
  //load fonts
  font = loadFont("OCRAExtended-28.vlw");
  font2 = loadFont("OCRAExtended-22.vlw");
  font3 = loadFont("OCRAExtended-48.vlw");
}

void draw() {
  if (homepage) {
    //draw homepage
    background(homeBackground);
    checkButtons();
  } else if (howtoplay) {
    //draw how to play
    background(htpBackground);
    checkButtons();
  } else if (playgame) {    //draw game 
    //draw background and update
    background(#636681);  
    background(toDisplay);
    bg-=backgroundSpeed;
    toDisplay = background.get(0, (int)bg, 700, 700); 
    //draw game objects
    drawLevel();
    drawPlatforms();
    drawStar();
    drawScore();
    drawPowerUps();
    drawObstacles();    
    //check the tstae of game objects
    checkStar();
    checkpowerUps();    
    checkTime();   
    checkObstacles();
  } else if (scorepage) {    //draw score page
    //if player got to the end of the game then draw score page with that information
    background(scoreBackground);
    if (gotToTheEnd) {
      fill(#5E4DAA);
      textFont(font2);
      text("You finished the game!", 207, 320);
      text("Your score was:", 254, 363);
      fill(#F07D50);
      textFont(font3);
      text(score, 350-(textWidth(""+score)/2), 425);
    } else {     //else draw score page with just score
      fill(#5E4DAA);
      textFont(font);    
      text("Your score was:", 226, 337);
      fill(#F07D50);
      textFont(font3);
      text(score, 350-(textWidth(""+score)/2), 415);
    }
    checkButtons();
  }//check keys
  keypressed();
}



//O T H E R   H E L P E R   M E T H O D S/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*initiaizes the play game state everytime play game button is clicked from homepage*/
void initialize() {
  //initialize fileds to play game mode
  time = millis();
  score = 0;
  gameOver = false;
  //level announcer
  level = 1;
  levelSpeed = 0; 
  timeToDrawLevel = true;
  //moving background
  backgroundSpeed = 0.8;
  bg = 3250-700;
  background = loadImage("background.png");  
  toDisplay = background.get(0, (int)bg, 700, 700); 
  //star
  angle = frameCount / -100.0;
  star = new Star(); 
  star.setTouchedAlien(false);
  //platforms
  platformSpeed = 2;
  standardPlatforms = new ArrayList <standardPlatform> ();
  for (int i = 0; i < 25; i++) {
    standardPlatforms.add(new standardPlatform(-80 - ((150 * i) * 2)));
  }
  vanishingPlatforms = new ArrayList <vanishingPlatform> ();
  for (int i = 0; i < 25; i++) {
    vanishingPlatforms.add(new vanishingPlatform(-230 - ((150 * i) * 2)));
  }
  //powerUps and obstacles
  crystals = new ArrayList <powerUp>();
  initializeCrystals();
  aliens = new ArrayList <obstacle>();  
  initializeAliens();
}

/*initializes the crystal powerUp objects to be on a platfrom*/
void initializeCrystals() {
  //gets the platform and creates a new crystal with initial position on the platform
  standardPlatform platform = standardPlatforms.get(5);
  crystals.add(new powerUp(random(max(0, platform.getLeft()), min(width, platform.getRight())), platform.getTop(), "crystal.png", "crystal"));
  platform = standardPlatforms.get(8);
  crystals.add(new powerUp(random(max(0, platform.getLeft()), min(width, platform.getRight())), platform.getTop(), "crystal.png", "crystal"));
  platform = standardPlatforms.get(11);
  crystals.add(new powerUp(random(max(0, platform.getLeft()), min(width, platform.getRight())), platform.getTop(), "crystal.png", "crystal"));
  platform = standardPlatforms.get(13);
  crystals.add(new powerUp(random(max(0, platform.getLeft()), min(width, platform.getRight())), platform.getTop(), "crystal.png", "crystal"));
  platform = standardPlatforms.get(16);
  crystals.add(new powerUp(random(max(0, platform.getLeft()), min(width, platform.getRight())), platform.getTop(), "crystal.png", "crystal"));
  platform = standardPlatforms.get(20);
  crystals.add(new powerUp(random(max(0, platform.getLeft()), min(width, platform.getRight())), platform.getTop(), "crystal.png", "crystal"));
  platform = standardPlatforms.get(22);
  crystals.add(new powerUp(random(max(0, platform.getLeft()), min(width, platform.getRight())), platform.getTop(), "crystal.png", "crystal"));
  platform = standardPlatforms.get(24);
  crystals.add(new powerUp(random(max(0, platform.getLeft()), min(width, platform.getRight())), platform.getTop(), "crystal.png", "crystal"));
}

/*initializes the alien obstacle objects to be on a platfrom*/
void initializeAliens() {
  //gets the platform and creates a new alien with initial position on the platform
  standardPlatform platform = standardPlatforms.get(3);
  aliens.add(new obstacle(random(max(0, platform.getLeft()), min(width, platform.getRight())), platform.getTop(), "alien.png", "alien"));
  platform = standardPlatforms.get(10);
  aliens.add(new obstacle(random(max(0, platform.getLeft()), min(width, platform.getRight())), platform.getTop(), "alien.png", "alien"));
  platform = standardPlatforms.get(14);
  aliens.add(new obstacle(random(max(0, platform.getLeft()), min(width, platform.getRight())), platform.getTop(), "alien.png", "alien"));
  platform = standardPlatforms.get(17);
  aliens.add(new obstacle(random(max(0, platform.getLeft()), min(width, platform.getRight())), platform.getTop(), "alien.png", "alien"));
  platform = standardPlatforms.get(18);
  aliens.add(new obstacle(random(max(0, platform.getLeft()), min(width, platform.getRight())), platform.getTop(), "alien.png", "alien"));
  platform = standardPlatforms.get(21);
  aliens.add(new obstacle(random(max(0, platform.getLeft()), min(width, platform.getRight())), platform.getTop(), "alien.png", "alien"));
}

/*draws the score on the top left corner*/
void drawScore() {
  fill(#6CE8B3);
  textSize(28);
  textFont(font);
  text("Score:"+score, 10, 30);
}

/*if the game state is anything other than playgame then it need buttons to change from one state to another*/
void checkButtons() {
  //if homepage is true then display 2 button (how to play and play game)
  if (homepage) {
    if (hoverOver(430, 340, 220, 70)) {//how to play button
      noStroke();
      fill(color(147, 77, 147, 255));
      rectMode(CENTER);
      rect(540, 375, 220, 70);
    } else {  //full opacity on hover
      noStroke();
      fill(color(147, 77, 147, 127));
      rectMode(CENTER);
      rect(540, 375, 220, 70);
    }
    if (hoverOver(430, 470, 220, 70)) {//play game button
      noStroke();
      fill(color(147, 77, 147, 255));
      rectMode(CENTER);
      rect(540, 505, 220, 70);
    } else {  //full opacity on hove
      noStroke();
      fill(color(147, 77, 147, 127));
      rectMode(CENTER);
      rect(540, 505, 220, 70);
    }//button text
    fill(255);
    textSize(18);
    textFont(font);
    text("How To Play", 446, 385);
    text("Play Game", 462, 515);
  }
  //if how to play is true then display button to go back home
  if (howtoplay) {
    if (hoverOver(240, 610, 220, 70)) {//home button
      noStroke();
      fill(color(147, 77, 147, 255));
      rectMode(CENTER);
      rect(350, 645, 220, 70);
    } else {  //full opacity on hover
      noStroke();
      fill(color(147, 77, 147, 127));
      rectMode(CENTER);
      rect(350, 645, 220, 70);
    }   //button text
    fill(255);
    textSize(18);
    textFont(font);
    text("Return", 299, 657);
  }
  //if score page is true then display button to go back home
  if (scorepage) {
    if (hoverOver(240, 610, 220, 70)) {//home button
      noStroke();
      fill(color(147, 77, 147, 255));
      rectMode(CENTER);
      rect(350, 645, 220, 70);
    } else {  //full opacity on hover
      noStroke();
      fill(color(147, 77, 147, 127));
      rectMode(CENTER);
      rect(350, 645, 220, 70);
    }   //button text
    fill(255);
    textSize(18);
    textFont(font);
    text("Home", 314, 657);
  }
}

/*returns is mouse is insice a button parameters*/
boolean hoverOver(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && 
    mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

/*draws the level glider which travels down the screen everytime the player enters a new level*/
void drawLevel() {
  if (timeToDrawLevel) {
    fill(255);
    textSize(30);
    text("level "+ level, 300, levelSpeed);
    levelSpeed+=10;//increase y to make it look like it gliding down
    if (levelSpeed > height) {
      levelSpeed = 0;
      timeToDrawLevel = false;
    }
  }
}

/*draws all the platforms and then calls update on their positions so they move downwards*/
void drawPlatforms() {
  for (int i = 0; i < standardPlatforms.size(); i++) {  //for all platforms draw and update y value to move down the screen
    standardPlatforms.get(i).draw();
  }
  for (int i = 0; i < vanishingPlatforms.size(); i++) {  //for all platforms draw and update y value to move down the screen
    vanishingPlatforms.get(i).draw();
  }
  updatePlatforms();
}

/*draws powerups*/
void drawPowerUps() {
  for (int i = 0; i < crystals.size(); i++) {  //for all platforms draw and update y value to move down the screen
    crystals.get(i).draw();
  }
}

/*draws obstacles*/
void drawObstacles() {
  for (int i = 0; i < aliens.size(); i++) {  //for all platforms draw and update y value to move down the screen
    aliens.get(i).draw();
  }
}

/*draws the star and translates and rotates it to look like its spinning*/
void drawStar() {
  pushMatrix();
  translate(this.star.getLocation().x, this.star.getLocation().y);
  this.star.updateLocation(this.star.getLocation().x, this.star.getLocation().y);
  rotate(frameCount/6.5);
  star.draw();
  popMatrix();
}

/*check if star interacts with powerUps*/
void checkpowerUps() {
  for (powerUp pU : crystals) {
    if (!pU.hasTouched()) {//if powerUp isn't already touched
      //if star touches crystal, it gets the points and crystal disapears
      if ((star.getLeft() > pU.getLeft() && star.getLeft() < pU.getRight())
        ||(star.getRight() < pU.getRight() && star.getRight() > pU.getLeft())) {                                       
        if ((this.star.getBottom()-81 >= pU.getTop()-20 && this.star.getBottom()-81 < pU.getBottom())) {
          //if star is touching the powerup from left, right or top then add points and make powerup disappear
          pU.setTouched();
          score += pU.getPoint();
        }
      }
    }
  }
}

/*check if star interacts with obstacles*/
void checkObstacles() {
  for (obstacle ob : aliens) {    
    //if star touches aliens, it gets deducted the points 
    if ((star.getLeft() > ob.getLeft() && star.getLeft() < ob.getRight())
      ||(star.getRight() < ob.getRight() && star.getRight() >ob.getLeft())) {                                  
      //if star's bottom is between the powerUps bottom and the powerUps top     
      if ((this.star.getBottom()-81 >= ob.getTop()-20 && this.star.getBottom()-81 < ob.getBottom())) {
        //if star is touching the alien from left, right or top then deduct points and game over
        this.gameOver = true;
        scorepage = true;
        playgame = false;
      }
    }
  }
}



/*checks if the star is making contact with any of the platforms*/
void checkStar() {  
  for (standardPlatform stP : standardPlatforms) {
    //if star is within the left and right of the platform
    if ((star.getLeft() > stP.getLeft() && star.getLeft() < stP.getRight())
      ||(star.getRight() < stP.getRight() && star.getRight() > stP.getLeft())) {                                  
      //if star's top touches the bottom of a platform then switch star state to landing
      if ((this.star.getTop() <= stP.getBottom() && this.star.getTop() > stP.getLocation().y)
        && !star.isLanding()) {         
        star.setState(false, true, false);
      }
      //if star's bottom touches the top of a platform then switch star state to stationary  
      else if ((this.star.getBottom()-81 >= stP.getTop()-20 && this.star.getBottom()-81 < stP.getLocation().y) && !star.isJumping() && !star.isStationary()) {
        star.setState(false, false, true);        
        star.setYFromBottom(stP.getBottom(), platformSpeed);
        if (!stP.hasLandedOnce()) {//if it is the first time landing on that platform then add points
          score += 5;
          stP.setLanded();
        }
      }
    } else {
      if (this.star.isStationary()) {// if star has left platform then go back to landing
        star.setState(false, true, false);
      }
    }
  }
  for (vanishingPlatform vP : vanishingPlatforms) {
    //if star is within the left and right of the platform
    if ((star.getLeft() > vP.getLeft() && star.getLeft() < vP.getRight())
      ||(star.getRight() < vP.getRight() && star.getRight() > vP.getLeft())) {                                  
      //if star's top touches the bottom of a platform then switch star state to landing
      if ((this.star.getTop() <= vP.getBottom() && this.star.getTop() > vP.getLocation().y)
        && !star.isLanding() && !vP.hasVanished()) {         
        star.setState(false, true, false);
      }
      //if star's bottom touches the top of a platform then switch star state to stationary  
      else if ((this.star.getBottom()-81 >= vP.getTop()-20 && this.star.getBottom()-81 < vP.getLocation().y) && !star.isJumping() && !star.isStationary() && !vP.hasVanished()) {        
        star.setState(false, false, true);        
        star.setYFromBottom(vP.getBottom(), platformSpeed);
        if (!vP.hasLandedOnce()) {//if it is the first time landing on that platform then add points
          score += 10;
          vP.setLanded();
        }
      }
    } else {// if star has left platform then go back to landing
      if (this.star.isStationary()) {
        star.setState(false, true, false);
      }
    }
  }
  if (this.star.isLanding() && this.star.getBottom()-80 >= height) {// if star has has fallen to or past the bottom of the screen then its game over
    this.gameOver = true;
    scorepage = true;
    playgame = false;
  }
}

/*returns if game is over*/
boolean gameOver() {
  return gameOver;
}

/*checks the time to see if enough time has passed to level up (go faster)*/
void checkTime() {
  //level 2
  if (millis()-time >= 30000  && millis()-time < 50000 && level < 2) {    
    //speed up platforms and background
    platformSpeed = 4;
    backgroundSpeed = 1.4;
    if (!timeToDrawLevel) {
      timeToDrawLevel = true;
      level = 2;
    }
  }
  //level 3
  else if (millis()-time >= 50000 && millis()-time < 65000 && level < 3) {
    //speed up platforms and background
    platformSpeed = 8;
    backgroundSpeed = 2.0;
    if (!timeToDrawLevel) {
      timeToDrawLevel = true;
      level = 3;
    }
  } else if ((millis()-time >= 65000 || bg <= 0) && !gameOver) {   // if game has reached the moon then game has finished and is game over
    gameOver = true;
    scorepage = true;
    playgame = false;
    gotToTheEnd = true;
  }
}

/*increment platform and everything on it (like aliens and crystals) y value so they move down*/
void updatePlatforms() {
  for (int i = 0; i < 25; i++) {
    standardPlatforms.get(i).updateLocation(standardPlatforms.get(i).getLocation().x, standardPlatforms.get(i).getLocation().y+platformSpeed);   
    vanishingPlatforms.get(i).updateLocation(vanishingPlatforms.get(i).getLocation().x, vanishingPlatforms.get(i).getLocation().y+platformSpeed);
  }
  for (int i = 0; i < crystals.size(); i++) {
    crystals.get(i).updateLocation(crystals.get(i).getLocation().x, crystals.get(i).getLocation().y+platformSpeed);
  }
  for (int i = 0; i < aliens.size(); i++) {
    aliens.get(i).updateLocation(aliens.get(i).getLocation().x, aliens.get(i).getLocation().y+platformSpeed);
  }
}

void keypressed() {
  if (!keyPressed) return;
  if (key == CODED) {
    if (keyCode == UP) {  //call jump on star
      //if star isn't at the top of the screen
      if (playgame && star.getTop()-60 > 0) {
        star.setState(true, false, false);
      }
    }
    if (keyCode == LEFT) {  //move left on star
      //if star isn't at the left of the screen
      if (playgame && star.getLeft() > 3) {
        star.updateLocation(star.getLocation().x-5, star.getLocation().y);
      }
    } 
    if (keyCode == RIGHT) {  //move right on star
      //if star isn't at the right of the screen
      if (playgame && star.getRight() < width-3) {
        star.updateLocation(star.getLocation().x+5, star.getLocation().y);
      }
    }
  }
}

void mouseClicked() {
  if (homepage && mouseX >= 430 && mouseX <= 430+220 && 
    mouseY >= 340 && mouseY <= 340+70) { 
    //if at homepage and mouse clicked on the how to play button then how to play true and everything else false
    homepage = false;
    howtoplay = true;
    playgame = false;
    scorepage = false;
  } else if (homepage && mouseX >= 430 && mouseX <= 430+220 && 
    mouseY >= 470 && mouseY <= 470+70) {
    //if at homepage and mouse clicked on the play game button then play game true and everything else false
    homepage = false;
    howtoplay = false;
    scorepage = false;
    playgame = true;
    initialize();
  } else if (howtoplay && mouseX >= 240 && mouseX <= 240+220 && 
    mouseY >= 610 && mouseY <= 610+70) {
    //if at how to play and mouse clicked on the home button then homepage true and everything else false
    homepage = true;
    howtoplay = false;
    playgame = false;
    scorepage = false;
  } else if (scorepage && mouseX >= 240 && mouseX <= 240+220 && 
    mouseY >= 610 && mouseY <= 610+70) {
    //if at score page and mouse clicked on the home button then homepage true and everything else false
    homepage = true;
    howtoplay = false;
    playgame = false;
    scorepage = false;
  }
}