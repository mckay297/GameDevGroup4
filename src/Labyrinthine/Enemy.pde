// Connor DeWeerd
class Enemy {
  // Member Variables
  int x, y, w, h, health;
  float attackRange;
  boolean isAttacking;
  int attackCooldown;
  Gif idleAnim, attackAnim, currentAnim;

  // Constructor
  Enemy(int x, int y, Gif idleAnim, Gif attackAnim) {
    this.x = x;
    this.y = y;
    this.w = 100;
    this.h = 100;
    this.health = 100;
    this.attackRange = 140; // Distance in pixels to switch to attack animation
    this.isAttacking = false;
    this.attackCooldown = 0;

    this.idleAnim = idleAnim;
    this.attackAnim = attackAnim;
    this.currentAnim = idleAnim;
  }

  // Member Methods
  void update(Player p, MazeGen maze) {
    if (attackCooldown > 0) {
      attackCooldown--;
    }

    float d = dist(x, y, p.x, p.y);
    if (d <= attackRange) {
      isAttacking = true;
      currentAnim = attackAnim;
      attack(p, d);
    } else {
      isAttacking = false;
      currentAnim = idleAnim;
      move(p, maze, d);
    }
  }

  void display() {
    imageMode(CENTER);
    image(currentAnim, x, y, 125, 125);
  }

  void move(Player p, MazeGen maze, float d) {
    if (d < 260 && d > attackRange) {
      int step = 2;
      int dx = (p.x > x) ? step : (p.x < x ? -step : 0);
      int dy = (p.y > y) ? step : (p.y < y ? -step : 0);
      if (!maze.hitsWall(x + dx, y)) x += dx;
      if (!maze.hitsWall(x, y + dy)) y += dy;
    }
  }

  void attack(Player p, float d) {
    if (d < 60 && attackCooldown == 0) {
      p.health = max(0, p.health - 10);
      attackCooldown = 30;
    }
  }

  void Jump() {}
}
