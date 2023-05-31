import controlP5.*;

// Constants
int rows = 10;
int cols = 10;
float size = 80;
color white = color(255);
color black = color(0);
color gray = color(200);

// Variables for the sliders
int temperature;
float planetAlbedo, daisyAlbedo;

// Global variables
Grid grid;
ControlP5 cp5;

boolean simulationStarted = false;

void setup() {
  size(800, 1000);
  grid = new Grid(rows, cols);  
  cp5 = new ControlP5(this);
  
  // Sliders
  cp5.addSlider("temperature")
     .setPosition(0,850)
     .setRange(5,45)
     .setValue(25)
     .setLabel("Temperature");
     
  cp5.addSlider("planetAlbedo")
     .setPosition(0,860)
     .setRange(0.0, 1.0)
     .setValue(0.5)
     .setLabel("Planet Albedo (%)");
     
  cp5.addSlider("wdaisyAlbedo")
     .setPosition(0,870)
     .setRange(0.0, 1.0)
     .setValue(0.5)
     .setLabel("White Daisy Albedo (%)");
     
  cp5.addSlider("bdaisyAlbedo")
     .setPosition(0,880)
     .setRange(0.0, 1.0)
     .setValue(0.5)
     .setLabel("Black Daisy Albedo (%)");
     
  cp5.addSlider("whiteDaises")
     .setPosition(0,890)
     .setRange(0.0, 1.0)
     .setValue(0.5)
     .setLabel("White daises amount");
     
   cp5.addSlider("blackDaises")
     .setPosition(0,890)
     .setRange(0.0, 1.0)
     .setValue(0.5)
     .setLabel("Black daises amount");
     
     
  // Button that calls the startSimulation() function
  cp5.addButton("keyPressed")
     .setPosition(110, 960)
     .setLabel("Update Simulation");
     
  cp5.addButton("startSimulation")
     .setPosition(10, 960)
     .setLabel("Start Simulation");
}

void draw() {
  background(135, 206, 235); // Light blue background
  //text("Temperature: " + temperature, 200, 70);
  //text("Planet Albedo: " + planetAlbedo + "%", 200, 110);
  //text("Daisy Albedo: " + daisyAlbedo + "%", 200, 150);
  grid.draw();
}

//void startSimulation(){

  
//  exit(); //Closes the UI and switches to the simulation
  
//  simulationStarted = true;
   //DaisyWorld simulation code here...
   //background(135, 206, 235); // Light blue background
  
//}

void keyPressed(){
  if(key == 't' || key == 'T'){
    grid.update();
  }
}
