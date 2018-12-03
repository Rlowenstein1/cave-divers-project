//helper functions
AudioContext ac; //needed here because getSamplePlayer() uses it below

Sample getSample(String fileName) {
 return SampleManager.sample(dataPath(fileName)); 
}

SamplePlayer getSamplePlayer(String fileName, Boolean killOnEnd) {
  SamplePlayer player = null;
  try {
    player = new SamplePlayer(ac, getSample(fileName));
    player.setKillOnEnd(killOnEnd);
    player.setName(fileName);
  }
  catch(Exception e) {
    println("Exception while attempting to load sample: " + fileName);
    e.printStackTrace();
    exit();
  }
  
  return player;
}

SamplePlayer getSamplePlayer(String fileName) {
  return getSamplePlayer(fileName, false);
}

public void drawCP5() {
  cp5.addSlider("Depth")
    .setPosition(10, 420)
    .setSize(160,15)
    .setRange(0,100)
    .setValue(0)
    .setLabel("Depth (m)");
  forwardSlider = cp5.addSlider("Forward")
    .setPosition(230, 10)
    .setSize(20,180)
    .setValue(0)
    .setRange(0, 100)
    .setLabel("Forward")
    .setSliderMode(Slider.FLEXIBLE);
  backwardSlider = cp5.addSlider("Backward")
    .setPosition(230, 270)
    .setSize(20,180)
    .setValue(0)
    .setSliderMode(Slider.FLEXIBLE)
    .setRange(100, 0)
    .setLabel("Backward");
  leftSlider = cp5.addSlider("Left")
    .setPosition(10,220)
    .setSize(180, 20)
    .setValue(0)
    .setRange(100,0)
    .setLabel("Left")
    .setSliderMode(Slider.FLEXIBLE);
  rightSlider = cp5.addSlider("Right")
    .setPosition(280,220)
    .setSize(180, 20)
    .setValue(0)
    .setRange(0,100)
    .setLabel("Right")
    .setSliderMode(Slider.FLEXIBLE);
  //cp5.addButton("Team Locator")
  //  .setPosition(200, 205)
  //  .setSize(80, 50); 
  cp5.addButton("upAction")
    .setPosition(400, 30)
    .setSize(80, 40)
    .setLabel("Up")
    ; 
  cp5.addButton("fowardAction")
    .setPosition(10, 30)
    .setSize(80, 40)
    .setLabel("Forward")
    ; 
}
