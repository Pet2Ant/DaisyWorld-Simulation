// Grid class
class Grid {
  Cell[][] grid;
  float globalTemperature;

  // Create a new grid with the given number of rows and columns.
  Grid(int rows, int cols) {
    grid = new Cell[rows][cols];
    globalTemperature = 0.5;
    // For each cell in the grid, create a new cell with a daisy in it
    // with 2/3 probability. Otherwise, create a cell with no daisy.
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        int daisyType = int(random(3));
        if (daisyType < 2) {
          grid[i][j] = new Cell(i * size, j * size, new Daisy(daisyType));
        } else {
          grid[i][j] = new Cell(i * size, j * size, null);
        }
      }
    }
  }

void draw() {
  // Draw each tile in the grid.
  for (int row = 0; row < rows; row++) {
    for (int col = 0; col < cols; col++) {
      grid[row][col].draw();
    }
  }
}

void update() {
  // Initialize newGrid and update daisy ages
  // Create a new grid of cells
  Cell[][] newGrid = new Cell[rows][cols];
  for (int row = 0; row < rows; row++) {
    for (int col = 0; col < cols; col++) {
      Cell cell = grid[row][col];

      // If the cell has a daisy, age it
      if (cell.daisy != null) {
        cell.daisy.age++;
      }

      // Copy the cell to the new grid
      Cell newCell = new Cell(row * size, col * size, cell.daisy);
      newGrid[row][col] = newCell;
    }
  }

  // Update grid with the new state
  grid = newGrid;

  // Check for reproduction and death
 // Iterate through each cell in the grid
for (int i = 0; i < rows; i++) {
  for (int j = 0; j < cols; j++) {
    // Check if there is a daisy in the cell
    if (grid[i][j].daisy != null) {
      // Daisy dies if it reaches maximum age (20)
      if (grid[i][j].daisy.age >= 20) {
        grid[i][j].daisy = null;
      } else {
        // Reproduction
        int emptyNeighbors = countEmptyNeighbors(i, j);
        if (emptyNeighbors > 0 && random(1) < 0.1) { // 10% reproduction chance
          int target = int(random(emptyNeighbors));
          int counter = 0;

          // Iterate through each neighboring cell
          for (int di = -1; di <= 1; di++) {
            for (int dj = -1; dj <= 1; dj++) {
              int ni = i + di;
              int nj = j + dj;

              // Check if neighboring cell is within the grid
              // and if it is not the current cell
              if (ni >= 0 && ni < rows && nj >= 0 && nj < cols && (di != 0 || dj != 0)) {
                // Check if neighboring cell is empty
                if (grid[ni][nj].daisy == null) {
                  // Check if counter is the randomly chosen target
                  if (counter == target) {
                    // Reproduce
                    grid[ni][nj].daisy = new Daisy(grid[i][j].daisy.daisyType);
                  }
                  counter++;
                }
              }
            }
          }
        }
      }
    }
  }
}
}

int countEmptyNeighbors(int i, int j) {
  int count = 0;

  // Iterate over all neighbors.
  for (int di = -1; di <= 1; di++) {
    for (int dj = -1; dj <= 1; dj++) {
      // Calculate neighbor's indices.
      int ni = i + di;
      int nj = j + dj;

      // Check that neighbor is on the board and is not the current cell.
      if (ni >= 0 && ni < rows && nj >= 0 && nj < cols && (di != 0 || dj != 0)) {
        // Count neighbor if it is empty.
        if (grid[ni][nj].daisy == null) {
          count++;
        }
      }
    }
  }

  return count;
}
}