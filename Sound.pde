import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.AudioSystem;
import javax.sound.sampled.Clip;

class Sound {
  String path;

  Sound(String path) {
    this.path = path;
  }

  void start() {
    //clip.start();
    try {
    }
    catch (Exception e) {
    }
  }

  void loop(int count) {
    //clip.loop(count);
  }

  void loop() {
    //loop(Integer.MAX_VALUE);
  }

  void stop() {
    //clip.stop();
  }

  void setFrame(int frame) {
    //clip.setFramePosition(frame);
  }

  void setLoop(int start, int stop) {
    //clip.setLoopPoints(start, stop);
  }

  int getLengthInFrames() {
    return 0;
    //return clip.getFrameLength();
  }

  boolean isPlaying() {
    return false;
    //return clip.available() > 0;
  }
}

synchronized void loadSound(final String path) {
  try {
    println("loading " + path + "...");

    AudioInputStream audioIn = AudioSystem.getAudioInputStream(createInput(path));
    AudioSystem.getClip().open(audioIn);

    println("loaded " + path);
  } 
  catch (Exception e) {
    println("Error opening sound file '" + path + "':");
    e.printStackTrace();
    exit();
  }
}

synchronized void playSound() {
  try {
    AudioSystem.getClip().start();
  } 
  catch (Exception e) {
    exit();
  }
}

synchronized void stopSound() {}

synchronized void loopSound() {}
