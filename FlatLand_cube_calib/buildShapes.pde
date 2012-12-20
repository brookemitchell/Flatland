
void drawcompass(float heading, int circlex, int circley, int circlediameter) {
  noStroke();
  ellipse(circlex, circley, circlediameter, circlediameter);
  fill(#ff0000);
  ellipse(circlex, circley, circlediameter/20, circlediameter/20);
  stroke(#ff0000);
  strokeWeight(4);
  line(circlex, circley, circlex - circlediameter/2 * sin(-heading), circley - circlediameter/2 * cos(-heading));
  noStroke();
  fill(#ffffff);
  textAlign(CENTER, BOTTOM);
  text("N", circlex, circley - circlediameter/2 - 10);
  textAlign(CENTER, TOP);
  text("S", circlex, circley + circlediameter/2 + 10);
  textAlign(RIGHT, CENTER);
  text("W", circlex - circlediameter/2 - 10, circley);
  textAlign(LEFT, CENTER);
  text("E", circlex + circlediameter/2 + 10, circley);
}

void drawAngle(float angle, int circlex, int circley, int circlediameter, String title) {
  angle = angle + PI/2;
  
  noStroke();
  ellipse(circlex, circley, circlediameter, circlediameter);
  fill(#ff0000);
  strokeWeight(4);
  stroke(#ff0000);
  line(circlex - circlediameter/2 * sin(angle), circley - circlediameter/2 * cos(angle), circlex + circlediameter/2 * sin(angle), circley + circlediameter/2 * cos(angle));
  noStroke();
  fill(#ffffff);
  textAlign(CENTER, BOTTOM);
  text(title, circlex, circley - circlediameter/2 - 30);
}

void drawBoxes(){}
