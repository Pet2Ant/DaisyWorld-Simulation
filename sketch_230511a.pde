import grafica.*;
import controlP5.*;

// Constants
PImage earthImage;
PImage whiteDaisyImage;
PImage blackDaisyImage;
int counter =0;
int rows;
int cols ;
float size ;
color white = color(255);
color black = color(0);
color gray = color(0, 0 ,0, 100);
float Arr[];
int previousState = 0;
// Variables for the sliders
boolean updating=false;
int totalSpots = 100;
int temperature;
float planetAlbedo, daisyAlbedo;
Slider slider1, slider2, slider3, slider4, slider5, slider6, slider7, slider8, slider9, slider10, worldSlider, daisiesSlider, grayAreaSlider;
ArrayList<Slider> sliders;
Button button1, button2, button3;
// Global variables
Grid grid;

ControlP5 cp5;
int currentScreen = 0;


void setup() {
  size(1400, 1000);
  cp5 = new ControlP5(this);
  whiteDaisyImage = loadImage("white.png");
  blackDaisyImage = loadImage("black.png");
  earthImage = loadImage("earth.png");

  //  // Sliders

  slider1 = cp5.addSlider("temperature")
    .setPosition(50, height - 160)
    .setRange(5, 45)
    .setSize(200, 20)
    .setValue(25)
    .setLabel("Temperature");

  slider2 = cp5.addSlider("planetAlbedo")
    .setPosition(450, height - 160)
    .setRange(0.0, 1.0)
    .setSize(200, 20)
    .setValue(0.5)
    .setLabel("Planet Albedo (%)");

  slider3 = cp5.addSlider("wdaisyAlbedo")
    .setPosition(50, height - 130)
    .setRange(0.0, 1.0)
    .setSize(200, 20)
    .setValue(0.5)
    .setLabel("White Daisy Albedo (%)");

  slider4 = cp5.addSlider("bdaisyAlbedo")
    .setPosition(450, height - 130)
    .setRange(0.0, 1.0)
    .setSize(200, 20)
    .setValue(0.5)
    .setLabel("Black Daisy Albedo (%)");

  slider5 = cp5.addSlider("whiteDaises")
    .setPosition(50, height - 100)
    .setRange(0.0, 1.0)
    .setSize(200, 20)
    .setValue(0.5)
    .setLabel("White daises amount");

  slider6 = cp5.addSlider("blackDaises")
    .setPosition(450, height - 100)
    .setRange(0.0, 1.0)
    .setSize(200, 20)
    .setValue(0.5)
    .setLabel("Black daises amount");



  button1 =  cp5.addButton("gridUpdate")
    .setPosition(100, height - 40 )
    .setSize(120, 30)
    .setValue(0)
    .setLabel("Update Simulation")
    .activateBy(ControlP5.RELEASE);
  button1.addCallback(new CallbackListener() {
    void controlEvent(CallbackEvent event) {
      if (event.getAction() == ControlP5.RELEASE) {
        button1Callback();
      }
    }
  }
  );
  //Button that updates the simulation

  // initial screen
  slider7 = cp5.addSlider("temp")
    .setPosition(50, 50)
    .setRange(5, 45)
    .setSize(width-300, 20)
    .setValue(0)
    .setLabel("Temperature");

  slider8 = cp5.addSlider("pAlbedo")
    .setPosition(50, 90)
    .setRange(0.0, 1.0)
    .setSize(width-300, 20)
    .setValue(0.5)
    .setLabel("Planet Albedo (%)");

  slider9 = cp5.addSlider("whiteDaisyAlbedo")
    .setPosition(50, 130)
    .setRange(0.0, 1.0)
    .setSize(width-300, 20)
    .setValue(0.5)
    .setLabel("White Daisy Albedo (%)");
  slider10 = cp5.addSlider("blackDaisyAlbedo")
    .setPosition(50, 170)
    .setRange(0.0, 1.0)
    .setSize(width-300, 20)
    .setValue(0.5)
    .setLabel("Black Daisy Albedo (%)");
  worldSlider = cp5.addSlider("Choose a world size")
    .setPosition(50, 210)
    .setRange(0, 4)
    .setSize(width-300, 20)
    .setNumberOfTickMarks(5)
    .setValue(0);
  grayAreaSlider = cp5.addSlider("How much land would you like to leave uncovered?")
    .setPosition(50, 250)
    .setRange(0, 1)
    .setSize(width-300, 20)
    .setValue(0.5);
  daisiesSlider = cp5.addSlider("black to white daisy ratio")
    .setPosition(50, 290)
    .setRange(0, 1)
    .setSize(width-300, 20)
    .setValue(0.5);

  //Button that calls the startSimulation() function
  button2 = cp5.addButton("startSimulation")
    .setPosition(width/4, height/2)
    .setLabel("Start Simulation")
    .setSize(width/2, 30)
    .setValue(1)
    .activateBy(ControlP5.RELEASE);
  button2.addCallback(new CallbackListener() {
    void controlEvent(CallbackEvent event) {
      if (event.getAction() == ControlP5.RELEASE) {
        button2Callback();
      }
    }
  }
  );

  button3 = cp5.addButton("updateSimulationX10")
    .setPosition(width - 200, height - 40 )
    .setSize(120, 30)
    .setValue(0)
    .setLabel("Update Simulation x 10")
    .activateBy(ControlP5.RELEASE);
  button3.addCallback(new CallbackListener() {
    void controlEvent(CallbackEvent event) {
      if (event.getAction() == ControlP5.RELEASE) {
        button3Callback();
      }
    }
  }
  );
}







void draw() {
background(50);
  switch(currentScreen) {
  case 0:
    slider7.show();
    slider8.show();
    slider9.show();
    slider10.show();
    button2.show();
    worldSlider.show();
    grayAreaSlider.show();
    daisiesSlider.show();
    slider1.hide();
    slider2.hide();
    slider3.hide();
    slider4.hide();
    slider5.hide();
    slider6.hide();
    button1.hide();
    button3.hide();
    previousState = currentScreen;
    break;
  case 1:
  background(earthImage);
    if (previousState == 0 && currentScreen == 1)
    {
      Arr =  button2Callback();
      grid = new Grid(rows, cols, Arr);
    }
    int[] count = grid.getCount();
    float temp = grid.getGlobalTemperature();
    createGraph("White Daisies", count[1], count[2], count[0], temp, width-550, height-990); // 0 gray 1white 2black
    createGraph("Black Daisies", count[1], count[2], count[0], temp, width-550, height-680); // void createGraph(String graphName, int wDaisies, int bDaisies, int grayArea, float temp, int posX, int posY)
    createGraph("Temperature", count[1], count[2], count[0], temp, width-550, height-370);

    previousState = 1;
    button2.hide();
    slider7.hide();
    slider8.hide();
    slider9.hide();
    slider10.hide();
    worldSlider.hide();
    grayAreaSlider.hide();
    daisiesSlider.hide();
    slider1.show();
    slider2.show();
    slider3.show();
    slider4.show();
    slider5.show();
    slider6.show();
    button1.show();
    button3.show();
    grid.draw();
    break;
  }
}


float[] button2Callback()
{
  if (button2.isMouseOver()) {
    if (currentScreen == 0) {
      currentScreen = 1;
      int i = int(worldSlider.getValue());
      chooseSize(i);
    }
  }

  float[] floatArray = new float[6];
  floatArray[0] = slider7.getValue(); //temp
  floatArray[1] = slider8.getValue(); // pAlbedo
  floatArray[2] = slider9.getValue(); //wAlbedo
  floatArray[3] = slider10.getValue();//bAlbedo
  floatArray[4] = grayAreaSlider.getValue();//grayArea
  floatArray[5] = daisiesSlider.getValue(); // b to w ratio
  return floatArray;
}

void button1Callback()
{
  if (currentScreen == 1) grid.update();
}

void button3Callback() {
  if (currentScreen == 1) {
    for (int i = 0; i < 10; i++) {
      grid.update();
    }
  }
}



public void chooseSize(int i)
{
  switch (i) {
  case 0:
    rows = 5;
    cols = 5;
    size = 800/5;
    break;
  case 1:
    rows = 10;
    cols = 10;
    size = 800/10;
    break;
  case 2:
    rows = 15;
    cols = 15;
    size = 800/15;
    break;
  case 3:
    rows = 20;
    cols = 20;
    size = 800/20;
    break;
  case 4:
    rows = 25;
    cols = 25;
    size = 800/25;
    break;
  }
}
