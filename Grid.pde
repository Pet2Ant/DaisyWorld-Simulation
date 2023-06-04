// Grid class
class Grid {
  Cell[][] grid;
  // initialize worldAlbedo =0.5
  // initialize globaltemp 20
  float globalTemperature = Arr[0];
  float worldAlbedo = Arr[1];
  float bAlbedo = Arr[3];
  float wAlbedo = Arr[2];
  float death_rate = Arr[7];
  int[] count = new int[3];
  int counterW;
  int counterB;
  int counterG;
  float growthFactW;
  float growthFactB;

  Grid(int rows, int cols, float Arr[])
  {
    grid = new Cell[rows][cols];
    counterW = 0;
    counterB  = 0;
    counterG = 0;


    int surface = rows*cols;
    int amOfGray = int(Arr[4]*surface);
    //println("amount of gray"+amOfGray);
    int amOfDaisies = surface - amOfGray;
    int amOfBlack = int(Arr[5]*amOfDaisies);
    //println("amount of black"+amOfBlack);
    int amOfWhite = amOfDaisies - amOfBlack;
    //println("amount of white"+amOfWhite);
    // Populate the grid with cells containing daisies or empty cells
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        // Calculate the cell position
        float cellX = i * size;
        float cellY = j * size;

        // Calculate the remaining counts for each daisy type
        int remainingWhite = amOfWhite - counterW;
        int remainingBlack = amOfBlack - counterB;
        int remainingGray = amOfGray - counterG;

        // Create an array of remaining daisy types and their counts
        int[][] remainingCounts = {
          {0, remainingWhite},
          {1, remainingBlack},
          {-1, remainingGray}
        };

        // Filter out daisy types that have reached their maximum counts
        ArrayList<int[]> availableTypes = new ArrayList<int[]>();
        for (int[] remainingCount : remainingCounts) {
          if (remainingCount[1] > 0) {
            availableTypes.add(remainingCount);
          }
        }

        // Randomly select a daisy type from the available types
        int selectedIndex = int(random(availableTypes.size()));
        int[] selectedType = availableTypes.get(selectedIndex);
        int daisyType = selectedType[0];

        // Create the appropriate daisy or empty cell based on daisyType and update counters
        if (daisyType == 0) {
          grid[i][j] = new Cell(cellX, cellY, new Daisy(daisyType, wAlbedo));
          counterW++;
        } else if (daisyType == 1) {
          grid[i][j] = new Cell(cellX, cellY, new Daisy(daisyType, bAlbedo));
          counterB++;
        } else {
          grid[i][j] = new Cell(cellX, cellY, null);
          counterG++;
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
    count = daisyCounter(rows, cols);

    float pAlbedo = calcPlanetAlbedo(calculateSurface(size, count[0]), calculateSurface(size, count[1]), calculateSurface(size, count[2]), worldAlbedo, 0.75, 0.25);
    globalTemperature = calcGlobalTemp(pAlbedo);
    growthFactW = calcGrowthRate(pAlbedo, wAlbedo, globalTemperature);
    growthFactB = calcGrowthRate(pAlbedo, bAlbedo, globalTemperature);
    float blackGrowth = calculateSurface(size, count[2])*(calculateSurface(size, count[0])*growthFactB - death_rate)+.001;
    float k =(calculateSurface(size, count[0])*growthFactW - death_rate);
    float whiteGrowth = (calculateSurface(size, count[1])*k)+.001;

    // Check for reproduction and death
    // Iterate through each cell in the grid
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        // Check if there is a daisy in the cell
        if (grid[i][j].daisy != null) {
          if (grid[i][j].daisy.age >= 20 || globalTemperature >= 45 || globalTemperature <=5 ) {
            grid[i][j].daisy = null;
          } else {
            int countNeighbours =  countNeighbours(i, j);

            // Reproduction
            // calc growthfactor

            // black i white >0
            // give priority to highest growthRate
            // blackGrowth > 0 || whiteGrowth > 0
            // 1 if pou kanei compare an to blackgrowth einai maeglaitero apo to whitegrowth kane produce black an einai megalitero apo random(0.1), kai meta nested 2ero if me whitegrowth>blackgrowth me ena random apo 0 eos 0.1 kai 3o
            if (countNeighbours > 0 && random(1) < 0.1) {
              int target = int(random(countNeighbours));
              int counter = 0;
              //generate daises regardless of existence based on temperature
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
                        if (blackGrowth>whiteGrowth)
                        {
                          grid[ni][nj].daisy = new Daisy(1, bAlbedo);
                        } else {
                          grid[ni][nj].daisy = new Daisy(0, wAlbedo);
                        }
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

  int[] getCount() {
    return count;
  }
  float getGrowthRate(int i)
  {
    switch(i) {
    case 0:
      return growthFactW;
    case 1:
      return growthFactB;
    }
    return -1.0;
  }


  // calc planet albedo for planet temperature
  float calcPlanetAlbedo(float surfaceU, float surfaceW, float surfaceB, float albedoU, float albedoW, float albedoB)
  {
    return surfaceU*albedoU+surfaceW*albedoW+surfaceB*albedoB;
  }
  float calculateSurface(float size, int number )
  {
    return ((PI*pow(size/2, 2)*number)/(502654))+0.001;
  }
  //pAnbedo min-max 0.25025-0.75075 . maxTemp 58.87, minTemp-20.84
  //calc planet temperature
  float calcGlobalTemp(float pAlbedo)
  {
    float S = -1.0;
    // add luminosity for user , give 3 options low , med , high
    switch(int(Arr[6])) {
    case 0:
      S =  760;
      break;
    case 1:
      S = 917;
      break;
    case 2:
      S = 1000;
      break;
    }
    float  L = 1;
    float stefan = 5.67*pow(10, -8);
    float pholder = (S*L)/stefan;
    float temporary = pholder*(1-pAlbedo);
    float temperature = pow(temporary, 0.25)- 273;
    return temperature;
  }


  public float getGlobalTemperature() {
    return globalTemperature;
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
  //all white 0.25025 , wGrate= -8.34 // bGrate = -5.24
  //
  float calcGrowthRate(float pAlbedo, float dAlbedo, float globalTemp)
  {
    int hAfactor = 20;
    float temperature = hAfactor*(pAlbedo - dAlbedo)+ globalTemp;
    float growth_factor = 1-0.003265*(pow((22.5 - temperature), 2));
    return growth_factor;
  }
}


//luminosity of the sun sun grows? bigger light? but recommended values for proper experiment shown