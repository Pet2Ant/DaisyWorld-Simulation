// Daisy class
class Daisy {

  // Define variables
  color c;
  // change temp to albedo
  float albedo;
  int age;
  int daisyType;

  // Constructor for the Daisy class
  Daisy(int daisyType, float albedo) {
    // Set the color to white or black depending on the daisyType
    // create daisy albedo if black=0.75, if white 0.25
    if( daisyType == 0)
    { 
      this.c = white;
      this.albedo =albedo;
    }else
    {
      this.c = black;
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
    fill(c);
    circle(x+ size/2, y + size/2, size);
  }
  
      /**
     * setters and getters
     */
    public void setColor(int c) {
        	this.c= c;
        }
    
    public int getColor() {
        	return this.c;
        }
    
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
        
