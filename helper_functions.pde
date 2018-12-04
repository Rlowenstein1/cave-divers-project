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

public void setLoopTypes() {
  ambient_water.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
  depth_noise.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
  upwards.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
  depth_noise2.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
  forwardsp.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
  backwardsp.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
  leftsp.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
  rightsp.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
}

public void drawCP5() {
  cp5.addSlider("Depth")
    .setPosition(10, 420)
    .setSize(160,15)
    .setRange(0,100)
    .setValue(0.0)
    .setLabel("Depth (m)");
  forwardSlider = cp5.addSlider("Forward")
    .setPosition(230, 10)
    .setSize(20,180)
    .setValue(0.0)
    .setRange(0, 100)
    .setLabel("Forward")
    .setSliderMode(Slider.FLEXIBLE);
  backwardSlider = cp5.addSlider("Backward")
    .setPosition(230, 270)
    .setSize(20,180)
    .setValue(0.0)
    .setSliderMode(Slider.FLEXIBLE)
    .setRange(100, 0)
    .setLabel("Backward");
  leftSlider = cp5.addSlider("Left")
    .setPosition(10,220)
    .setSize(180, 20)
    .setValue(0.0)
    .setRange(100,0)
    .setLabel("Left")
    .setSliderMode(Slider.FLEXIBLE);
  rightSlider = cp5.addSlider("Right")
    .setPosition(280,220)
    .setSize(180, 20)
    .setValue(0.0)
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

public void initializeGainsAndGlides() {
  depthGainGlide = new Glide (ac, 0.5, 50);
  depthGain = new Gain(ac, 1, depthGainGlide);
  depth2GainGlide = new Glide (ac, 0.5, 50);
  depth2Gain = new Gain(ac, 1, depth2GainGlide);
  ambGainGlide = new Glide(ac, 0.5, 50);
  ambGain = new Gain(ac, 1, ambGainGlide);
  upGainGlide = new Glide(ac, 0.5, 50);
  upGain = new Gain(ac, 1, upGainGlide);
  
//  Glide forwardGlide, bacforwardGlidekwardGlide, leftGlide, rightGlide;
//Gain forwardGain, backwardGain, leftGain, rightGain;
  forwardGlide = new Glide(ac, 0.5, 50);
  backwardGlide = new Glide(ac, 0.5, 50);
  leftGlide = new Glide(ac, 0.5, 50);
  rightGlide = new Glide(ac, 0.5, 50);
  // Default directional status sets to 0.
  forwardGlide.setValue(0.0);
  backwardGlide.setValue(0.0);
  leftGlide.setValue(0.0);
  rightGlide.setValue(0.0);
  
  
  forwardGain = new Gain(ac, 1, forwardGlide);
  backwardGain = new Gain(ac, 1, backwardGlide);
  leftGain = new Gain(ac, 1, leftGlide);
  rightGain = new Gain(ac, 1, rightGlide);
}

public void addInputsToFilters() {
  forwardGain.addInput(forwardsp);
  leftGain.addInput(leftsp);
  rightGain.addInput(rightsp);
  backwardGain.addInput(backwardsp);
  filter.addInput(forwardGain);
  filter.addInput(leftGain);
  filter.addInput(backwardGain);
  filter.addInput(rightGain);
}

public void getSamplePlayers() {
  ambient_water = getSamplePlayer("ambient.wav");
  depth_noise = getSamplePlayer("depth.wav");
  upwards = getSamplePlayer("up.wav");
  depth_noise2 = getSamplePlayer("up2.wav");

  // To be changed.
  forwardsp = getSamplePlayer("cursormove.wav");
  backwardsp = getSamplePlayer("divide.wav");
  leftsp = getSamplePlayer("glass_breaking.wav");
  rightsp = getSamplePlayer("message.wav");
}
