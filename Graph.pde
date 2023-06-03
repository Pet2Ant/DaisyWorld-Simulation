void createGraph(String graphName, int wDaisies, int bDaisies, int grayArea, float temp, int posX, int posY) {
  int daisies = wDaisies + bDaisies;
  int coveredArea = daisies;
  GPointsArray points = new GPointsArray(coveredArea);

  for (int i = 0; i < coveredArea; i++) {
    float yValue = 0;
    switch (graphName) {
      case "White Daisies":
        yValue = i < wDaisies ? 1 : 0;
        break;
      case "Black Daisies":
        yValue = i < bDaisies ? 1 : 0;
        break;
      case "Gray Area":
        yValue = i < grayArea ? 1 : 0;
        break;
    }
    points.add(temp, yValue);
  }

  GPlot plot = new GPlot(this, posX, posY, 400, 300); // creates a new plot and set position and size on the screen

  // Labels
  plot.setTitleText(graphName);
  plot.getXAxis().setAxisLabelText("Temperature");
  plot.getYAxis().setAxisLabelText(graphName);

  switch (graphName) {
    case "White Daisies":
      plot.setPointColor(color(255, 255, 255));
      break;
    case "Black Daisies":
      plot.setPointColor(color(0, 0, 0));
      break;
    case "Gray Area":
      plot.setPointColor(color(128, 128, 128));
      break;
  }

  plot.setPoints(points); // Add the points

  // Draw the graph
  plot.beginDraw();
  plot.drawBackground();
  plot.drawBox();
  plot.drawXAxis();
  plot.drawYAxis();
  plot.drawTitle();
  plot.drawPoints();
  plot.endDraw();
}
