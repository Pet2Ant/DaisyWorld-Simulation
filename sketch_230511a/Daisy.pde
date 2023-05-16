class Daisy {
  float x, y;
  color c;
  float temp;
  float size;
  
  Daisy(float x, float y, int c, float temp, float size) {
    this.x = x;
    this.y = y;
    this.c = c;
    this.temp = temp;
    this.size = size;
  }
  
  void draw() {
    fill(c);
    ellipse(x, y, size, size);
  }
}
