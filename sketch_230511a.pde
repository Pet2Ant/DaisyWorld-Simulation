// Constants
int rows = 10;
int cols = 10;
float size = 80;
color white = color(255);
color black = color(0);
color gray = color(200);

// Global variables
Grid grid;

void setup() {
  size(800, 800);
  grid = new Grid(rows, cols);
}

void draw() {
  background(135, 206, 235); // Light blue background
  grid.draw();
}

void keyPressed() {
  if (key == 't' || key == 'T') {
    grid.update();
  }
}