class GradientSliderView implements ControllerView<Slider> {
  public void display(PGraphics pg, Slider slider) {
    pg.pushStyle();
    pg.noStroke();

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
    pg.rect(markerPosition - 5, (slider.getHeight() - 30) / 2, 10, 30);
    pg.popStyle();

    // Draw caption label
    pg.pushStyle();
    pg.fill(255);
    pg.textFont(captionFont);
    pg.text(slider.getCaptionLabel().getText(), slider.getWidth() + 5, 15);
    pg.popStyle();

    // Draw value label
    pg.pushStyle();
  float tooltipX = markerPosition - 20;
  float tooltipY = slider.getHeight() + 10;
  String valueText = String.format("%.2f", slider.getValue());
  float valueTextWidth = pg.textWidth(valueText);

  // Tooltip background and border
  pg.fill(100);
  pg.stroke(0);
  pg.rect(tooltipX, tooltipY, valueTextWidth + 10, 20);

  // Tooltip text
  pg.fill(0);
  pg.textFont(captionFont);
  pg.text(valueText, tooltipX + 5, tooltipY + 15);
  pg.popStyle();
}
  }
