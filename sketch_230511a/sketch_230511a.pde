static final int rows = 10;
static final int cols = 10;
int[][] grid;
int size;
static final int WHITEDAISY = 0;
static final int BLACKDAISY = 1;
static final int NODAISY = 2;

final color white = #FFFFFF;
final color black = #000000;
final color gray = #777777;
final color blue = #051FFA;

void setup() {
  size(800, 800);
  grid =new int[rows][cols];
  for (int i=0; i<rows; i++) {
    for (int j=0; j<cols; j++) {
      grid[i][j] = int(random(3));
    }
  }
  size = width/rows;
}

void draw() {
  background(blue);
  for (int i=0; i<rows; i++) {
    for (int j=0; j<cols; j++) {
      if (grid[i][j] == WHITEDAISY) {
        fill(white);
      } else if (grid[i][j] == BLACKDAISY) {
        fill(black);
      } else {
        fill(gray);
      }
      pushMatrix();
      translate(size/2+i*size, size/2+j*size);
      circle(0, 0, size);
      popMatrix();
    }
  }
}

void keyPressed(){
    
}
