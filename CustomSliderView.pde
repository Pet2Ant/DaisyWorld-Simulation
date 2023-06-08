class CustomSliderView implements ControllerView<Slider> {
  public void display(PGraphics pg, Slider slider) {
    pg.pushStyle();
    pg.noStroke();


    // Draw slider bar background
    pg.fill(100);
    float barHeight = 20;
    float handleWidth = 10;
    float handleHeight = 25;

    if (slider == worldSlider) {

      // Draw filled portion of the slider bar
      float handlePosition = map(slider.getValue(), slider.getMin(), slider.getMax(), 0, slider.getWidth());
      pg.fill(75, 170, 222); // Change this to the desired filled portion color
      pg.rect(0, (slider.getHeight() - barHeight) / 2, handlePosition, barHeight, 5, 5, 5, 5);

      // Draw handle
      color handleColor = color(255);
      pg.fill(handleColor);
      
      pg.rect(handlePosition - handleWidth / 2, (slider.getHeight() - handleHeight) / 2, handleWidth, handleHeight, 5, 5, 5, 5);
      pg.popStyle();
    } else if (slider == slider5) {

      // Draw filled portion of the slider bar
      float handlePosition = map(slider.getValue(), slider.getMin(), slider.getMax(), 0, slider.getWidth());
      pg.fill(252, 186, 3); // Change this to the desired filled portion color
      pg.rect(0, (slider.getHeight() - barHeight) / 2, handlePosition, barHeight, 5, 5, 5, 5);

      // Draw handle
      color handleColor = color(255);
      pg.fill(handleColor);
      
      pg.rect(handlePosition - handleWidth / 2, (slider.getHeight() - handleHeight) / 2, handleWidth, handleHeight, 5, 5, 5, 5);
      pg.popStyle();
    } else if (slider == slider1) {

      // Draw filled portion of the slider bar
      float handlePosition = map(slider.getValue(), slider.getMin(), slider.getMax(), 0, slider.getWidth());
      pg.fill(150, 6, 6); // Change this to the desired filled portion color
      pg.rect(0, (slider.getHeight() - barHeight) / 2, handlePosition, barHeight, 5, 5, 5, 5);

      // Draw handle
      color handleColor = color(255);
      pg.fill(handleColor);
      
      pg.rect(handlePosition - handleWidth / 2, (slider.getHeight() - handleHeight) / 2, handleWidth, handleHeight, 5, 5, 5, 5);
      pg.popStyle();
    } else if (slider == slider2) {

      // Draw filled portion of the slider bar
      float handlePosition = map(slider.getValue(), slider.getMin(), slider.getMax(), 0, slider.getWidth());
      pg.fill(11, 133, 0); // Change this to the desired filled portion color
      pg.rect(0, (slider.getHeight() - barHeight) / 2, handlePosition, barHeight, 5, 5, 5, 5);

      // Draw handle
      color handleColor = color(255);
      pg.fill(handleColor);
      
      pg.rect(handlePosition - handleWidth / 2, (slider.getHeight() - handleHeight) / 2, handleWidth, handleHeight, 5, 5, 5, 5);
      pg.popStyle();
    } else if (slider == slider3) {

      // Draw filled portion of the slider bar
      float handlePosition = map(slider.getValue(), slider.getMin(), slider.getMax(), 0, slider.getWidth());
      pg.fill(227, 225, 225); // Change this to the desired filled portion color
      pg.rect(0, (slider.getHeight() - barHeight) / 2, handlePosition, barHeight, 5, 5, 5, 5);

      // Draw handle
      color handleColor = color(255);
      pg.fill(handleColor);
      
      pg.rect(handlePosition - handleWidth / 2, (slider.getHeight() - handleHeight) / 2, handleWidth, handleHeight, 5, 5, 5, 5);
      pg.popStyle();
    } else if (slider == slider4) {

      // Draw filled portion of the slider bar
      float handlePosition = map(slider.getValue(), slider.getMin(), slider.getMax(), 0, slider.getWidth());
      pg.fill(15, 15, 15); // Change this to the desired filled portion color
      pg.rect(0, (slider.getHeight() - barHeight) / 2, handlePosition, barHeight, 5, 5, 5, 5);

      // Draw handle
      color handleColor = color(255);
      pg.fill(handleColor);
      
      pg.rect(handlePosition - handleWidth / 2, (slider.getHeight() - handleHeight) / 2, handleWidth, handleHeight, 5, 5, 5, 5);
      pg.popStyle();
    } else if (slider == slider6) {

      // Draw filled portion of the slider bar
      float handlePosition = map(slider.getValue(), slider.getMin(), slider.getMax(), 0, slider.getWidth());
      pg.fill(72, 3, 150); // Change this to the desired filled portion color
      pg.rect(0, (slider.getHeight() - barHeight) / 2, handlePosition, barHeight, 5, 5, 5, 5);

      // Draw handle
      color handleColor = color(255);
      pg.fill(handleColor);
      
      pg.rect(handlePosition - handleWidth / 2, (slider.getHeight() - handleHeight) / 2, handleWidth, handleHeight, 5, 5, 5, 5);
      pg.popStyle();
    }else {

      // Draw gradient
      for (int i = 0; i < slider.getWidth(); i++) {
        float t = map(i, 0, slider.getWidth(), 0, 1);
        pg.fill(lerpColor(color(255), color(0), t));
        pg.rect(i, 0, 1, slider.getHeight());
      }

      // Draw marker

      float markerPosition = map(slider.getValue(), slider.getMin(), slider.getMax(), 0, slider.getWidth());
      float markerColorT = map(markerPosition, 0, slider.getWidth(), 0, 1);
      color markerColor = lerpColor(color(255), color(0), 1 - markerColorT);
      pg.fill(markerColor);
      pg.rect(markerPosition - handleWidth / 2, (slider.getHeight() - handleHeight) / 2, handleWidth, handleHeight, 5, 5, 5, 5);
      pg.popStyle();

      // Draw value label
      pg.pushStyle();
      float tooltipX = markerPosition - 20;
      float tooltipY = slider.getHeight() + 10;
      String valueText = String.format("%.2f", slider.getValue());
      // Tooltip text
      pg.fill(255);
      pg.textFont(captionFont);
      pg.text(valueText, tooltipX + 5, tooltipY + 15);
      pg.popStyle();
    }




    // Draw caption label
    pg.pushStyle();
    pg.fill(255);
    pg.textFont(captionFont);
    pg.text(slider.getCaptionLabel().getText(), slider.getWidth() + 5, 15);
    pg.popStyle();
  }
}
