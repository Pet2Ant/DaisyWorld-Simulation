void createGraph(String graphName,int l, int posX, int posY) {
  switch(l) {
  case 0:
  // get size of the arrays to create the graph
  int numPoints = wDaisy.size();
  int numPoints2 =bDaisy.size();
  // Create an array to store the points
  GPointsArray points = new GPointsArray(numPoints);
  GPointsArray points2 = new GPointsArray(numPoints2);
  // get the points needed for the graphs 
  for (int i = 0; i < numPoints; i++) {
    float xValue = time.get(i);
    float y1Value = wDaisy.get(i);
    points.add(xValue,y1Value);
  }
  for (int j = 0; j < numPoints2; j++) {
    float xValue = time.get(j);
    float y2Value = bDaisy.get(j);
    points2.add(xValue,y2Value);
  }
  // new plot for the graph 
  GPlot plot = new GPlot(this, posX, posY, 450, 300); // Create a plot and set its position and size on the screen

  // Labels
  plot.setTitleText(graphName);
  plot.getXAxis().setAxisLabelText("Time in years");
  plot.getYAxis().setAxisLabelText("Daisy Amount");

  // Set the color based on the graph name
  int pointColor = color (255,0, 0); // Darker shade of yellow for white daisies
  int pointColor2 = color(0, 0, 0); // Black color for black daisies
  plot.addLayer("Set 1",points);
  plot.addLayer("Set 2",points2);
  
  
  // Set the point color for each layer
  plot.getLayer("Set 1").setLineColor(pointColor);
  plot.getLayer("Set 2").setLineColor(pointColor2);
  plot.setPoints(points,"Set 1"); // Add the points
  plot.setPoints(points2,"Set 2");
  // Draw the graph
  plot.beginDraw();
  plot.drawBackground();
  plot.drawBox();
  plot.drawXAxis();
  plot.drawYAxis();
  plot.drawTitle();
  plot.drawLines(); // Connect the points with lines
  plot.endDraw();
  break;
  case 1:
  int numPoints3 =globalTemp.size();
  GPointsArray points3 = new GPointsArray(numPoints3);// Create an array to store the points
  for (int k= 0; k< numPoints3; k++) {
    float xValue = time.get(k);
    float yValue = globalTemp.get(k);
    points3.add(xValue,yValue);
  }


  GPlot plot2 = new GPlot(this, posX, posY, 450, 300); // Create a plot and set its position and size on the screen

  // Labels
  plot2.setTitleText(graphName);
  plot2.getXAxis().setAxisLabelText("Time in years");
  plot2.getYAxis().setAxisLabelText("Temperature in Celcius");

  // Set the color based on the graph name
  int pointColor3 = color (0,0, 0); // Darker shade of yellow for white daisies
  plot2.addLayer("Set 3",points3);
  // Set the point color for each layer
  plot2.getLayer("Set 3").setLineColor(pointColor3);
  plot2.setPoints(points3,"Set 3"); // Add the points
 
  // Draw the graph
  plot2.beginDraw();
  plot2.drawBackground();
  plot2.drawBox();
  plot2.drawXAxis();
  plot2.drawYAxis();
  plot2.drawTitle();
  plot2.drawLines(); // Connect the points with lines
  plot2.endDraw();
  break;
  case 2:
  int numPoints4 = wDaisyGrowth.size();
  int numPoints5 = bDaisyGrowth.size();
  GPointsArray points4 = new GPointsArray(numPoints4);
  GPointsArray points5 = new GPointsArray(numPoints5);
  for (int k= 0; k< numPoints4; k++) {
    float xValue = globalTemp.get(k);
    float y1Value = wDaisyGrowth.get(k);
    points4.add(xValue,y1Value);
  }
  for (int k= 0; k< numPoints4; k++) {
    float xValue = globalTemp.get(k);
    float y2Value = bDaisyGrowth.get(k);
    points5.add(xValue,y2Value);
  }


  GPlot plot3 = new GPlot(this, posX, posY, 450, 300); // Create a plot and set its position and size on the screen

  // Labels
  plot3.setTitleText(graphName);

  plot3.getXAxis().setAxisLabelText("Temperature");

  plot3.getYAxis().setAxisLabelText("Daisy growth rate");

  // Set the color based on the graph name
  int pointColor4 = color (0,0,0); 
  int pointColor5 = color (255,0, 0);
  plot3.addLayer("Set 4",points4);
  plot3.addLayer("Set 5",points5);
  // Set the point color for each layer
  plot3.getLayer("Set 4").setLineColor(pointColor4);
  plot3.getLayer("Set 5").setLineColor(pointColor5);
  plot3.setPoints(points4,"Set 4"); 
  plot3.setPoints(points5,"Set 5"); 
  
 
  // Draw the graph
  plot3.beginDraw();
  plot3.drawBackground();
  plot3.drawBox();
  plot3.drawXAxis();
  plot3.drawYAxis();
  plot3.drawTitle();
  plot3.drawLines(); // Connect the points with lines
  plot3.endDraw();
  break;
  }
}
