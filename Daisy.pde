// Daisy class
class Daisy {
  // Define variables
  color c;
  float temp;
  float size;
  int age;
  int daisyType;

  // Constructor for the Daisy class
  Daisy(int daisyType) {
    // Set the color to white or black depending on the daisyType
    this.c = daisyType == 0 ? white : black;
    // Set the temperature to 0.5, the size to the width divided by the number of rows, and the age to 0
    this.temp = 0.5;
    this.size = width / rows;
    this.age = 0;
    // Set the daisyType to the given daisyType
    this.daisyType = daisyType;
  }

  void draw(float x, float y) {
    // Draw a circle.
    fill(c);
    circle(x + size/2, y + size/2, size);
  }
}