// McKay Essig
class Player {
  // Member Variables
  int x, y, w, h, health;
  PImage p1;
  PImage swordImg; // Sword image variable

  // Attack Variables
  boolean isAttacking;
  int attackTimer;
  int attackDuration = 10; // Frames the swing lasts

  // Constructor
  Player(int x, int y) {
    this.x = x;
    this.y = y;
    w = 42;
    h = 64;
    health = 100;
    isAttacking = false;
    attackTimer = 0;
    p1 = loadImage("Theseus.png");
    swordImg = loadImage("sword.png");
  }

  // Member Methods 
  void display() {
    imageMode(CENTER);
    if (p1 != null) {
      image(p1, x, y, w, h);
    } else {
      fill(222, 44, 63);
      rectMode(CENTER);
      rect(x, y, w, h);
    }

    // Render sword attack animation when attacking
    if (isAttacking) {
      drawSwordSwing();
      
      attackTimer--;
      if (attackTimer <= 0) {
        isAttacking = false;
      }
    }
  }

  // Start the attack action
  void attack() {
    if (!isAttacking) {
      isAttacking = true;
      attackTimer = attackDuration;
    }
  }

  // Draws and animates the swinging sword sprite from Theseus' hand
  void drawSwordSwing() {
    pushMatrix();
    // Shifted down (+15 pixels on Y) to line up with Theseus' hand level
    translate(x + 15, y + 15); 
    
    // Rotate the sword from -60 to +60 degrees during the attack duration
    float angle = map(attackTimer, attackDuration, 0, -radians(60), radians(60));
    rotate(angle);
    
    if (swordImg != null) {
      imageMode(CENTER);
      // Sword resized to 90x90 and offset forward from pivot point
      image(swordImg, 40, 0, 90, 90); 
    } else {
      stroke(255, 215, 0);
      strokeWeight(4);
      line(0, 0, 45, 0);
    }
    popMatrix();
  }

  void move() {}
  void Jump() {}
}
