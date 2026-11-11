// McKay Essig
class MazeGen {
  // Member Variables
  int cols, rows;     // maze size in cells
  int gw, gh;         // grid size in tiles (2*cells + 1)
  int tile;           // size of one tile in pixels
  int[][] grid;       // 1 = wall, 0 = floor

  // Constructor
  MazeGen(int cols, int rows, int tile) {
    this.cols = cols;
    this.rows = rows;
    this.tile = tile;
    gw = cols * 2 + 1;
    gh = rows * 2 + 1;
    grid = new int[gw][gh];
  }

  // Builds a new random maze (recursive backtracker, no recursion)
  void generate() {
    for (int x = 0; x < gw; x++) {
      for (int y = 0; y < gh; y++) {
        grid[x][y] = 1;
      }
    }

    ArrayList<int[]> stack = new ArrayList<int[]>();
    grid[1][1] = 0;
    stack.add(new int[] {1, 1});

    int[][] dirs = {{0, -2}, {2, 0}, {0, 2}, {-2, 0}};

    while (stack.size() > 0) {
      int[] cur = stack.get(stack.size() - 1);

      // find unvisited neighbors two tiles away
      ArrayList<int[]> options = new ArrayList<int[]>();
      for (int[] d : dirs) {
        int nx = cur[0] + d[0];
        int ny = cur[1] + d[1];
        if (nx > 0 && ny > 0 && nx < gw - 1 && ny < gh - 1 && grid[nx][ny] == 1) {
          options.add(new int[] {nx, ny, d[0] / 2, d[1] / 2});
        }
      }

      if (options.size() == 0) {
        stack.remove(stack.size() - 1);   // dead end, backtrack
      } else {
        int[] pick = options.get(int(random(options.size())));
        grid[cur[0] + pick[2]][cur[1] + pick[3]] = 0;  // knock down wall between
        grid[pick[0]][pick[1]] = 0;                    // carve new cell
        stack.add(new int[] {pick[0], pick[1]});
      }
    }

    // knock out a few extra walls so there are loops, not just one path
    int extras = cols * rows / 12;
    for (int i = 0; i < extras; i++) {
      int x = int(random(1, gw - 1));
      int y = int(random(1, gh - 1));
      // only walls that sit between two cells
      if ((x % 2 == 1) != (y % 2 == 1)) {
        grid[x][y] = 0;
      }
    }
  }

  // Is this tile a wall? (outside the maze counts as wall)
  boolean isWall(int tx, int ty) {
    if (tx < 0 || ty < 0 || tx >= gw || ty >= gh) return true;
    return grid[tx][ty] == 1;
  }

  // Player hitbox: a 28x28 box around the player's feet.
  // Pass in the player's x/y (sprite center).
  boolean hitsWall(float px, float py) {
    float half = 14;
    float cy = py + 16;
    return isWall(floor((px - half) / tile), floor((cy - half) / tile)) ||
           isWall(floor((px + half) / tile), floor((cy - half) / tile)) ||
           isWall(floor((px - half) / tile), floor((cy + half) / tile)) ||
           isWall(floor((px + half) / tile), floor((cy + half) / tile));
  }

  // World position of the start cell (top-left)
  float startX() { 
    return tile * 1.5;
  }
  float startY() { 
    return tile * 1.5;
  }

  // Has the player reached the exit (bottom-right cell)?
  boolean atExit(float px, float py) {
    return floor(px / tile) == gw - 2 && floor(py / tile) == gh - 2;
  }

  // Draws only the tiles the camera can see. Call inside the camera translate.
  void display(float camX, float camY) {
    int x0 = max(0, floor((camX - width / 2) / tile));
    int x1 = min(gw - 1, floor((camX + width / 2) / tile));
    int y0 = max(0, floor((camY - height / 2) / tile));
    int y1 = min(gh - 1, floor((camY + height / 2) / tile));

    noStroke();
    for (int x = x0; x <= x1; x++) {
      for (int y = y0; y <= y1; y++) {
        if (grid[x][y] == 1) {
          fill(60, 50, 45);          // wall
        } else if (x == gw - 2 && y == gh - 2) {
          fill(230, 200, 60);        // exit
        } else {
          fill(150, 140, 125);       // floor
        }
        rect(x * tile, y * tile, tile, tile);
      }
    }
  }
}
