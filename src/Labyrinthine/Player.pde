// McKay Essig
class Player{
  // Member Variables
  int x,y,w,h,health;
  PImage p1;

// Constructor
Player(int x, int y) {
  this.x = x;
  this.y = y;
  w = 50 
  h = 50
  health = 100;
  p1 = loadImage("")
}

  // Member Methods 
  void display() {
//TODO: replce rectangle with PImage
// image(p1,x,y)
fill(222,44,63);
rect(x,y,w,h);

  }
  void move() {}
  void attack() {}
  void Jump() {}

}
