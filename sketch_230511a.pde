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
Slider slider1,slider2,slider3,slider4,slider5,slider6,slider8,slider9,slider10,slider11;
Button slider7,slider12;
// Global variables
Grid grid;
ControlP5 cp5;
int currentScreen = 0;


void setup() {
    size(800, 1000);
    grid = new Grid(rows, cols);  
    cp5 = new ControlP5(this);
    
    //  // Sliders
    
     slider1 = cp5.addSlider("temperature")
       .setPosition(0,850)
       .setRange(5,45)
       .setValue(25)
       .setLabel("Temperature");
    
     slider2 = cp5.addSlider("planetAlbedo")
       .setPosition(0,860)
       .setRange(0.0, 1.0)
       .setValue(0.5)
       .setLabel("Planet Albedo (%)");
    
     slider3 = cp5.addSlider("wdaisyAlbedo")
       .setPosition(0,870)
       .setRange(0.0, 1.0)
       .setValue(0.5)
       .setLabel("White Daisy Albedo (%)");
    
    slider4 = cp5.addSlider("bdaisyAlbedo")
       .setPosition(0,880)
       .setRange(0.0, 1.0)
       .setValue(0.5)
       .setLabel("Black Daisy Albedo (%)");
    
    slider5 = cp5.addSlider("whiteDaises")
       .setPosition(0,890)
       .setRange(0.0, 1.0)
       .setValue(0.5)
       .setLabel("White daises amount");
    
    slider6 = cp5.addSlider("blackDaises")
       .setPosition(0,890)
       .setRange(0.0, 1.0)
       .setValue(0.5)
       .setLabel("Black daises amount");
    
    
    //Button that calls the startSimulation() function
    slider7 =  cp5.addButton("keyPressed")
       .setPosition(110, 960)
       .setValue(0)
       .setLabel("Update Simulation")
       .activateBy(ControlP5.RELEASE);
    
    slider8 = cp5.addSlider("temp")
       .setPosition(50, 50)
       .setRange(5, 45)
       .setValue(0)
       .setLabel("Temperature");
    
    slider9 = cp5.addSlider("pAlbedo")
       .setPosition(50, 90)
       .setRange(0.0, 1.0)
       .setValue(0.5)
       .setLabel("Planet Albedo (%)");
    
    slider10 = cp5.addSlider("whiteDaisyAlbedo")
       .setPosition(50, 130)
       .setRange(0.0, 1.0)
       .setValue(0.5)
       .setLabel("Daisy Albedo (%)");
    slider11 = cp5.addSlider("blackDaisyAlbedo")
       .setPosition(50, 170)
       .setRange(0.0, 1.0)
       .setValue(0.5)
       .setLabel("Daisy Albedo (%)");
    //Button that calls the startSimulation() function
   slider12 = cp5.addButton("startSimulation")
       .setPosition(50, 210)
       .setLabel("Start Simulation")
       .setValue(0)
       .activateBy(ControlP5.RELEASE);
}





void draw() {
    background(0, 0, 255); // Blue background
    switch(currentScreen) {
        case 0:   
            slider8.show();
            slider9.show();
            slider10.show();
            slider11.show();
            slider12.show();
            slider1.hide();
            slider2.hide();
            slider3.hide();
            slider4.hide();
            slider5.hide();
            slider6.hide();
            slider7.hide();
            break;
        case 1:
            slider8.hide();
            slider9.hide();
            slider10.hide();
            slider11.hide();
            slider12.hide();
            slider1.show();
            slider2.show();
            slider3.show();
            slider4.show();
            slider5.show();
            slider6.show();
            slider7.show();
            grid.draw();
            break;
    }
    
} 
//void drawIntro() {  
//    textAlign(CENTER, CENTER);
//    textSize(32);  
//}
//void drawSimulation() {
//    textAlign(CENTER, CENTER);
    
//}


public void keyPressed(int value) {
    grid.update();
}
void mousePressed() {
  if (slider12.isMouseOver()) {
    if (currentScreen == 0) {
      currentScreen = 1;
    } 
  }
}
