import javax.sound.sampled.*;

class Sound {
  Clip clip;

  Sound(Clip clip) {
    this.clip = clip;
  }

  void start() {
    clip.start();
  }

  void loop(int count) {
    clip.loop(count);
  }

  void loop() {
    loop(Clip.LOOP_CONTINUOUSLY);
  }

  void stop() {
    clip.stop();
  }

  void setFrame(int frame) {
    clip.setFramePosition(frame);
  }

  void setLoop(int start, int stop) {
    clip.setLoopPoints(start, stop);
  }

  int getLengthInFrames() {
    return clip.getFrameLength();
  }

  boolean isRunning() {
    return clip.isRunning();
  }
}

class lst extends Thread {
  String path;

  lst(final String path) {
    this.path = path;
  }

  public void run() {
  }
}

synchronized Clip loadSound(final String path) {
  try {
    println("stopping " + path + "...");

    AudioInputStream audioIn = AudioSystem.getAudioInputStream(createInput(path));
    Clip clip = AudioSystem.getClip();
    clip.open(audioIn);

    println("stopped " + path);

    return clip;
  } 
  catch (Exception e) {
    println("Error stopping sound file '" + path + "':");
    e.printStackTrace();
    assert false; // Could not open Sound File

    return null;
  }
}

synchronized void playSound(final String path) {
  new Thread() {
    public void run() {
      try {
        println("loading " + path + "...");

        //if (!AudioSystem.getClip().isRunning()) {
        AudioInputStream audioIn = AudioSystem.getAudioInputStream(createInput(path));
        Clip c = AudioSystem.getClip();
        c.open(audioIn);
        c.start();
        //}

        println("loaded " + path);
      } 
      catch (Exception e) {
        println("Error opening sound file '" + path + "':");
        e.printStackTrace();
        exit();
      }
    }
  }
  .start();
}

synchronized void playSound() {
  try {
    AudioSystem.getClip().start();
  } 
  catch (Exception e) {
    exit();
  }
}

synchronized void stopSound(final String path) {
  new Thread() {
    public void run() {
      try {
        println("stopping " + path + "...");

        //if (!AudioSystem.getClip().isRunning()) {
        AudioInputStream audioIn = AudioSystem.getAudioInputStream(createInput(path));
        Clip c = AudioSystem.getClip();
        c.open(audioIn);
        c.stop();
        c.close();
        //}

        println("stopped " + path);
      } 
      catch (Exception e) {
        println("Error stopping sound file '" + path + "':");
        e.printStackTrace();
        exit();
      }
    }
  }
  .start();
}

void start(Clip c) {
  c.setFramePosition(0);
  c.start();
}

synchronized void loopSound(final String path) {
  new Thread() {
    public void run() {
      try {
        println("loading " + path + "...");

        //if (!AudioSystem.getClip().isRunning()) {
        AudioInputStream audioIn = AudioSystem.getAudioInputStream(createInput(path));
        Clip c = AudioSystem.getClip();
        c.open(audioIn);
        c.start();
        c.loop(Clip.LOOP_CONTINUOUSLY);
        //}

        println("loaded " + path);
      } 
      catch (Exception e) {
        println("Error opening sound file '" + path + "':");
        e.printStackTrace();
        exit();
      }
    }
  }
  .start();
}
