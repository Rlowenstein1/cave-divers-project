import controlP5.*;
import beads.*;
import org.jaudiolibs.beads.*;

SamplePlayer ambient_water;
SamplePlayer depth_noise;
SamplePlayer upwards;
SamplePlayer depth_noise2;
ControlP5 cp5;

// Depth
Glide depthGainGlide, depth2GainGlide;
float depthGainAmount, depth2GainAmount;
Gain depthGain, depth2Gain;

// Forward, Left, Right, Backward Glide and Gains
Glide fowardGlide, backwardGlide, leftGlide, rightGlide;
Gain fowardGain, backwardGain, leftGain, rightGain;

Gain ambGain;
Glide ambGainGlide;
Gain upGain;
Glide upGainGlide;

Panner upPan;
Glide panGlide;

BiquadFilter filter;




void setup() {
  size(640, 480);
  ac = new AudioContext(); 
  
  depthGainGlide = new Glide (ac, 0.5, 50);
  depthGain = new Gain(ac, 1, depthGainGlide);
  
  depth2GainGlide = new Glide (ac, 0.5, 50);
  depth2Gain = new Gain(ac, 1, depth2GainGlide);
  
  ambGainGlide = new Glide(ac, 0.5, 50);
  ambGain = new Gain(ac, 1, ambGainGlide);
  
  upGainGlide = new Glide(ac, 0.5, 50);
  upGain = new Gain(ac, 1, upGainGlide);
  
  ambient_water = getSamplePlayer("ambient.wav");
  depth_noise = getSamplePlayer("depth.wav");
  upwards = getSamplePlayer("up.wav");
  depth_noise2 = getSamplePlayer("up2.wav");
  
  
  
  ambient_water.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
  depth_noise.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
  upwards.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
  depth_noise2.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);

  
  
  cp5 = new ControlP5(this);
      
  cp5.addSlider("Depth")
      .setPosition(50, 75)
      .setSize(20,300)
      .setRange(100,0)
      .setValue(0)
      .setLabel("Depth (m)");
      
  cp5.addSlider("Position")
      .setPosition(150,175)
      .setValue(0)
      .setRange(-1.0,1.0)
      .setLabel("Body Position");
      
  cp5.addButton("Up").setPosition(width / 2 - 50, 80);
 
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
  print(value + "\n");
  
  if (value > 50.0) {
    depthGainGlide.setValue(0.0);
    depth2GainGlide.setValue(pow(value, 1.5)/100.0);
  } else {
    depth2GainGlide.setValue(0.0);
    depthGainGlide.setValue(pow(value, 1.5)/100.0);
  }
  
    
   
 
}

public void Position(float value) {
  panGlide.setValue(value / 1.0);
}
