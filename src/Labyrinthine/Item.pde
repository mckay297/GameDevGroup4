// Marz Meyer
class Item {
  // Member variables
  int x, y, w, h;
  char itemType;
  PImage itemIcon;
  int healAmount = 25; // Restores 25 HP

  // Constructor
  Item(int x, int y, char itemType) {
    this.x = x;
    this.y = y;
    this.w = 45;
    this.h = 45;
    this.itemType = itemType;
    if (itemType == 'p') {
      itemIcon = loadImage("potion.png");
    } else {
      itemIcon = loadImage("sword.png");
    }
  }

  // Member Methods
  void display() {
    if (itemIcon != null) {
      imageMode(CENTER);
      image(itemIcon, x, y, w, h);
    }
  }

  // Returns true if picked up and heals the player
  boolean checkPickup(Player p) {
    if (itemType == 'p' && p.health < 100 && dist(this.x, this.y, p.x, p.y) < 45) {
      p.health = min(100, p.health + healAmount);
      return true;
    }
    return false;
  }

  void fire() {}
}
