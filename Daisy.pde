// Daisy class
class Daisy {
  // Define variables
  PImage img;
  // change temp to albedo
  float albedo;
  int age;
  int daisyType;

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

  //5 parametrous gia na kanei initialize to kosmo , tiny small medium large xL
  // black daisies zoun kalitera s xamiles
  // white daisies se ipsiles


  void draw(float x, float y) {
    // Draw a circle.
    imageMode(CENTER);
    image(img, x + size / 2, y + size / 2, size, size);

  }

  // setters and getters

  public void setAge(int age) {
    this.age = age;
  }


  }

  // setters and getters

  public void setAge(int age) {
    this.age = age;
  }


  public int getAge() {
    return this.age;
  }

  public void setAlbedo(float albedo) {
    this.albedo = albedo;
  }

  public float getAlbedo() {
    return this.albedo;
  }

}

