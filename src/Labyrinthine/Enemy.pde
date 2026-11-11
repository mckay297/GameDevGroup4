class Enemy{
  // Member Variables
  int x,y,w,h,health;
  PImage e1;

// Constructor
Enemy(int x, int y) {
  this.x = x;
  this.y = y;
  w = 100;
  h = 100;
  health = 100;
  e1 = loadImage("enemy.png");
}

  // Member Methods 
  void display() {
//TODO: replce rectangle with PImage
 image(e1,x,y,125,125);
//fill(222,44,63);
//rect(x,y,w,h);

  }
  void move() {}
  void attack() {}
  void Jump() {}

}
