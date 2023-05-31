// Daisy class
class Daisy {
    //Define variables
    private color c;
    //change temp to albedo
    private float albedo;
    private float size;
    private int age;
    private boolean isValid;
    private int daisyType;
    private int minTemp;
    private int maxTemp;
    
    //Constructor for the Daisy class
    Daisy(int daisyType, float temperature) {
        this.isValid = true;
        this.minTemp = 17;
        this.maxTemp = 29;
        // Set the color to white or black depending on the daisyType
        // create daisy albedo if black=0.75, if white 0.25
        if (daisyType == 0)
        { 
            this.c= white;
            this.albedo = 0.75;
        } else
        {
            this.c= black;
            this.albedo = 0.25;
        }
        
        // Check temperature condition
        if (temperature < minTemp || temperature > maxTemp) {
            this.isValid = false;
        }   
        
        // the size to the width divided by the number of rows, and the age to 0
        this.size = width / rows;
        this.age = 0;
        // Set the daisyType to the given daisyType
        this.daisyType = daisyType;
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
    
    public void setSize(float size) {
        this.size = size;
}
    
    public float getSize() {
        return this.size;
}

    public void setValid(boolean isValid) {
        this.isValid = isValid;
}

    public boolean getValid() {
        return this.isValid;
}

    public void setMinTemp(int minTemp) {
        this.minTemp = minTemp;
}

    public int getMinTemp() {
        return this.minTemp;
}

    public void setMaxTemp(int maxTemp) {
        this.maxTemp = maxTemp;
}

    public int getMaxTemp() {
        return this.maxTemp;
}

    // Draw the daisy
    void draw(float x, float y) {
        // Draw a circle.
        fill(c);
        circle(x + size / 2, y + size / 2, size);
}
}
