class SoundOverlay implements Overlay {
  VolumeSlider volumeSlider;
  
  {
    volumeSlider = new VolumeSlider();
  }
  
  void show() {
    volumeSlider.show();
  }
  
  boolean update() {
    if (keyPressed)
      remove(this);
    
    return false;
  }
  
  boolean onPressed() {
    volumeSlider.onPressed();
    
    return false;
  }
  
  boolean onRelease() {
    volumeSlider.onRelease();
    
    return false;
  }
  
  boolean onDragged() {
    volumeSlider.onDragged();
    
    return false;
  }
  
  void close() {
    volumeSlider = null;
  }
  
  class VolumeSlider extends Slider {
    {
      x = 50;
      y = 150;
      wid = 100;
      hei = 300;
      sliHei = 15;
      
      value = vol;
      min = 0;
      max = 100;
      
      sliderEvents = new SliderEvent[] {
        new SliderEvent() {
          void apply(Slider s) {
            vol = s.value;
            
            for (Clip c : clips.values()) {
              FloatControl fcontrol = (FloatControl)c.getControl(FloatControl.Type.MASTER_GAIN);
              fcontrol.setValue(log(normValue) / log(10) * 20);
            }
          }
        }
      };
    }
  }
}
