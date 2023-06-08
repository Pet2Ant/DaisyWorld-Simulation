// Daisy class
class Daisy {
  // Define variables
  private PImage img;
  private float albedo;
  private int age;
  private int daisyType;

  // Constructor for the Daisy class
  Daisy(int daisyType, float albedo) {
    // Set the color to white or black depending on the daisyType
    // create daisy albedo if black=0.75, if white 0.25
    if ( daisyType == 0)
    {
      this.img = whiteDaisyImage;
      this.albedo = albedo;
    } else
    {
      this.img = blackDaisyImage;
      this.albedo = albedo;
    }
    // the size to the width divided by the number of rows, and the age to 0
    this.age = 0;
    // Set the daisyType to the given daisyType
    this.daisyType = daisyType;
  }

private void draw(float x, float y) {
    // Draw a circle.
    imageMode(CENTER);
    image(img, x + size / 2, y + size / 2, size, size);
  }
}
