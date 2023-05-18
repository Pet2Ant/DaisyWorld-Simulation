// Daisy class
class Daisy {
  // Define variables
  color c;
  // change temp to albedo
  float albedo;
  float size;
  int age;
  int daisyType;

  // Constructor for the Daisy class
  Daisy(int daisyType) {
    // Set the color to white or black depending on the daisyType
    // create daisy albedo if black=0.75, if white 0.25
    if( daisyType == 0)
    { 
      this.c = white;
      this.albedo =0.75;
    }else
    {
      this.c = black;
      this.albedo = 0.25;
    }
    // the size to the width divided by the number of rows, and the age to 0
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
