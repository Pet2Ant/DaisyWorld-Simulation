// Grid class
class Grid {
  Cell[][] grid;
  //initialize worldAlbedo =0.5
  // initialize globaltemp 20
  float globalTemperature;
  float worldAlbedo;

  // Create a new grid with the given number of rows and columns.
  Grid(int rows, int cols) {
    grid = new Cell[rows][cols];
    // globalTemperature = (16,172,839,506*(1-Ap))pow(0.25) - 273;
    worldAlbedo = 0.5;
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
// to do ui 
// user able to initialize global temp , initialize black and white daisies amount, 
//initialize albedo
//luminosity of the sun sun grows? bigger light? but recommended values for proper experiment shown
// graph growth rate white/black daises + uncovered area,graph planet temperature 
//scalable graphs
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
    int [] count = daisyCounter(rows, cols);
    System.out.print("gray area count"+count[0]+"\n");
    System.out.print("w area count"+count[1]+"\n");
    System.out.print("b area count"+count[2]+"\n");
    System.out.print("Size is"+size);
    
    float pAlbedo = calcPlanetAlbedo(calculateSurface(size, count[0] ), calculateSurface(size, count[1]), calculateSurface(size, count[2]), worldAlbedo, 0.25, 0.75);
    System.out.print("albedo is "+pAlbedo+"\n");
    float globalTemp = calcGlobalTemp(pAlbedo);
    System.out.print(globalTemp);
    // Update grid with the new state
    grid = newGrid;

    // Check for reproduction and death
    // Iterate through each cell in the grid
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        // Check if there is a daisy in the cell
        if (grid[i][j].daisy != null) {
          // Daisy dies if it reaches maximum age (20)
          // || (grid[i][j].daisy.daisytype == 0 & grid[i][j].daisy.temp =-10) || (grid[i][j].daisy.daisytype != 0 & grid[i][j].daisy.temp = 40)
          //if(globalTemp >=30 || globalTemp<=10 grid[i][j].daisy.daisytype != 0)
          if (grid[i][j].daisy.age >= 20) {
            grid[i][j].daisy = null;
          } else {
            int countNeighbours =  countNeighbours(i,j);
            // Reproduction
            //calc growthfactor float pAlbedo,float dAlbedo,float globalTemp calcGrowthRate
            //float growthFactW = calcGrowthRate(pAlbedo,0.75,globalTemp);
            //float growthFactB = calcGrowthRate(pAlbedo,0.25,globalTemp);
            //int  countNeighbours = countNeighbours(i, j);
            if (countNeighbours > 0 & random(1)<0.1) {
              int target = int(random(countNeighbours));
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

  // calc planet albedo for planet temperature
  float calcPlanetAlbedo(float surfaceU, float surfaceW, float surfaceB, float albedoU, float albedoW, float albedoB)
  {
    return surfaceU*albedoU+surfaceW*albedoW+surfaceB*albedoB;
  }
  float calculateSurface(float size, int number )
  {

    return (PI*pow(size/2, 2)*number)/(502654); 
  }

  //calc planet temperature
  float calcGlobalTemp(float pAlbedo)
  {
    long pholder = 16172839506L;
    float temporary = pholder*(1-pAlbedo);
    float temperature = pow(temporary, 0.25)- 273;
    return temperature;
  }

  //calc daisies + uncovered total surface
  
  int countNeighbours(int i, int j)
  {
    int count = 0;

    // Iterate over all neighbors.
    for (int di = -1; di <= 1; di++) {
      for (int dj = -1; dj <= 1; dj++) {
        // Calculate neighbor's indices.
        int ni = i + di;
        int nj = j + dj;

        // Check that neighbor is on the board and is not the current cell.
        if (ni >= 0 && ni < rows && nj >= 0 && nj < cols && (di != 0 || dj != 0)) {
          // Count neighbor if it is empty
          //arr[0]=empty, arr[1]= white,arr[2]=black
          if (grid[ni][nj].daisy == null)
          {
            count++;
          }
        }
      }
    }
    return count;
  }
  int[] daisyCounter(int row, int col)
  {
    int[] arr = new int[3];
    arr[0]=0;
    arr[1]=0;
    arr[2]=0;

    for (int i = 0; i < row; i++) {
      for (int j = 0; j < col; j++) {

        if (grid[i][j].daisy == null)
        {
          arr[0]++;
        }
        if (grid[i][j].daisy != null && grid[i][j].daisy.daisyType == 0)
        {
          arr[1]++;
        }
        if (grid[i][j].daisy != null && grid[i][j].daisy.daisyType != 0)
        {
          arr[2]++;
        }
      }
    }
    return arr;
  }
            //Black_Growth_fact = 1 -.003265*((22.5 - Temp_Black_Land)^2) {equation for a parabola}
            //White_Growth_fact = 1 - .003265*((22.5-Temp_White_Land)^2) {equation for a parabola}
            //Temp_Black_Land = heat_absorp_fact*(planetary_albedo - black_albedo)+Avg_Planet_Temp
            //Temp_White_Land = heat_absorp_fact*(planetary_albedo - white_albedo)+Avg_Planet_Temp
            //heat_absorp_fact = 20 {this controls how the local temperatures of the daisies differ from the average planetary temperature}
            // black growth rate, white growth rate
            // if white , white growth rate
            // else if( black growth rate,
  float calcGrowthRate(float pAlbedo,float dAlbedo,float globalTemp)
  {
    int hAfactor = 20;
    float temperature = hAfactor*(pAlbedo - dAlbedo)+ globalTemp;
    float growth_factor = 1-0.003265*(pow((22.5 - temperature),2));
    return growth_factor;
  }
}

