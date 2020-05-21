
color black, white, primary, secondary, bgColor;
int scrimOpacity, fgOpacity;

boolean initialized;

int reps;

PVector initPos, center, leader, displacement, amplitude, radius, angle, frequency;

void setup() {
  size(600,600);
  
  // Drawing modes
  ellipseMode(RADIUS);
  
  // Color settings
  colorMode(HSB, 360, 100, 100);
  black = color(0, 0, 0);
  white = color(0, 0, 100);
  primary = color(162, 100, 100); // green
  secondary = color(12, 87, 100);  // red
  
  // Initialize 
  center = new PVector(width/2, height/2);
  leader = new PVector(mouseX, mouseY);
  displacement = new PVector(0, 0);
  initPos = center;
  
  radius = new PVector(35, 8);
  amplitude = new PVector(width/2 - 75, height/2 - 75);
  frequency = new PVector(20, 20);
  angle = new PVector(0,0);
  
  // Initial styles
  background(bgColor);
  stroke(bgColor);
  strokeWeight(2);
  bgColor = black;
  scrimOpacity = 10;
  fgOpacity = 65;
  
  reps = 5;
  frameRate(48);
}

void draw() {
  weave(new PVector(center.x, center.y), 0);
  weave(new PVector(width - center.x, center.y), PI/5);
  weave(new PVector(center.x, center.y), 2*PI/5);
  weave(new PVector(center.x, center.y), 3*PI/5);
  weave(new PVector(center.x, center.y), 4*PI/5);
  backgroundBlur();
  breathe();
}

void weave(PVector translation, float rotation) {  
  pushMatrix();
  
  translate(translation.x, translation.y);
  rotate(rotation);
  
    pushStyle();
      fill(secondary, fgOpacity);
      for (int i = 1; i <= reps; i++) {
        angle.x = radians(frameCount * frequency.x)/24;
        angle.y = PI/5;
      
        // Follow the leader
        leader.x = center.x + amplitude.x*(float)Math.cos(angle.x);
        leader.y = center.y + amplitude.y*(float)Math.sin(angle.x);
        
        // displacer
        //displacement.y = (height/2 - 75)*(float)Math.sin(angle/30 + 6*PI/5);
        displacement.x = amplitude.x*(float)Math.cos(angle.x*i);
        displacement.y = amplitude.y*(float)Math.sin(angle.x + i*angle.y);
        
        ellipse(displacement.x/i, displacement.y, radius.y, radius.y);
        ellipse(-displacement.x/i, displacement.y, radius.y, radius.y);
        ellipse(displacement.x/i, -displacement.y, radius.y, radius.y);
        ellipse(-displacement.x/i, -displacement.y, radius.y, radius.y);
      }
    popStyle();
    
  popMatrix();
  
}

void breathe(){
    pushStyle();
    float anchorRadius = displacement.y/45;
    fill(white, 25);
    noStroke();
    ellipse(35, 35, anchorRadius, anchorRadius);
    ellipse(width - 35, 35, anchorRadius, anchorRadius);
    ellipse(35, height - 35, anchorRadius, anchorRadius);
    ellipse(width - 35, height - 35, anchorRadius, anchorRadius);
    ellipse(center.x, center.y, anchorRadius, anchorRadius);
  popStyle();
}

void backgroundBlur(){
  pushStyle();
    fill(bgColor, scrimOpacity);
    noStroke();
    rect(0, 0, width, height);
  popStyle();
}
