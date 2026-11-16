// Marz Meyer
class Item {
  // Member variables
  int x, y, w, h;
  char itemType;
  PImage itemIcon;

  // Constructor
  Item(int x, int y, char itemType) {
    this.x = x;
    this.y = y;
    this.w = 40;
    this.h = 40;
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

  void fire() {}
}
