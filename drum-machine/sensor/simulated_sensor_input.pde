// Simulated MPU6050 input for Wekinator — no hardware required.
// Drag the mouse to fake "tilting" the sensor. Sends the same
// OSC message format the real Arduino/toxiclibs sketch would send.

import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress dest;

float simYaw = 0;
float simPitch = 0;
float simRoll = 0;

void setup() {
  size(400, 400);
  oscP5 = new OscP5(this, 9000);
  dest = new NetAddress("127.0.0.1", 6448); // same port Wekinator listens on

  textAlign(CENTER, CENTER);
  textSize(14);
}

void draw() {
  background(30);

  // Map mouse position to simulated pitch/roll (-1 to 1 range,
  // similar scale to the real ypr[] values after normalizing)
  simPitch = map(mouseY, 0, height, -1, 1);
  simRoll  = map(mouseX, 0, width, -1, 1);

  // Yaw simulated from horizontal drag speed, just for variety
  simYaw = map(mouseX - pmouseX, -20, 20, -1, 1);

  // Visual feedback so you can see what you're sending
  fill(255);
  text("Simulated Sensor (drag mouse)", width/2, 30);
  text("yaw: "   + nf(simYaw, 1, 2), width/2, 160);
  text("pitch: " + nf(simPitch, 1, 2), width/2, 190);
  text("roll: "  + nf(simRoll, 1, 2), width/2, 220);

  pushMatrix();
  translate(width/2, height/2 + 40);
  rotate(simRoll);
  fill(200, 80, 80);
  rectMode(CENTER);
  rect(0, 0, 150, 20);
  popMatrix();

  sendOsc();
}

void sendOsc() {
  OscMessage msg = new OscMessage("/wek/inputs");
  msg.add(simRoll);   // x-axis, matches ypr[2] in the original sketch
  msg.add(simPitch);  // y-axis, matches ypr[1] in the original sketch
  oscP5.send(msg, dest);
}
