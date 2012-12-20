



void oscSend(int data, String message) {

  OscMessage intMessage = new OscMessage(message);
 // OscMessage rptMessage = new OscMessage("/lilypad1/ACCEL/rho-phi-theta");


     intMessage.add(data);   //add eulers[] to osc message
  

  oscP5.send(intMessage, myRemoteLocation);
 // oscP5.send(rptMessage, myRemoteLocation);
}


