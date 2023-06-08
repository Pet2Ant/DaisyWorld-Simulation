import javax.swing.JFrame;
import javax.swing.SwingUtilities;
import grafica.*;
import controlP5.*;

// Initialization of global variables 

PImage earthImage;
PImage whiteDaisyImage;
PImage blackDaisyImage;
float timeCounter =0.0;
ArrayList<Float> wDaisy = new ArrayList<>();
ArrayList<Float> wDaisyGrowth = new ArrayList<>();
ArrayList<Float> bDaisy = new ArrayList<>();
ArrayList<Float> bDaisyGrowth = new ArrayList<>();
ArrayList<Float>  grayAreaArrLi = new ArrayList<>();
ArrayList<Float> globalTemp = new ArrayList<>();
ArrayList<Float> time = new ArrayList<>();
// init of grid cols rows size buttons and sliders
int rows;
int cols ;
float size ;
color gray = color(0, 0, 0, 100);
color updateButtonSimulationHoverColor = color(11, 57, 138);
color updateButtonSimulationBackgroundColor = color(11, 36, 141);
color updateButtonActiveColor = color(11, 67, 158);
float Arr[];
int previousState = 0;
// Variables for the sliders
boolean updating=false;
int totalSpots = 100;
int temperature;
float planetAlbedo, daisyAlbedo;
Slider slider1, slider2, slider3, slider4, slider5, slider6, worldSlider, daisiesSlider, grayAreaSlider;
ArrayList<Slider> sliders;
Button button1, button2, button3, button4, button5;
// Global variables
Grid grid;
PFont captionFont;

ControlP5 cp5;
int currentScreen = 0;

// setup method , sliders and buttons creation
void setup() {
  size(1400, 1000);
  surface.setTitle("DaisyWorld Simulation");
  cp5 = new ControlP5(this);
  captionFont = createFont("Arial", 16);
  // sim images
  whiteDaisyImage = loadImage("white.png");
  blackDaisyImage = loadImage("black.png");
  earthImage = loadImage("earth.png");
  //app icon 
  addIcon();
   CustomSliderView view = new CustomSliderView();
  // Sliders
  
  // initial screen
  // we changed how the initial sliders worked and made them look a bit more "modern"
  //by adding the customersliderview 
  slider1 = cp5.addSlider("temp")
    .setPosition(50, 10)
    .setRange(5, 45)
    .setSize(width-300, 20)
    .setValue(25)
    .setLabel("Temperature")
    .setView(view);
  slider1.getCaptionLabel().setFont(captionFont);
  slider1.getValueLabel().setFont(captionFont).setColor(color(255));

  slider2 = cp5.addSlider("pAlbedo")
    .setPosition(50, 60)
    .setRange(0.25, 0.75)
    .setSize(width-300, 20)
    .setValue(0.5)
    .setLabel("Planet Albedo (%)")
    .setView(view);
  slider2.getCaptionLabel().setFont(captionFont);
  slider2.getValueLabel().setFont(captionFont).setColor(color(255));

  slider3 = cp5.addSlider("whiteDaisyAlbedo")
    .setPosition(50, 110)
    .setRange(0.25, 0.75)
    .setSize(width-300, 20)
    .setValue(0.5)
    .setLabel("White Daisy Albedo (%)")
    .setView(view);
  slider3.getCaptionLabel().setFont(captionFont);
  slider3.getValueLabel().setFont(captionFont).setColor(color(0));

  slider4 = cp5.addSlider("blackDaisyAlbedo")
    .setPosition(50, 160)
    .setRange(0.25, 0.75)
    .setSize(width-300, 20)
    .setValue(0.5)
    .setLabel("Black Daisy Albedo (%)")
    .setView(view);
  slider4.getCaptionLabel().setFont(captionFont);
  slider4.getValueLabel().setFont(captionFont).setColor(color(255));

  slider5 = cp5.addSlider("Luminosity")
    .setPosition(50, 210)
    .setRange(0, 2)
    .setSize(width-300, 20)
    .setValue(1)
    .setNumberOfTickMarks(3)
    .snapToTickMarks(false)
    .setLabel("SOLAR FLUX")
    .setView(view); // Modify active slider color
  slider5.getCaptionLabel().setFont(captionFont);
  slider5.getValueLabel().setFont(captionFont).setColor(color(255));

  slider6 = cp5.addSlider("Death rate")
    .setPosition(50, 260)
    .setRange(0, 0.3)
    .setSize(width-300, 20)
    .setValue(0.15)
    .setLabel("Virus Death Rates")
    .setView(view);
  slider6.getCaptionLabel().setFont(captionFont);
  slider6.getValueLabel().setFont(captionFont).setColor(color(255));


  worldSlider = cp5.addSlider("WORLD SIZE")
    .setPosition(50, 310)
    .setRange(0, 4)
    .setSize(width-300, 20)
    .setNumberOfTickMarks(5)
    .setValue(2)
    .snapToTickMarks(false)
    .setLabelVisible(false)
    .setView(view);
  worldSlider.getCaptionLabel().setFont(captionFont);
  worldSlider.getValueLabel().setFont(captionFont).setColor(color(15, 1, 130));




  grayAreaSlider = cp5.addSlider("Uncovered Land")
    .setPosition(50, 360)
    .setRange(0, 1)
    .setSize(width-300, 20)
    .setValue(0.5)
    .setColorBackground(color(128, 65, 0))
    .setColorForeground(color(163, 82, 0)) // Modify slider color
    .setColorActive(color(196, 99, 0)) // Modify active slider color
    .setView(view);
  grayAreaSlider.getCaptionLabel().setFont(captionFont);
  grayAreaSlider.getValueLabel().setFont(captionFont).setColor(color(255));



  daisiesSlider = cp5.addSlider("BLACK TO WHITE RATIO")
    .setPosition(50, 410)
    .setRange(0, 1)
    .setSize(width-300, 20)
    .setValue(0.5)
    .setView(view); // Set custom view
  daisiesSlider.getCaptionLabel().setFont(captionFont) // Modify font and font size
    .toUpperCase(true); // Convert caption text to uppercase


  //Buttons that update or start the simulation
  //added callback methods to update the simulation as needed 
  button1 = cp5.addButton("gridUpdate")
    .setPosition(100, height - 60)
    .setSize(240, 30)
    .setValue(0)
    .setLabel("Update Simulation")
    .activateBy(ControlP5.RELEASE)
    .setColorForeground(updateButtonSimulationHoverColor)
    .setColorBackground(updateButtonSimulationBackgroundColor)
    .setColorActive(updateButtonActiveColor);
  button1.getCaptionLabel().setFont(createFont("Arial", 16)); // Modify font and font size
  button1.addCallback(new CallbackListener() {
    void controlEvent(CallbackEvent event) {
      if (event.getAction() == ControlP5.RELEASE) {
        button1Callback();
      }
    }
  }
  );
  // start sim button, callback method that fills a global float array with the users world initialization
  button2 = cp5.addButton("startSimulation")
    .setPosition(width/4, height/2 -30)
    .setLabel("Start Simulation")
    .setSize(width/2, 30)
    .setValue(1)
    .activateBy(ControlP5.RELEASE)
    .setColorForeground(color(85))
    .setColorBackground(color(100, 100, 100)) // Change the starting color of the button
    .setColorActive(color(70)); // Modify active slider color
  button2.getCaptionLabel().setFont(createFont("Arial", 16)).toUpperCase(true); // Modify font and font size
  button2.addCallback(new CallbackListener() {
    void controlEvent(CallbackEvent event) {
      if (event.getAction() == ControlP5.RELEASE) {
        button2Callback();
      }
    }
  }
  );
  // different simulation update buttons 10x, 50x and 100x timeflow 
  button3 = cp5.addButton("updateSimulationX10")
    .setPosition(480, height - 60)
    .setSize(240, 30)
    .setValue(0)
    .setLabel("Update Simulation x 10")
    .activateBy(ControlP5.RELEASE)
    .setColorForeground(updateButtonSimulationHoverColor)
    .setColorBackground(updateButtonSimulationBackgroundColor)
    .setColorActive(updateButtonActiveColor);
  button3.getCaptionLabel().setFont(createFont("Arial", 16)); // Modify font and font size
  button3.addCallback(new CallbackListener() {
    void controlEvent(CallbackEvent event) {
      if (event.getAction() == ControlP5.RELEASE) {
        button3Callback();
      }
    }
  }
  );

  button4 = cp5.addButton("updateSimulationX50")
    .setPosition(100, height - 140)
    .setSize(240, 30)
    .setValue(0)
    .setLabel("Update Simulation x 50")
    .activateBy(ControlP5.RELEASE)
    .setColorForeground(updateButtonSimulationHoverColor)
    .setColorBackground(updateButtonSimulationBackgroundColor)
    .setColorActive(updateButtonActiveColor);
  button4.getCaptionLabel().setFont(createFont("Arial", 16)); // Modify font and font size
  button4.addCallback(new CallbackListener() {
    void controlEvent(CallbackEvent event) {
      if (event.getAction() == ControlP5.RELEASE) {
        button4Callback();
      }
    }
  }
  );

  button5 = cp5.addButton("updateSimulationX100")
    .setPosition(480, height - 140)
    .setSize(240, 30)
    .setValue(0)
    .setLabel("Update Simulation x 100")
    .activateBy(ControlP5.RELEASE)
    .setColorForeground(updateButtonSimulationHoverColor)
    .setColorBackground(updateButtonSimulationBackgroundColor)
    .setColorActive(updateButtonActiveColor);
  button5.getCaptionLabel().setFont(createFont("Arial", 16)); // Modify font and font size
  button5.addCallback(new CallbackListener() {
    void controlEvent(CallbackEvent event) {
      if (event.getAction() == ControlP5.RELEASE) {
        button5Callback();
      }
    }
  }
  );
}

// Override default tick mark labels, with strings containing the needed values
void drawCurrentValueLabel() {
  final String[] letters = { "XS", "S", "M", "L", "XL" };
  int index = (int) worldSlider.getValue();
  String label = (index >= 0 && index < letters.length) ? letters[index] : "";

  pushStyle();
  fill(255);
  textAlign(LEFT, TOP);
  textSize(18);
  text(label, 50 + worldSlider.getWidth() / 20 - 95, 275);
  popStyle();
}

// draw method drawing initial screen and simulation screen depending on the var currentScreen which changes from a method 
// when the start sim button is pressed, initial and final sliders along with instructions
void draw() {
  background(50);
  switch(currentScreen) {
  case 0:
    drawCurrentValueLabel();
    slider1.show();
    slider2.show();
    slider3.show();
    slider4.show();
    slider5.show();
    slider6.show();
    button2.show();
    worldSlider.show();
    grayAreaSlider.show();
    daisiesSlider.show();
    // Instructions
    pushStyle();
    textSize(20);
    textAlign(CENTER, CENTER);
    fill(255);
    String instructions1 =
      "•  Temperature: You can set the temperature from 5°C to 45°C. \n  - This doesn't matter that much,since it will change accordingly\n\n" +
      "•  Planet Albedo: You can set the planet's albedo from 0.25 to 0.75.\n  - Set value to 0.5 for a proper simulation\n\n" +
      "•  White Daisy Albedo %: You can set the white daisy's albedo from 0.25 to 0.75. \n  - Set value to 0.75 for a proper simulation\n\n" +
      "•  Black Daisy Albedo %: You can set the black daisy's albedo from 0.25 to 0.75. \n  - Set value to 0.25 for a proper simulation";

    String instructions2 = "•  Solar Flux: You can set the luminosity of the sun from low to high.\n  - Set value to mid for a proper simulation\n\n" +
      "•  Virus Death Rates: You can set the virus death rates from 0.00 to 0.30. \n  - Set value to 0.3 for a proper simulation\n\n" +
      "•  World Size: You can set the world size of the simulation from 4 different sizes. \n  - Choose a size of your own preference\n\n" +
      "•  Uncovered Land: You can set the uncovered land ratio, from 0.00 to 1.00. \n  - Choose a size of your own preference\n\n";

    text("Instructions for proper use:", width / 2, height / 2 + 30 );
    text(instructions1, width / 4, height / 1.5 + 140);
    text(instructions2, width - 350, height / 1.5 + 170);
    text("•  Black to White Ratio: You can set the ratio of Black to White daisies, from 0.00 to 1.00. \n  - Choose a ratio of your own preference\n\n", width / 2, height / 2 + 110);
    popStyle();
    button1.hide();
    button3.hide();
    button4.hide();
    button5.hide();
    previousState = currentScreen;
    break;
  case 1:
    background(earthImage);
    fill(2, 93, 163);
    rect(0, 820, 1400, 1000);
    fill(2, 119, 209);
    rect(820, 0, 1400, 1000);
    if (previousState == 0 && currentScreen == 1)
    {
      Arr =  button2Callback();
      grid = new Grid(rows, cols, Arr);
    }
    // graph creation for daisies / year, temp/year and daisy growth rate depending on temp
    createGraph("Daisies over the years(Black = Black line, White = Red line)", 0, width-550, height-990); // 0 gray 1white 2black
    createGraph("Temperature over time", 1, width-550, height-680); //
    createGraph("Growth rate over temp(Black = Black line, White = Red line)", 2, width-550, height-370);
    previousState = 1;
    button2.hide();
    slider1.hide();
    slider6.hide();
    slider5.hide();
    slider2.hide();
    slider3.hide();
    slider4.hide();
    worldSlider.hide();
    grayAreaSlider.hide();
    daisiesSlider.hide();
    button1.show();
    button3.show();
    button4.show();
    button5.show();
    grid.draw();
    break;
  }
}

// call back functions for the buttons
// floatarray fills with users input when screen 1 is reached
// switch case for the size of the world depending on user input and initialization of the grid
float[] button2Callback()
{
  if (button2.isMouseOver()) {
    if (currentScreen == 0) {
      currentScreen = 1;
      int i = int(worldSlider.getValue());
      chooseSize(i);
    }
  }

  float[] floatArray = new float[8];
  floatArray[0] = slider1.getValue(); //temperature
  floatArray[1] = slider2.getValue(); // planet Albedo
  floatArray[2] = slider3.getValue(); //white Albedo
  floatArray[3] = slider4.getValue();//black Albedo
  floatArray[4] = grayAreaSlider.getValue();//uncovered to covered area ratio 
  floatArray[5] = daisiesSlider.getValue(); // black to white daisy  ratio
  floatArray[6] = slider5.getValue(); // solar flux constant from user input mid/low/high 
  floatArray[7] = slider6.getValue(); // death rate from user input
  return floatArray;
}
// update the grid buttons 
// update the grid, add the values needed for the graphs such as daisy amount 
// global temp and time depending on simulation steps 
void button1Callback()
{
  if (currentScreen == 1) grid.update();
  int[] count = grid.getCount();
  wDaisy.add(float(count[1]));
  bDaisy.add(float(count[2]));
  grayAreaArrLi.add(float(count[0]));
  globalTemp.add(grid.getGlobalTemperature());
  timeCounter++;
  time.add(timeCounter);
  wDaisyGrowth.add(grid.getGrowthRate(0));
  bDaisyGrowth.add(grid.getGrowthRate(1));
  println(grid.getGlobalTemperature());
}



void button3Callback() {
  if (currentScreen == 1) {
    for (int i = 0; i < 10; i++) {
      grid.update();
      int[] count = grid.getCount();
      wDaisy.add(float(count[1]));
      bDaisy.add(float(count[2]));
      grayAreaArrLi.add(float(count[0]));
      globalTemp.add(grid.getGlobalTemperature());
      timeCounter++;
      time.add(timeCounter);
      wDaisyGrowth.add(grid.getGrowthRate(0));
      bDaisyGrowth.add(grid.getGrowthRate(1));
      println(grid.getGlobalTemperature());
    }
  }
}

void button4Callback() {
  if (currentScreen == 1) {
    for (int i = 0; i < 50; i++) {
      grid.update();
      int[] count = grid.getCount();
      wDaisy.add(float(count[1]));
      bDaisy.add(float(count[2]));
      grayAreaArrLi.add(float(count[0]));
      globalTemp.add(grid.getGlobalTemperature());
      timeCounter++;
      time.add(timeCounter);
      wDaisyGrowth.add(grid.getGrowthRate(0));
      bDaisyGrowth.add(grid.getGrowthRate(1));
      println(grid.getGlobalTemperature());
    }
  }
}

void button5Callback() {
  if (currentScreen == 1) {
    for (int i = 0; i < 100; i++) {
      grid.update();
      int[] count = grid.getCount();
      wDaisy.add(float(count[1]));
      bDaisy.add(float(count[2]));
      grayAreaArrLi.add(float(count[0]));
      globalTemp.add(grid.getGlobalTemperature());
      timeCounter++;
      time.add(timeCounter);
      wDaisyGrowth.add(grid.getGrowthRate(0));
      bDaisyGrowth.add(grid.getGrowthRate(1));
      println(grid.getGlobalTemperature());
    }
  }
}


// choose size switch case, by changing grid rows and cols and size of each daisy
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
