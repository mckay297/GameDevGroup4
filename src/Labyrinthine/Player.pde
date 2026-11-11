// McKay Essig
class Player {
  // Member Variables
  int x, y, w, h, health;
  char pDir;
  Gif picon;

  // Constructor
  Player(int x, int y, PApplet parent) {
    this.x = x;
    this.y = y;
    w = 50;
    h = 50;
    health = 100;
    picon = new Gif(parent, "Theseus.gif");
    
  }

  // Member Methods
  void display() {
    //TODO: replce rectangle with PImage
    image(picon, x, y, 42, 64);
    //fill(222,44,63);
    //rect(x,y,w,h);
  }
  void move() {
  }
  void attack() {
  }
  void Jump() {
  }
}
