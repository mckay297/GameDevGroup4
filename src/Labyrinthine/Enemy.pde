// Connor DeWeerd
class Enemy{
  // Member Variables
    int x,y,w,h,health;
    PImage e1;

  // Constructor
    Enemy(int x, int y){
      this.x = x;
      this.y = y;
      w = 50;
      h = 50;
      health = 100;
      e1 = loadImage("enemy.pde");
    
    }
  // Member Methods
    void display() {
      fill(222,44,63);
      rect(x,y,w,h);

    }
    void move(){}
    void attack(){}
    void fire(){}
    void jump(){}
}



}
