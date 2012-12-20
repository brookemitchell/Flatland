/**
  
 This program is free software: you can redistribute it and/or modify
 it under the terms of the version 3 GNU General Public License as
 published by the Free Software Foundation.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
 */

import processing.serial.*;
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress sendRemoteLocation;
Serial myPort;  // Create object from Serial class
Delta1 delta1 = new Delta1();
Delta1 delta2 = new Delta1();
Delta1 delta3 = new Delta1();


float [] q = new float [4];
float [] hq = null;
float [] Euler = new float [3]; // psi, theta, phi
float[] mapEurel = new float [Euler.length];


int lf = 10; // 10 is '\n' in ASCII
byte[] inBuffer = new byte[22]; // this is the number of chars on each line from the Arduino (including /r/n)

PFont font;
final int VIEW_SIZE_X = 800, VIEW_SIZE_Y = 600;

final int burst = 32;
int count = 0;

// "/dev/tty.usbserial-A501DGY0"
// "/dev/tty.usbserial-A8004xvi"
void setup() 
{

  size(VIEW_SIZE_X, VIEW_SIZE_Y, P3D);
  println(Serial.list());
  myPort =  new Serial(this, Serial.list()[1], 115200);

  // The font must be located in the sketch's "data" directory to load successfully
  font = loadFont("CourierNew36.vlw"); 

  oscP5 = new OscP5(this, 12000);
  sendRemoteLocation = new NetAddress("127.0.0.1", 12001);

  delay(100);
  myPort.clear();
  myPort.write("ON");
  myPort.bufferUntil('\n');
}


float decodeFloat(String inString) {
  byte [] inData = new byte[4];

  if (inString.length() == 8) {
    inData[0] = (byte) unhex(inString.substring(0, 2));
    inData[1] = (byte) unhex(inString.substring(2, 4));
    inData[2] = (byte) unhex(inString.substring(4, 6));
    inData[3] = (byte) unhex(inString.substring(6, 8));
  }

  int intbits = (inData[3] << 24) | ((inData[2] & 0xff) << 16) | ((inData[1] & 0xff) << 8) | (inData[0] & 0xff);
  return Float.intBitsToFloat(intbits);
}

void serialEvent(Serial p) { 
  if (p.available() >= 18) {
    String inputString = p.readStringUntil('\n');
    //print(inputString);
    if (inputString != null && inputString.length() > 0) {

      String [] inputStringArr = split(inputString, ",");
      if (inputStringArr.length >= 5) { // q1,q2,q3,q4,\r\n so we have 5 elements
        q[0] = decodeFloat(inputStringArr[0]);
        q[1] = decodeFloat(inputStringArr[1]);
        q[2] = decodeFloat(inputStringArr[2]);
        q[3] = decodeFloat(inputStringArr[3]);
      }
      else if (inputStringArr.length == 1) { // q1,q2,q3,q4,\r\n so we have 5 elements
        hq = quatConjugate(q);
      }
      else hq = null;

    }
  }
}



void buildBoxShape() {
  //box(60, 10, 40);
  noStroke();
  beginShape(QUADS);

  //Z+ (to the drawing area)
  fill(#00ff00);
  vertex(-30, -5, 20);
  vertex(30, -5, 20);
  vertex(30, 5, 20);
  vertex(-30, 5, 20);

  //Z-
  fill(#0000ff);
  vertex(-30, -5, -20);
  vertex(30, -5, -20);
  vertex(30, 5, -20);
  vertex(-30, 5, -20);

  //X-
  fill(#ff0000);
  vertex(-30, -5, -20);
  vertex(-30, -5, 20);
  vertex(-30, 5, 20);
  vertex(-30, 5, -20);

  //X+
  fill(#ffff00);
  vertex(30, -5, -20);
  vertex(30, -5, 20);
  vertex(30, 5, 20);
  vertex(30, 5, -20);

  //Y-
  fill(#ff00ff);
  vertex(-30, -5, -20);
  vertex(30, -5, -20);
  vertex(30, -5, 20);
  vertex(-30, -5, 20);

  //Y+
  fill(#00ffff);
  vertex(-30, 5, -20);
  vertex(30, 5, -20);
  vertex(30, 5, 20);
  vertex(-30, 5, 20);

  endShape();
}


void drawCube() {  
  pushMatrix();
  translate(VIEW_SIZE_X/2, VIEW_SIZE_Y/2 + 50, 0);
  scale(5, 5, 5);

  // a demonstration of the following is at 
  // http://www.varesano.net/blog/fabio/ahrs-sensor-fusion-orientation-filter-3d-graphical-rotating-cube
  rotateZ(-Euler[2]);
  rotateX(-Euler[1]);
  rotateY(-Euler[0]);

  buildBoxShape();

  popMatrix();
}


void draw() {
  background(#000000);
  fill(#ffffff);

  if (hq != null) { // use home quaternion
    quaternionToEuler(quatProd(hq, q), Euler);
    text("Disable home position by pressing \"n\"", 420, VIEW_SIZE_Y - 30);
  }
  else {
    quaternionToEuler(q, Euler);
    text("Point IMU's blue LED to your monitor then press \"h\"", 420, VIEW_SIZE_Y - 30);
  }

  textFont(font, 20);
  textAlign(LEFT, TOP);
  //text("Q:\n" + q[0] + "\n" + q[1] + "\n" + q[2] + "\n" + q[3], 20, 20);
  text("Euler Angles:\nYaw (psi)  : " + degrees(Euler[0]) + "\nPitch (theta): " + degrees(Euler[1]) + "\nRoll (phi)  : " + degrees(Euler[2]), 100, 20);

  drawcompass(Euler[0], VIEW_SIZE_X/2 - 250, VIEW_SIZE_Y/3, 100);
  drawAngle(Euler[1], VIEW_SIZE_X/2, VIEW_SIZE_Y/3, 100, "Pitch:");
  drawAngle(Euler[2], VIEW_SIZE_X/2 + 250, VIEW_SIZE_Y/3, 100, "Roll:");
  //  float[] test = diff(Euler);

  int test1 = abs(delta1.diff(degrees(Euler[0])));
  int test2 = abs(delta2.diff(degrees(Euler[1])));
  int test3 = abs(delta3.diff(degrees(Euler[2])));

  // println(test1 + "\t" + test2+ "\t" + test3);

  drawCube(); 
  oscSend(Euler, test1, test2, test3);
  text("Delta(Change):", 120, 380);
  text("X: ", 20, 415);

  rect(40, 400, test1, 15);
  text("Y: ", 20, 445);

  rect(40, 430, test2, 15);
  text("Z: ", 20, 475);

  rect(40, 460, test3, 15);
}


void keyPressed() {
  if (key == 'h') {
    //   println("pressed h");
    // set hq the home quaternion as the quatnion conjugate coming from the sensor fusion
    hq = quatConjugate(q);
  }
  else if (key == 'n') {
    //   println("pressed n");
    hq = null;
  }
}


// See Sebastian O.H. Madwick report 
// "An efficient orientation filter for inertial and intertial/magnetic sensor arrays" Chapter 2 Quaternion representation

void quaternionToEuler(float [] q, float [] euler) {
  euler[0] = atan2(2 * q[1] * q[2] - 2 * q[0] * q[3], 2 * q[0]*q[0] + 2 * q[1] * q[1] - 1); // psi
  euler[1] = -asin(2 * q[1] * q[3] + 2 * q[0] * q[2]); // theta
  euler[2] = atan2(2 * q[2] * q[3] - 2 * q[0] * q[1], 2 * q[0] * q[0] + 2 * q[3] * q[3] - 1); // phi
}

float [] quatProd(float [] a, float [] b) {
  float [] q = new float[4];

  q[0] = a[0] * b[0] - a[1] * b[1] - a[2] * b[2] - a[3] * b[3];
  q[1] = a[0] * b[1] + a[1] * b[0] + a[2] * b[3] - a[3] * b[2];
  q[2] = a[0] * b[2] - a[1] * b[3] + a[2] * b[0] + a[3] * b[1];
  q[3] = a[0] * b[3] + a[1] * b[2] - a[2] * b[1] + a[3] * b[0];

  return q;
}

// returns a quaternion from an axis angle representation
float [] quatAxisAngle(float [] axis, float angle) {
  float [] q = new float[4];

  float halfAngle = angle / 2.0;
  float sinHalfAngle = sin(halfAngle);
  q[0] = cos(halfAngle);
  q[1] = -axis[0] * sinHalfAngle;
  q[2] = -axis[1] * sinHalfAngle;
  q[3] = -axis[2] * sinHalfAngle;

  return q;
}

// return the quaternion conjugate of quat
float [] quatConjugate(float [] quat) {
  float [] conj = new float[4];

  conj[0] = quat[0];
  conj[1] = -quat[1];
  conj[2] = -quat[2];
  conj[3] = -quat[3];

  return conj;
}


class Delta1 {
  int lastValue;
  int val;

  Delta1 () {  
    lastValue = 0;
    val = 0;
  } 


  public int diff(float f) {


    val = int(f) - lastValue;
    lastValue = int(f);
    delay(20);  
    return val;
  }
}

