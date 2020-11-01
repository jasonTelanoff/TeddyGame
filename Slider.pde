class Slider implements UIComponent {
  float value, normValue, min, max;
  int x, y, wid, hei, sliHei;
  boolean selected;
  
  SliderEvent[] sliderEvents = new SliderEvent[0];

  void show() {
    stroke(#4D4D4D);
    fill(#AAAAAA);
    rect(x, y, wid, hei);
    
    strokeWeight(5);
    line(x + wid / 2, y + 5, x + wid / 2, y + hei - 5);
    strokeWeight(1);

    fill(#5A5A5A);
    rect(x, hei - (y + ((value - min) / (max - min)) * hei) + hei, wid, sliHei);
  }

  boolean mouseOn() {
    return mouseX >= x && mouseX <= x + wid && mouseY >= hei - (y + ((value - min) / (max - min)) * hei) + hei && mouseY <= hei - (y + ((value - min) / (max - min)) * hei) + hei + sliHei;
  }
  
  boolean mouseOnNotJustSlider() {
    return mouseX >= x && mouseX <= x+ wid && mouseY >= y && mouseY <= y + hei;
  }

  void onPressed() {
    selected = mouseOnNotJustSlider();
  }

  void onRelease() {
    if (selected) {
      value = constrain(max - (max * ((mouseY - y) / (float)hei)), min, max);
      normValue = (value - min) / (max - min);
      
      for (SliderEvent se : sliderEvents)
        se.apply(this);
    }
    
    selected = false;
  }

  void onDragged() {
    if (selected) {
      value = constrain(max - (max * ((mouseY - y) / (float)hei)), min, max);
      normValue = (value - min) / (max - min);
      
      for (SliderEvent se : sliderEvents)
        se.apply(this);
    }
  }
}

interface SliderEvent {
  void apply(Slider s);
}
