// Made by McKay Essig, David Madden, Marz Meyer, Connor Deweerd
import gifAnimation.*;
Player p1;
Boss minotaur;
MazeGen maze;
ArrayList<Enemy> enemies;
int px, py;
float speed, stamina;
boolean upPressed, downPressed, leftPressed, rightPressed, sprinting, isStarted;
PImage startScreen;
PImage guiOverlay;
Gif gifRest, gifUp, gifDown, gifLeft, gifRight;
Gif snakeIdle, snakeAttack;

void setup() {
  isStarted = false;
  size(1080, 720);
  frameRate(30);
  speed = 3;
  stamina = 100;
  startScreen = loadImage("Labyrinthine.png");
  guiOverlay = loadImage("GUI.png");
  p1 = new Player(width/2, height/2, this);
  minotaur = new Boss(0, 0, this);

  gifRest  = new Gif(this, "Theseus.gif");
  gifUp    = new Gif(this, "TheseusBak.gif");
  gifDown  = new Gif(this, "TheseusFwd.gif");
  gifLeft  = new Gif(this, "TheseusLeft.gif");
  gifRight = new Gif(this, "TheseusRight.gif");

  // Preload snake idle and attack animations once
  snakeIdle   = new Gif(this, "snakeIdle.gif");
  snakeAttack = new Gif(this, "snakeAttack.gif");
  snakeIdle.loop();
  snakeAttack.loop();

  enemies = new ArrayList<Enemy>();
  mazegenerate();
}

// Builds a new random maze and puts the player at the start, Minotaur in the center, and snakes along paths
void mazegenerate() {
  maze = new MazeGen(25, 25, 80);   // 25x25 cells, 80px per tile
  maze.generate();
  p1.x = int(maze.startX());
  p1.y = int(maze.startY());
  minotaur.x = int(maze.centerX());
  minotaur.y = int(maze.centerY());
  minotaur.health = 1000;

  // Spawn snakes randomly along open floor tiles
  enemies.clear();
  int midX = maze.gw / 2;
  int midY = maze.gh / 2;

  for (int gx = 1; gx < maze.gw - 1; gx++) {
    for (int gy = 1; gy < maze.gh - 1; gy++) {
      boolean isStart    = (gx == 1 && gy == 1);
      boolean isExit     = (gx == maze.gw - 2 && gy == maze.gh - 2);
      boolean isBossRoom = (abs(gx - midX) <= 1 && abs(gy - midY) <= 1);
      if (isStart || isExit || isBossRoom) continue;

      if (maze.grid[gx][gy] == 0 && random(1) < 0.06) {
        int spawnX = int((gx + 0.5) * maze.tile);
        int spawnY = int((gy + 0.5) * maze.tile);
        enemies.add(new Enemy(spawnX, spawnY, snakeIdle, snakeAttack));
      }
    }
  }
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

    // Update snakes (switches to attack animation when player gets near)
    for (int i = enemies.size() - 1; i >= 0; i--) {
      Enemy e = enemies.get(i);
      if (e.health <= 0) {
        enemies.remove(i);
      } else {
        e.update(p1, maze);
      }
    }

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
  for (Enemy e : enemies) {
    e.display();
  }
  if (minotaur.health > 0) {
    minotaur.display();
  }
  p1.display();
  popMatrix();

  // Startscreen / UI (drawn after popMatrix so it stays fixed on screen)
  if (isStarted == false) {
    image(startScreen, width/2, height/2);
  } else {
    noStroke();
    image(guiOverlay, width/2, height/2, width, height);
    fill(256, 0, 0);
    rect(500, 83, p1.health*1.75, 45);
    fill(0, 256, 0);
    rect(500, 20, stamina*1.75, 40);
  }
}

// Keybinds
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
  if (!upPressed && !downPressed && !leftPressed && !rightPressed) {
    p1.pDir = 'r';
  }
}

void mousePressed() {
  println("mouseX," + mouseX + "mouseY," + mouseY);
  
  if (isStarted == false) {
    // Check start button bounds
    if (mouseX > 200 && mouseY > 207 && mouseX < 525 && mouseY < 333) {
      isStarted = true;
      mazegenerate();   // fresh maze when the game starts
    }
  } else {
    // Left Click to swing sword toward the mouse cursor
    if (mouseButton == LEFT) {
      float angleToMouse = atan2(mouseY - height/2, mouseX - width/2);
      p1.attack(angleToMouse);
      
      // Deal 50 damage if the Minotaur is within 250 pixels
      if (minotaur.health > 0 && p1.checkHit(minotaur.x, minotaur.y, 250)) {
        minotaur.health -= 50;
        println("Minotaur hit! Health: " + minotaur.health);
      }

      // Deal 50 damage to any snake within 110 pixels
      for (Enemy e : enemies) {
        if (e.health > 0 && p1.checkHit(e.x, e.y, 110)) {
          e.health -= 50;
          println("Snake hit! Health: " + e.health);
        }
      }
    }
  }
}
