// Made by McKay Essig, David Madden, Marz Meyer, Connor Deweerd
import gifAnimation.*;
Player p1;
MazeGen maze;
int px, py;
float speed, stamina;
boolean upPressed, downPressed, leftPressed, rightPressed, sprinting, isStarted;
PImage startScreen;
PImage guiOverlay;
Gif gifRest, gifUp, gifDown, gifLeft, gifRight;

void setup() {
  isStarted = false;
  size(1080, 720);
  frameRate(30);
  speed = 3;
  stamina = 100;
  startScreen = loadImage("Labyrinthine.png");
  guiOverlay = loadImage("GUI.png");
  p1 = new Player(width/2, height/2, this);

  gifRest  = new Gif(this, "Theseus.gif");
  gifUp    = new Gif(this, "TheseusBak.gif");
  gifDown  = new Gif(this, "TheseusFwd.gif");
  gifLeft  = new Gif(this, "TheseusLeft.gif");
  gifRight = new Gif(this, "TheseusRight.gif");

  mazegenerate();
}

// Builds a new random maze and puts the player at the start
void mazegenerate() {
  maze = new MazeGen(25, 25, 80);   // 25x25 cells, 80px per tile
  maze.generate();
  p1.x = int(maze.startX());
  p1.y = int(maze.startY());
}

void draw() {
  imageMode(CENTER);
  background(120, 120, 120);

  // Sprint System
  if (sprinting == true) {
    speed = 8;
    stamina -= .8;
  } else {
    if (stamina < 100) {
      stamina += .5;
    }
    speed = 3;
  }
  if (stamina < 0) {
    stamina = 0;
    speed = 3;
  }

  // Movement management (with wall collision, each axis separately so you slide along walls)
  if (isStarted) {
    int step = int(speed);
    int dx = 0, dy = 0;
    if (upPressed)    dy -= step;
    if (downPressed)  dy += step;
    if (leftPressed)  dx -= step;
    if (rightPressed) dx += step;

    if (!maze.hitsWall(p1.x + dx, p1.y)) p1.x += dx;
    if (!maze.hitsWall(p1.x, p1.y + dy)) p1.y += dy;

    // reached the exit -> new maze
    if (maze.atExit(p1.x, p1.y)) {
      mazegenerate();
    }
  }

  // player animation (swap between preloaded gifs, never create new ones here)
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

  // CAMERA: shift the world so the player lands in the middle of the screen
  pushMatrix();
  translate(width/2 - p1.x, height/2 - p1.y);
  maze.display(p1.x, p1.y);
  p1.display();
  popMatrix();

  // Startscreen / UI (drawn after popMatrix so it stays fixed on screen)
  if (isStarted == false) {
    image(startScreen, width/2, height/2);
  } else {
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
  if (mouseX > 200 && mouseY > 207 && mouseX < 525 && mouseY < 333) {
    if (isStarted == false) {
      isStarted = true;
      mazegenerate();   // fresh maze when the game starts
    }
  }
}
