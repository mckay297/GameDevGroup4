// Connor DeWeerd
class Enemy{
  // Member Variables
    int x,y,w,h,health;
    PImage e1;

  // Constructor
    Enemy(int x, int y){
      this.x = x;
      this.y = y;
      w = 50
      h = 50
      health = 100
      e1 = loadImage("")
      
      {"modelVersion":2,"piskel":{"name":"New Piskel","description":"","fps":12,"height":75,"width":75,"layers":["{\"name\":\"Layer 1\",\"opacity\":1,\"frameCount\":1,\"chunks\":[{\"layout\":[[0]],\"base64PNG\":\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEsAAABLCAYAAAA4TnrqAAACeklEQVR4AeyWoVJcQRBFJ6m4CGx+Ij4iNjomNiI+nxMfERuDxiLw/AQ/gKMK5gz0Vu/CVnFZanqAS73e7tdzHzt93t3d977579EEDOvRqFozLMMSCAhSO8uwBAKC1M4yLIGAILWzDEsgIEjtLMMSCAhSO+v1wxImfEapnSXANCzDEggIUjvLsAQCgtTOeoGwrvue90VfWuNYwVlAar9PvrZf/75s5TtEY/2uLk0rwBqQoPDx0wdSiwy80VjkZQlYweLPt9NRRh4nC70sASucxEcRNpGjT2+FWAIWTtoXK0CKPawA6x2bwU3EydHR+JKnpt9jrPdcfhwM68AJ+KW7TmA2/w6nbU4WKaphDRddXlwNHN9/nLfj/58beTRuXwbQXkbuZc1RCYvhx9TxRQ4oGpFxXA7WenAd0cu5RyWsLVfF2LiMjyCQco+aHkHdYzqwUlh94PEACiBqcriMcyL3qOklYJxOi3JYAAhAkZkedxF/f541Mj3W0VNXRDksAOwOjnNysB6QHtKzPiNKYYVjAsS+DLhKSHEjKmFtHjYDRM6Ai3NqNhw5INObGZWw7s0ZMFgIULmml0BtYKOZEeWw0vDjlzGGzuCil/J0ULx3NawxNMBysDFcRCZ21+hVRDUsZgZYjvGo8ACgLQ0Xzo4VYO3OnKHkeld3yPmTrl0R1pMGmXGRYQmUDcuwBAKC1M4yLIGAILWzDEsgIEjtLMMSCAhSO8uwBAKC1M56UbCEzVZL7SzhDhiWYQkEBKmdZVgCAUFqZxmWQECQ2lmGJRAQpHaWYQkEBKmdZVgCAUGanSVc9jalhiXcd8MyLIGAILWzDEsgIEjtLAHWDQAAAP//1ll99AAAAAZJREFUAwBCHLCXGO0JkwAAAABJRU5ErkJggg==\"}]}"],"hiddenFrames":[]}}
    }
  // Member Methods
    void display() {
      fill(222,44,63);
      rect(x,y,w,h);

    }
    void move();
    void attack();
    void fire();
    void jump();



}
