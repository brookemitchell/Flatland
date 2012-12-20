
void oscSend(float[] euler, int dx, int dy, int dz) {
  OscBundle eulerBundle = new OscBundle();

  //arrayCopy(euler, constrEurel

  arraycopy(euler, mapEurel);

  OscMessage yawMessage = new OscMessage("/Yaw");
  OscMessage pitchMessage = new OscMessage("/Pitch");
  OscMessage rollMessage = new OscMessage("/Roll"); 
  OscMessage diffYaw = new OscMessage("/diffYaw");
  OscMessage diffPitch = new OscMessage("/diffPitch");
  OscMessage diffRoll = new OscMessage("/diffRoll");

  for (int i = 0; i < 3; i++) { 
    mapEurel[i] = degrees(mapEurel[i]);

    // mapEurel[i] = constrain(mapEurel[i], 0.05, 0.95);
  }

  yawMessage.add(mapEurel[0]);   //add eulers[] to osc message  
  pitchMessage.add(mapEurel[1]);   //add eulers[] to osc message  
  rollMessage.add(mapEurel[2]);   //add eulers[] to osc message  
  diffYaw.add(dx);   //add eulers[] to osc message  
  diffPitch.add(dy);   //add eulers[] to osc message  
  diffRoll.add(dz);   //add eulers[] to osc message  


  eulerBundle.add(yawMessage);
  eulerBundle.add(pitchMessage);
  eulerBundle.add(rollMessage);
    eulerBundle.add(diffYaw);
  eulerBundle.add(diffPitch);
  eulerBundle.add(diffRoll);


  yawMessage.clear();
  pitchMessage.clear();  
  rollMessage.clear();
  diffYaw.clear();
diffPitch.clear();
diffRoll.clear();
  eulerBundle.setTimetag(eulerBundle.now());

  oscP5.send(eulerBundle, sendRemoteLocation);
}

