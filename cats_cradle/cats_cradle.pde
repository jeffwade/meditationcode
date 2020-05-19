color black;
color white;
color red;
color highlight;
int bgOpacity = 25;
int fgOpacity = 95;

boolean initialized = false;

int s = 0;
int diameter = 6;
int radius = diameter/2;
int x1, x2, y1, y2;

int shapeType = 1;


void setup() {
  size(600, 600);
  
  // Set modes
  colorMode(HSB, 360, 100, 100);
  ellipseMode(CORNERS);
  rectMode(CORNERS);
  
  // Initialize variables
  black = color(0, 0, 0);
  white = color(0, 0, 100);
  red = color(0, 100, 100);
  highlight = color(162, 100, 100);
  
  // Set initial styling
  background(black);
  fill(highlight, fgOpacity);
  stroke(black);
  strokeWeight(3);
  
  noLoop();
}

void draw() {
  // With noLoop() in setup and loop() on mousePressed()
  // Run draw() once to setup, then wait for a mouse click.
  // This setup avoids the appearance of the first shape at the origin
  if (!initialized) {
    initialized = true;
  } else {
    
    switch(shapeType%2) {
      case 1:
        if (mouseX <= width/2) {
          x1 = mouseX + 10;
        } else {
          x1 = mouseX - 10;
        }
        
        if (mouseY <= height/2) {
          y1 = mouseY + 10;
        } else {
          y1 = mouseY - 10;
        }
        
        x2 = width - x1;
        y2 = height - y1;
          
          
        rect(x1, y1, x2, y2);
        
        pushStyle();
          noStroke();
          fill(white);
          ellipse(mouseX - radius, mouseY - radius, mouseX + radius, mouseY + radius);
          ellipse(width - (mouseX - radius), mouseY - radius, width - (mouseX + radius), mouseY + radius);
          ellipse(mouseX - radius, height - (mouseY - radius), mouseX + radius, height - (mouseY + radius));
          ellipse(width - (mouseX - radius), height - (mouseY - radius), width - (mouseX + radius), height - (mouseY + radius));
        popStyle();
        
        break;
        
        case 0:
          ellipse(mouseX, mouseY, width - mouseX, height - mouseY);
          pushStyle();
            noStroke();
            fill(white);
            rect(mouseX - radius, mouseY - radius, mouseX + radius, mouseY + radius);
            rect(width - (mouseX - radius), mouseY - radius, width - (mouseX + radius), mouseY + radius);
            rect(mouseX - radius, height - (mouseY - radius), mouseX + radius, height - (mouseY + radius));
            rect(width - (mouseX - radius), height - (mouseY - radius), width - (mouseX + radius), height - (mouseY + radius));
          popStyle();
        break;
    }
    pushStyle();
          fill(black, bgOpacity);
          noStroke();
          rect(0,0,width,height);
       popStyle(); 
  }
}

void mousePressed() {
  loop();
  shapeType++;
  noCursor();
  
}

void mouseReleased() {
  shapeType++;
}
