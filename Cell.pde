// Cell class
class Cell {
  float x, y;
  Daisy daisy;
  // Constructor.
  Cell(float x, float y, Daisy daisy) {
    this.x = x; // x-coordinate of the cell
    this.y = y; // y-coordinate of the cell
    this.daisy = daisy; // the daisy that this cell contains
  }

 private void draw() {
    // If a Daisy is available, draw it.
    if (daisy != null) {
      daisy.draw(x, y);
    } else {
      // Otherwise, draw a gray circle.
      fill(gray);
      circle(x + size/2, y + size/2, size);
    }
  }
}
