class DaisyWorld {
  float temperature;
  int numDaisies;
  Daisy[] whiteDaisies;
  Daisy[] blackDaisies;

  DaisyWorld(int numDaisies) {
    this.temperature = 0.5;
    this.numDaisies = numDaisies;
    this.whiteDaisies = new Daisy[numDaisies];
    this.blackDaisies = new Daisy[numDaisies];


    for (int i = 0; i < numDaisies; i++) {
      float x = random(width);
      float y = random(height);
      int c = (int) random(2);
      if (c >= 1) {
        c = color(255);
      } else {
        c = color(0);
      };
      float size = random(10, 30);
      whiteDaisies[i] = new Daisy(x, y, c, 0.5, size);
    }
  }

  void update() {
    float albedo = 0;
    for (Daisy daisy : whiteDaisies) {
      albedo += 0.75;
    }
    albedo /= numDaisies;
    temperature = 1 - (0.75 * albedo);

    for (Daisy daisy : whiteDaisies) {
      daisy.temp = temperature;
      if (temperature < 0.4 && daisy.c == color(255)) {
        daisy.c = color(0);
      } else if (temperature > 0.5 && daisy.c == color(0)) {
        daisy.c = color(255);
      }
    }
  }

  void draw() {
    background(255);
    for (Daisy daisy : whiteDaisies) {
      daisy.draw();
    }
  }
}
