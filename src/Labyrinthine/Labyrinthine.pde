// Made by McKay Essig, David Madden, Marz Meyer, Connor Deweerd
import gifAnimation.*;
Player p1;
int px, py;
Gif gifRest, gifUp, gifDown, gifLeft, gifRight;
float speed, stamina;
boolean upPressed, downPressed, leftPressed, rightPressed, sprinting, isStarted;
PImage startScreen;
PImage guiOverlay;
void setup() {
  gifRest  = new Gif(this, "Theseus.gif");
  gifUp    = new Gif(this, "TheseusBak.gif");
  gifDown  = new Gif(this, "TheseusFwd.gif");
  gifLeft  = new Gif(this, "TheseusLeft.gif");
  gifRight = new Gif(this, "TheseusRight.gif");
  isStarted = false;
  size(1080, 720);
  frameRate(30);
  speed = 3;
  stamina = 100;
  startScreen = loadImage("Labyrinthine.png");
  guiOverlay = loadImage("GUI.png");
  p1 = new Player(width/2, height/2, this);
}

void draw() {
  imageMode(CENTER);
  background(120, 120, 120);
  p1.display();
  // Sprint System
  if (sprinting == true) {
    speed = 8;
    stamina -= .8;
  } else {
    if (stamina <100) {
      stamina += .5;
    }
    speed = 3;
  }
  if (stamina<0) {
    stamina = 0;
    speed = 3;
  }
  //Movement management
  if (upPressed)    p1.y -= speed;
  if (downPressed)  p1.y += speed;
  if (leftPressed)  p1.x -= speed;
  if (rightPressed) p1.x += speed;
  //player direction management
  //p1.pDir is the char for direction, r=resting, wasd=up/down/left/right.
  p1.picon.loop();
  //if (p1.pDir == 'r') {
  //  p1.picon = new Gif(this, "Theseus.gif");
  //} else if (p1.pDir == 'w') {
  //  p1.picon = new Gif(this, "TheseusBak.gif");
  //} else if (p1.pDir == 's') {
  //  p1.picon = new Gif(this, "TheseusFwd.gif");
  //}else if (p1.pDir == 'a') {
  //  p1.picon = new Gif(this, "TheseusLeft.gif");
  //}else if (p1.pDir == 'd') {
  //  p1.picon = new Gif(this, "TheseusRight.gif");
  //}
  Gif target = gifRest;
if      (p1.pDir == 'w') target = gifUp;
else if (p1.pDir == 's') target = gifDown;
else if (p1.pDir == 'a') target = gifLeft;
else if (p1.pDir == 'd') target = gifRight;

if (p1.picon != target) {
  p1.picon.stop();
  p1.picon = target;
  p1.picon.loop();
}
  //Startscreen
  if (isStarted == false) {
    image(startScreen, width/2, height/2);
  } else {//UI
    image(guiOverlay, width/2, height/2, width, height);
    fill(256, 0, 0);
    rect(500, 83, p1.health*1.75, 45);
    fill(0, 256, 0);
    rect(500, 20, stamina*1.75, 40);
  }
}
//Keybinds
void keyPressed() {
  if (key == 'w' || key == 'W') {
    upPressed = true;
    p1.pDir = 'w';
  } else if (key == 's' || key == 'S') {
    downPressed = true;
    p1.pDir = 's';
  } else if (key == 'a' || key == 'A') {
    leftPressed = true;
    p1.pDir = 'a';
  } else if (key == 'd' || key == 'D') {
    rightPressed = true;
    p1.pDir = 'd';
  }
  if (key == CODED) {
    if (keyCode == SHIFT) {
      sprinting = true;
    }
  }
}

void keyReleased() {
p1.pDir = 'r';
  if (key == 'w' || key == 'W') {
    upPressed = false;
  } else if (key == 's' || key == 'S') {
    downPressed = false;
  } else if (key == 'a' || key == 'A') {
    leftPressed = false;
  } else if (key == 'd' || key == 'D') {
    rightPressed = false;
  }
  if (key == CODED) {
    if (keyCode == SHIFT) {
      sprinting = false;
    }
  }
}
void mousePressed() {
  println("mouseX," + mouseX + "mouseY," + mouseY);
  if (mouseX > 200 && mouseY > 207 && mouseX <525 && mouseY <333) {
    if (isStarted == false) {
      isStarted = true;
    }
  }
}
