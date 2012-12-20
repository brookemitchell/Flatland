void gui() {

  cp5 = new ControlP5(this);

  // group number 1, contains 2 bangs
  Group g1 = cp5.addGroup("Acellerometer")
    .setBackgroundColor(color(0, 64))
      .setBackgroundHeight(160)
        ;



  cp5.addSlider("X Accel")
    .setPosition(10, 20)
      .setSize(100, 20)
        .setRange(0, 255)
          .setValue(0)
            .moveTo(g1)
              ;

  cp5.addSlider("Y Accel")
    .setPosition(10, 50)
      .setSize(100, 20)
        .setRange(0, 255)
          .setValue(0)
            .moveTo(g1)
              ;

  cp5.addSlider("Z Accel")
    .setPosition(10, 80)
      .setSize(100, 20)
        .setRange(0, 255)
          .setValue(0)
            .moveTo(g1)
              ;

  cp5.addBang("Freefall")
    .setPosition(10, 110)
      .setSize(20, 20)
        .moveTo(g1)
          ;



  Group g2 = cp5.addGroup("Acellerometer-Extra")
    .setBackgroundColor(color(0, 64))
      .setBackgroundHeight(100)
        ;
  cp5.addSlider("Rho")
    .setPosition(10, 10)
      .setSize(100, 20)
        .setRange(0, 100)
          .setValue(0)
            .moveTo(g2)
              ;
  cp5.addSlider("Phi")
    .setPosition(10, 40)
      .setSize(100, 20)
        .setRange(0, 100)
          .setValue(0)
            .moveTo(g2)
              ;
  cp5.addSlider("Theta")
    .setPosition(10, 70)
      .setSize(100, 20)
        .setRange(0, 100)
          .setValue(0)
            .moveTo(g2)
              ;


  // group number 2, contains a radiobutton
  Group g3 = cp5.addGroup("Infa-Red")
    .setBackgroundColor(color(0, 64))
      .setBackgroundHeight(20)
        ;


  cp5.addSlider("IR1 - Distance")
    .setPosition(10, 10)
      .setSize(100, 20)
        .setRange(0, 255)
          .setValue(0)
            .moveTo(g3)
              ;

  cp5.addSlider("IR2 - Distance")
    .setPosition(10, 40)
      .setSize(100, 20)
        .setRange(0, 255)
          .setValue(0)
            .moveTo(g3)
              ;

  // group number 3, contains a bang and a slider
  Group g4 = cp5.addGroup("FLEX")
    .setBackgroundColor(color(0, 64))
      .setBackgroundHeight(150)
        ;



  cp5.addSlider("Flex 1")
    .setPosition(10, 20)
      .setSize(100, 20)
        .setRange(0, 255)
          .setValue(255)
            .moveTo(g4)
              ;

  cp5.addSlider("Flex 2")
    .setPosition(10, 50)
      .setSize(100, 20)
        .setRange(0, 255)
          .setValue(200)
            .moveTo(g4)
              ;

  // create a new accordion
  // add g1, g2, and g3 to the accordion.
  accordion = cp5.addAccordion("acc")
    .setPosition(10, 5)
      .setWidth(200)
        .addItem(g1)
          .addItem(g2)
            .addItem(g3)
              .addItem(g4)

                ;

  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      accordion.open(0, 1, 2);
    }
  }
  , 'o');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      accordion.close(0, 1, 2);
    }
  }
  , 'c');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      accordion.setWidth(300);
    }
  }
  , '1');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      accordion.setPosition(0, 0);
      accordion.setItemHeight(190);
    }
  }
  , '2'); 
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      accordion.setCollapseMode(ControlP5.ALL);
    }
  }
  , '3');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      accordion.setCollapseMode(ControlP5.SINGLE);
    }
  }
  , '4');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      cp5.remove("myGroup1");
    }
  }
  , '0');

  accordion.open(0, 2, 3);
  //  accordion.setPosition(0,0);accordion.setItemHeight(190);

  // use Accordion.MULTI to allow multiple group 
  // to be open at a time.
  accordion.setCollapseMode(Accordion.MULTI);

  // when in SINGLE mode, only 1 accordion  
  // group can be open at a time.  
  // accordion.setCollapseMode(Accordion.SINGLE);
}



