// David Madden
import gifAnimation.*; 

class Boss { 
  int x, y, health;
  int p;
  Gif loopingGif; 

  Boss(int x, int y, PApplet parent) { 
    this.x = x;
    this.y = y;
    this.health = 1000;
    this.p = 0;
    
    this.loopingGif = new Gif(parent, "Minotaurinthemaze.gif");
    this.loopingGif.loop(); 
  }

  void display() {
    if (loopingGif != null) {
      imageMode(CENTER);
      image(loopingGif, x, y, 500, 500); 
    }
  }
}
