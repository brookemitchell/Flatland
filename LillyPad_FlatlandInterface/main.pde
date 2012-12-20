void draw() {

  background(220);
  fill(c);

//   readAccelerometer();
   
//   oscSend(accRead);


 // float s1 = cp5.getController("hello").getValue();
  ellipse(400, 400, cp5.getController("X Accel").getValue(), cp5.getController("X Accel").getValue());

//  float s2 = cp5.getController("world").getValue();
  ellipse(300, 100, cp5.getController("Y Accel").getValue(), cp5.getController("Y Accel").getValue());

 oscSend(int(cp5.getController("X Accel").getValue()), "/x");
 oscSend(int(cp5.getController("Y Accel").getValue()), "/y");
 oscSend(int(cp5.getController("Z Accel").getValue()), "/z");

  ellipse(240, 250, cp5.getController("Z Accel").getValue(), cp5.getController("Z Accel").getValue());

  cp5.getController("X Accel").setValue(x);
  cp5.getController("Y Accel").setValue(y);
  cp5.getController("Z Accel").setValue(z);
  

//  cp5.getController("Freefall").setValue(abs(values[6]*100));

/*
  cp5.getController("Rho").setValue((accRead[3]*10));
  cp5.getController("Phi").setValue((accRead[4]/4));
  cp5.getController("Theta").setValue((accRead[5]));
  */

 oscSend(int(cp5.getController("IR1 - Distance").getValue()), "/ir1");
 oscSend(int(cp5.getController("IR2 - Distance").getValue()), "/ir2");

  cp5.getController("IR1 - Distance").setValue(ir1);
  cp5.getController("IR2 - Distance").setValue(ir2);




 oscSend(int(cp5.getController("Flex 1").getValue()), "/flex1");
 oscSend(int(cp5.getController("Flex 2").getValue()), "/flex2");

  cp5.getController("Flex 1").setValue(flex1);
  cp5.getController("Flex 2").setValue(flex2);
  
  //accValue();
}


