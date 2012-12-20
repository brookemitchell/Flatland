/**
 *
 */

import processing.serial.*;
import xbee.*;
import oscP5.*;
import netP5.*;
import controlP5.*;

Serial myPort;  // Create object from Serial class  
ControlP5 cp5;  
Accordion accordion;
OscP5 oscP5;

NetAddress myRemoteLocation;

XBeeReader xbee;

color c = color(0, 160, 100);
final int VIEW_SIZE_X = 450, VIEW_SIZE_Y = 550;

public int flex1;
public int flex2;

public int ir1;
public int ir2;


public int x;
public int y;
public int z;

void setup() {
    myPort = new Serial(this, Serial.list()[1], 115200);
xbee = new XBeeReader(this, myPort);

  
  size(VIEW_SIZE_X, VIEW_SIZE_Y);
  noStroke();
  smooth();
  gui();

  //init osc and serial
  
//  myPort = new Serial(this, serialPort, 115200);

  //listen on this port
  oscP5 = new OscP5(this, 12000);

  // send on this port
  myRemoteLocation = new NetAddress("127.0.0.1", 12001);   
  xbee.startXBee();

  delay(200);
  myPort.clear();
  // myPort.write("1");

  // accordion.setPosition(0,0);accordion.setItemHeight(190);
}



/*

 a list of all methods available for the Accordion Controller
 use ControlP5.printPublicMethodsFor(Accordion.class);
 to print the following list into the console.
 
 You can find further details about class Accordion in the javadoc.
 
 Format:
 ClassName : returnType methodName(parameter type)
 
 
 controlP5.Accordion : Accordion addItem(ControlGroup) 
 controlP5.Accordion : Accordion remove(ControllerInterface) 
 controlP5.Accordion : Accordion removeItem(ControlGroup) 
 controlP5.Accordion : Accordion setItemHeight(int) 
 controlP5.Accordion : Accordion setMinItemHeight(int) 
 controlP5.Accordion : Accordion setWidth(int) 
 controlP5.Accordion : Accordion updateItems() 
 controlP5.Accordion : int getItemHeight() 
 controlP5.Accordion : int getMinItemHeight() 
 controlP5.ControlGroup : Accordion activateEvent(boolean) 
 controlP5.ControlGroup : Accordion addListener(ControlListener) 
 controlP5.ControlGroup : Accordion hideBar() 
 controlP5.ControlGroup : Accordion removeListener(ControlListener) 
 controlP5.ControlGroup : Accordion setBackgroundColor(int) 
 controlP5.ControlGroup : Accordion setBackgroundHeight(int) 
 controlP5.ControlGroup : Accordion setBarHeight(int) 
 controlP5.ControlGroup : Accordion showBar() 
 controlP5.ControlGroup : Accordion updateInternalEvents(PApplet) 
 controlP5.ControlGroup : String getInfo() 
 controlP5.ControlGroup : String toString() 
 controlP5.ControlGroup : boolean isBarVisible() 
 controlP5.ControlGroup : int getBackgroundHeight() 
 controlP5.ControlGroup : int getBarHeight() 
 controlP5.ControlGroup : int listenerSize() 
 controlP5.ControllerGroup : Accordion add(ControllerInterface) 
 controlP5.ControllerGroup : Accordion bringToFront() 
 controlP5.ControllerGroup : Accordion bringToFront(ControllerInterface) 
 controlP5.ControllerGroup : Accordion close() 
 controlP5.ControllerGroup : Accordion disableCollapse() 
 controlP5.ControllerGroup : Accordion enableCollapse() 
 controlP5.ControllerGroup : Accordion hide() 
 controlP5.ControllerGroup : Accordion moveTo(ControlWindow) 
 controlP5.ControllerGroup : Accordion moveTo(PApplet) 
 controlP5.ControllerGroup : Accordion open() 
 controlP5.ControllerGroup : Accordion registerProperty(String) 
 controlP5.ControllerGroup : Accordion registerProperty(String, String) 
 controlP5.ControllerGroup : Accordion remove(CDrawable) 
 controlP5.ControllerGroup : Accordion remove(ControllerInterface) 
 controlP5.ControllerGroup : Accordion removeCanvas(ControlWindowCanvas) 
 controlP5.ControllerGroup : Accordion removeProperty(String) 
 controlP5.ControllerGroup : Accordion removeProperty(String, String) 
 controlP5.ControllerGroup : Accordion setAddress(String) 
 controlP5.ControllerGroup : Accordion setArrayValue(float[]) 
 controlP5.ControllerGroup : Accordion setColor(CColor) 
 controlP5.ControllerGroup : Accordion setColorActive(int) 
 controlP5.ControllerGroup : Accordion setColorBackground(int) 
 controlP5.ControllerGroup : Accordion setColorForeground(int) 
 controlP5.ControllerGroup : Accordion setColorLabel(int) 
 controlP5.ControllerGroup : Accordion setColorValue(int) 
 controlP5.ControllerGroup : Accordion setHeight(int) 
 controlP5.ControllerGroup : Accordion setId(int) 
 controlP5.ControllerGroup : Accordion setLabel(String) 
 controlP5.ControllerGroup : Accordion setMouseOver(boolean) 
 controlP5.ControllerGroup : Accordion setMoveable(boolean) 
 controlP5.ControllerGroup : Accordion setOpen(boolean) 
 controlP5.ControllerGroup : Accordion setPosition(PVector) 
 controlP5.ControllerGroup : Accordion setPosition(float, float) 
 controlP5.ControllerGroup : Accordion setStringValue(String) 
 controlP5.ControllerGroup : Accordion setUpdate(boolean) 
 controlP5.ControllerGroup : Accordion setValue(float) 
 controlP5.ControllerGroup : Accordion setVisible(boolean) 
 controlP5.ControllerGroup : Accordion setWidth(int) 
 controlP5.ControllerGroup : Accordion show() 
 controlP5.ControllerGroup : Accordion update() 
 controlP5.ControllerGroup : Accordion updateAbsolutePosition() 
 controlP5.ControllerGroup : CColor getColor() 
 controlP5.ControllerGroup : ControlWindow getWindow() 
 controlP5.ControllerGroup : ControlWindowCanvas addCanvas(ControlWindowCanvas) 
 controlP5.ControllerGroup : Controller getController(String) 
 controlP5.ControllerGroup : ControllerProperty getProperty(String) 
 controlP5.ControllerGroup : ControllerProperty getProperty(String, String) 
 controlP5.ControllerGroup : Label getCaptionLabel() 
 controlP5.ControllerGroup : Label getValueLabel() 
 controlP5.ControllerGroup : PVector getPosition() 
 controlP5.ControllerGroup : String getAddress() 
 controlP5.ControllerGroup : String getInfo() 
 controlP5.ControllerGroup : String getName() 
 controlP5.ControllerGroup : String getStringValue() 
 controlP5.ControllerGroup : String toString() 
 controlP5.ControllerGroup : Tab getTab() 
 controlP5.ControllerGroup : boolean isCollapse() 
 controlP5.ControllerGroup : boolean isMouseOver() 
 controlP5.ControllerGroup : boolean isMoveable() 
 controlP5.ControllerGroup : boolean isOpen() 
 controlP5.ControllerGroup : boolean isUpdate() 
 controlP5.ControllerGroup : boolean isVisible() 
 controlP5.ControllerGroup : boolean setMousePressed(boolean) 
 controlP5.ControllerGroup : float getValue() 
 controlP5.ControllerGroup : float[] getArrayValue() 
 controlP5.ControllerGroup : int getHeight() 
 controlP5.ControllerGroup : int getId() 
 controlP5.ControllerGroup : int getWidth() 
 controlP5.ControllerGroup : void remove() 
 java.lang.Object : String toString() 
 java.lang.Object : boolean equals(Object) 
 
 
 */
