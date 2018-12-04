import controlP5.*;
import beads.*;
import org.jaudiolibs.beads.*;

SamplePlayer ambient_water, depth_noise, upwards, depth_noise2;
SamplePlayer forwardsp, backwardsp, leftsp, rightsp;

ControlP5 cp5;
Slider forwardSlider, backwardSlider, leftSlider, rightSlider;

// Depth
Glide depthGainGlide, depth2GainGlide;
float depthGainAmount, depth2GainAmount;
Gain depthGain, depth2Gain;

// Forward, Left, Right, Backward Glides and Gains
Glide forwardGlide, backwardGlide, leftGlide, rightGlide;
Gain forwardGain, backwardGain, leftGain, rightGain;

Gain ambGain;
Glide ambGainGlide;
Gain upGain;
Glide upGainGlide;

Panner upPan;
Glide panGlide;
BiquadFilter filter;

// Frequency Controllers
Glide freqGlide;
WavePlayer freqWP;

void setup() {
  size(500, 480);
  ac = new AudioContext(); 
  
  getSamplePlayers();
  initializeGainsAndGlides();  
  setLoopTypes();

  cp5 = new ControlP5(this);
  drawCP5(); // Plz check helper_functions
 
  filter = new BiquadFilter(ac, BiquadFilter.LP, 300.0, 0.5f);
  panGlide = new Glide(ac, 0.0, 10);
  upPan = new Panner(ac, panGlide);
  ambGain.setGain(0.5);
  upGain.setGain(1.5);
  depthGain.addInput(depth_noise);
  depth2Gain.addInput(depth_noise2);
  depth2Gain.setValue(0.0);

  filter.addInput(depthGain);
  filter.addInput(depth2Gain);
  
  ambGain.addInput(ambient_water);
  filter.addInput(ambGain);
  upGain.addInput(upwards);
  upPan.addInput(upGain);
  
  freqGlide = new Glide(ac, 20, 50);
  freqWP = new WavePlayer(ac, freqGlide, Buffer.SINE);
  depthGain.addInput(freqWP);
  depth2Gain.addInput(freqWP);
 
  addInputsToFilters(); // helper function
  //forwardGlide.setValue(0.0);
  //backwardGlide.setValue(0.0);
  //leftGlide.setValue(0.0);
  //rightGlide.setValue(0.0);
  
  
  ac.out.addInput(filter);
  ac.start();
}


void draw() {
  background(0); 
}

public void Up() {
  filter.addInput(upPan);
}

public void Depth(float value) {
  if (value > 50.0) {
    depthGainGlide.setValue(0.0);
    depth2GainGlide.setValue(pow(value, 1.5)/100.0);
  } else {
    depth2GainGlide.setValue(0.0);
    depthGainGlide.setValue(pow(value, 1.5)/100.0);
  }
}

public void Left(float value) {
  if(value>0) {
     rightSlider.setValue(0.0);
     freqGlide.setValue(0);
  }
  leftGlide.setValue(pow(value, 1.5)/100.0);
  freqGlide.setValue(pow(value, 1.5)/100.0);
  rightGlide.setValue(0.0);
}

public void Right(float value) {
  if(value>0) {
     leftSlider.setValue(0.0);
     freqGlide.setValue(0);
  }
  rightGlide.setValue(pow(value, 1.5)/100.0);
  freqGlide.setValue(pow(value, 1.5)/100.0);
} 

public void Forward(float value) {
  if(value>0) {
     backwardSlider.setValue(0.0);
     freqGlide.setValue(0);
  }
  forwardGlide.setValue(pow(value, 1.5)/100.0);
  freqGlide.setValue(pow(value, 1.5)/100.0);
}

public void Backward(float value) {
  if(value>0) {
     forwardSlider.setValue(0.0);
     freqGlide.setValue(0);
  }
  backwardGlide.setValue(pow(value, 1.5)/100.0);
  freqGlide.setValue(pow(value, 1.5)/100.0);
}
