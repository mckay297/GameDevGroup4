// McKay Essig
class Player {
  // Member Variables
  int x, y, w, h, health;
  char pDir;
  Gif picon;
  PImage swordImg;

  // Attack Variables
  boolean isAttacking;
  int attackTimer;
  int attackDuration = 10; // Frames the swing lasts
  float attackAngle = 0;   // Stores the direction toward the mouse click

  // Constructor
  Player(int x, int y, PApplet parent) {
    this.x = x;
    this.y = y;
    w = 50;
    h = 50;
    health = 100;
    pDir = 'r';
    isAttacking = false;
    attackTimer = 0;
    
    picon = new Gif(parent, "Theseus.gif");
    swordImg = loadImage("sword.png");
  }

  // Member Methods
  void display() {
    imageMode(CENTER);
    image(picon, x, y, 42, 64);

    // Render sword attack animation when attacking
    if (isAttacking) {
      drawSwordSwing();
      
      attackTimer--;
      if (attackTimer <= 0) {
        isAttacking = false;
      }
    }
  }

  // Start the attack action facing a specific angle (in radians)
  void attack(float targetAngle) {
    if (!isAttacking) {
      isAttacking = true;
      attackTimer = attackDuration;
      attackAngle = targetAngle;
    }
  }

  // Draws and animates the 90x90 swinging sword aimed toward the mouse click
  void drawSwordSwing() {
    pushMatrix();
    translate(x, y + 10); 
    
    rotate(attackAngle);
    
    float swingOffset = map(attackTimer, attackDuration, 0, -radians(60), radians(60));
    rotate(swingOffset);
    
    if (swordImg != null) {
      imageMode(CENTER);
      image(swordImg, 45, 0, 90, 90);
    } else {
      stroke(255, 215, 0);
      strokeWeight(4);
      line(0, 0, 50, 0);
    }
    popMatrix();
    
    noStroke();
  }

  // Checks if a target is within sword reach
  boolean checkHit(int targetX, int targetY, int reach) {
    return dist(this.x, this.y, targetX, targetY) <= reach;
  }

  void move() {}
  void Jump() {}
}
