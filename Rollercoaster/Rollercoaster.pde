import java.util.*;

//CONSTANTS
PFont myFont;
int gap = 20;
int buttonHeight = 50;
int buttonWidth = (1400 - 5 * gap) / 4;
int buttonHeightStart = 700 - gap - buttonHeight;
int buttonRadius = 10;
int doneWidth = 120;
String[] tracks = {"Horizontal Track", "Curved Track", "Loop", "Spring"};
String[][] tracksDescription = { {"Please select a starting point", "Please select a length for the ending point"},
                                 {"Please select a starting point", "Please select an ending point"},
                                 {"Please select a starting point", "Please select a height for the center" },
                                 {"Please select a starting point", "Please select a length for the ending point"}};

//VARYING
String displayedText = "Welcome! Please select a track to begin";
int currentPage; //0 is start menu, 1 is build stage, 2 is simulation, 3 is how to play
int trackToConfirm; //0 is none, 1 horizontal track, 2 is curved track, 3 is loop, 4 is spring
int currentTrack; //0 is none, 1 horizontal track, 2 is curved track, 3 is loop, 4 is spring
boolean trackConfirmed = false;
ArrayList<int[]> pointsToDisplay = new ArrayList<int[]>();
int currentPrompt = 0;
ArrayList<Track> allTracks = new ArrayList<Track>(); 
int[] info = new int[4];
float springWidth = 10;
Cart cart;
int currentTrackSim = 0;
int start = 0;
boolean loopCompleted = false;

//-------------------------------------MAIN FUNCTIONS-----------------------

void setup(){
  size(1400,700);
  frameRate(240);
  currentPage = 0;
  currentTrack = 0;
  myFont = createFont("Century", 32);
  textFont(myFont);
  allTracks.add(new Track(0 + gap, 100 + gap, 0 + gap, 110 + gap, 0, 5));
  makeCart();
}

void makeCart(){
  Track first = allTracks.get(0);
  int x = (first.xstart + first.xfinish) / 2, y = (first.ystart + first.yfinish) / 2;
  float ang = calculateCurvedTrackAngle(first);
  
  float x1 = first.xstart, y1 = first.ystart, x2 = first.xfinish, y2 = first.yfinish;
  float d = (y2-y1)/3.0, u = y1 + d, v = (3*y1) + (2*d) + y2, w = (y1 + y2)*(y1 + d), j = (3*x1) + x2, k = (x1*x1) + (x1*x2);
  float h = (2*u*u) + (2*d*d) - (u*v) + w - (2*x1*x1) + k, i = (4*u) - v, l = (4*x1) - j;
  float m = (l*l) + (i*i), n = (2*h*l) - (2*i*i*x1), o = (h*h) - (i*i*d*d) + (i*i*x1*x1);
  float a = ((-1 * n) + sqrt((n*n) - (4*m*o)))/(2*m);
  float b = y1 + d - sqrt((d*d) - ((a-x1)*(a-x1)));
  
  float a1 = a * cos(ang) + b * sin(ang), b1 = -1 * a * sin(ang) + b * cos(ang);
  
  
  
  cart = new Cart(a1 + 10, b, ang);
}

void draw(){
  if(currentPage == 0){
    runStartMenu();
  }
  else if(currentPage == 1){
    runBuildStage();
  }
  else if(currentPage == 2){
    runSimulation();
  }
  else{
    runHowToPlay();
  }
}



//--------------------------------START MENU-------------------------------




void runStartMenu(){
  clear();
  colorMode(HSB,360,100,100);
  background(200, 18, 100);
  colorMode(RGB,255,255,255);
  int x_len = 300;
  int y_len = 100;
  
  fill(31,115,255);
  textSize(72);
  textAlign(CENTER, CENTER);
  text("Build Your Own Rollercoaster", width/2, height/3);
  
  if(mouseX > 700 - (x_len / 2) && mouseX < 700 + (x_len / 2) && mouseY > 450 - (y_len / 2) && mouseY < 450 + (y_len / 2)){
    fill(252,143,161);
    stroke(252,143,161);
    rect(700 - (x_len / 2), 450 - (y_len / 2), x_len, y_len, buttonRadius);
    textAlign(CENTER, CENTER);
    fill(255,255,255);
    textSize(38);
    text("Start Drawing", 700, 450);
  }
  else{
    fill(255,182,193);
    stroke(255,182,193);
    rect(700 - (x_len / 2), 450 - (y_len / 2), x_len, y_len, buttonRadius);
    textAlign(CENTER, CENTER);
    fill(255,255,255);
    textSize(38);
    text("Start Drawing", 700, 450);
  }
  
  if(mouseX > 700 - (x_len / 2) && mouseX < 700 + (x_len / 2) && mouseY > 575 - (y_len / 2) && mouseY < 575 + (y_len / 2)){
    fill(252,143,161);
    stroke(252,143,161);
    rect(700 - (x_len / 2), 575 - (y_len / 2), x_len, y_len, buttonRadius);
    textAlign(CENTER, CENTER);
    fill(255,255,255);
    textSize(38);
    text("How to Play", 700, 575);
  }
  else{
    fill(255,182,193);
    stroke(255,182,193);
    rect(700 - (x_len / 2), 575 - (y_len / 2), x_len, y_len, buttonRadius);
    textAlign(CENTER, CENTER);
    fill(255,255,255);
    textSize(38);
    text("How to Play", 700, 575);
  }
}


//------------------------------------------BUILD FUNCTIONS---------------------------------------


void runBuildStage(){
  clear();
  colorMode(HSB,360,100,100);
  background(200, 18, 100);
  colorMode(RGB,255,255,255);
  
  
  //Display
  generateScreen();
  generateTextWindow();
  updateTextWindow();
  displayPoints();
  displayTracks();
  
  //Mouse functions to highlight
  checkMouseOnButton();
  checkMouseOnDone();
  checkMouseOnTrack();
  
  displayCart();
}

void checkMouseOnButton(){
  int mouseOver = 0;
  strokeWeight(1);
  for(int i = gap; i < 1400; i+=buttonWidth + gap){
    if(mouseX > i && mouseX < i + buttonWidth && mouseY > buttonHeightStart && mouseY < buttonHeightStart + buttonHeight){
      mouseOver = i;
    }
  }
  textAlign(CENTER, TOP);
  if(mouseOver != 0){
    for(int i = gap; i < 1400; i+=buttonWidth + gap){
      if(i == mouseOver){
        fill(173,177,255);
        stroke(173,177,255);
        rect(i, buttonHeightStart, buttonWidth, buttonHeight, buttonRadius);
      }
      else{
        fill(202,184,255);
        stroke(202,184,255);
        rect(i, buttonHeightStart, buttonWidth, buttonHeight, buttonRadius);
      }
      fill(255,255,255);
      text(tracks[ (i - gap) / (buttonWidth + gap) ], i + (buttonWidth/2), buttonHeightStart);
    }
  }
  else{
    for(int i = gap; i < 1400; i+=buttonWidth + gap){
      fill(202,184,255);
      stroke(202,184,255);
      rect(i, buttonHeightStart, buttonWidth, buttonHeight, buttonRadius);
      fill(255,255,255);
      text(tracks[ (i - gap) / (buttonWidth + gap) ], i + (buttonWidth/2), buttonHeightStart);
      
    }
  }
}

void checkMouseOnDone(){
  int x_left = 1400 - gap - doneWidth, x_right = 1400 - gap, y_top = 700 - gap - buttonHeight - 5 - buttonHeight, y_bottom = 700 - gap - buttonHeight - 5;  
  if(mouseY > y_top && mouseY < y_bottom && mouseX > x_left && mouseX < x_right){
    fill(255,108,224);
    stroke(255,108,224);
  }
  else{
    fill(255,178,238);
    stroke(255,178,238);
  }
  strokeWeight(1);
  rect(x_left, y_top, x_right - x_left, y_bottom - y_top, buttonRadius);
  fill(255);
  textAlign(CENTER, CENTER);
  text("Done", (x_left + x_right) / 2, (y_top + y_bottom) / 2);
}

void checkMouseOnTrack(){
  int x = mouseX, y = mouseY;
  if(allTracks.size() > 0 && trackConfirmed){
    Track prev = allTracks.get(allTracks.size() - 1);
    int xfinish = prev.xfinish, yfinish = prev.yfinish;
    if(x > xfinish - 10 && x < xfinish + 10 && y > yfinish - 10 && y < yfinish + 10){
      fill(0,256,0);
      stroke(0,256,0);
      strokeWeight(1);
      ellipse(xfinish, yfinish, 10, 10);
    }
  }
}

void generateScreen(){
  int x_left = gap, x_right = 1400 - gap, y_top = gap, y_bottom = 700 - gap - buttonHeight - 5 - buttonHeight - 5;
  fill(255);
  stroke(255);
  strokeWeight(1);
  rect(x_left, y_top, 1400 - gap * 2, y_bottom - y_top, buttonRadius); 
}

void generateTextWindow(){
  int x_left = gap, x_right = 1400 - gap - doneWidth - 5, y_top = 700 - gap - buttonHeight - 5 - buttonHeight, y_bottom = 700 - gap - buttonHeight - 5;
  fill(255,178,238);
  stroke(255,178,238);
  strokeWeight(1);
  rect(x_left, y_top, x_right - x_left, buttonHeight, buttonRadius);
}

void trackBuildAction(int x, int y){
  int track = currentTrack - 1;
  //System.out.println(currentTrack);
  if(track == 0){
    buildHorizontalTrack(x, y);
  }
  else if(track == 1){
    buildCurvedTrack(x, y);
  }
  else if(track == 2){
    buildLoop(x, y);
  }
  else if(track == 3){
    buildSpring(x, y);
  }
}

void buildHorizontalTrack(int x, int y){
  String[] instructions = tracksDescription[currentTrack - 1];
  if(currentPrompt == 0){
    if(allTracks.size() > 0){
      Track prev = allTracks.get(allTracks.size() - 1);
      int xfinish = prev.xfinish, yfinish = prev.yfinish;
      if(x > xfinish - 10 && x < xfinish + 10 && y > yfinish - 10 && y < yfinish + 10){
        info[0] = xfinish;
        info[1] = yfinish;
        int[] new_info = {xfinish, yfinish, 10};
        pointsToDisplay.add(new_info);
        currentPrompt++;
        displayedText = tracks[currentTrack - 1] + ": " + instructions[1];  
      }
      else{
        displayedText = "Error: Starting point must be the ending point of the last track you placed";
      }
    }
    else{
      info[0] = x;
      info[1] = y;
      int[] new_info = {x, y, 10};
      pointsToDisplay.add(new_info);
      currentPrompt++;
      displayedText = tracks[currentTrack - 1] + ": " + instructions[1];
    }
    
  }
  else if(currentPrompt == 1){
    info[2] = x;
    info[3] = info[1];
    currentTrack = 0;
    int[] new_info = {x, info[1], 10};
    pointsToDisplay.add(new_info);
    trackToConfirm = 0;
    trackConfirmed = false;
    currentPrompt = 0;
    displayedText = "Horizontal track added! Please select another track or click Done";
    currentPrompt++;
    allTracks.add(new Track (info[0], info[2], info[1], info[1], 0, 1));
  }
  
}

void buildCurvedTrack(int x, int y){
  String[] instructions = tracksDescription[currentTrack - 1];
  if(currentPrompt == 0){
    if(allTracks.size() > 0){
      Track prev = allTracks.get(allTracks.size() - 1);
      int xfinish = prev.xfinish, yfinish = prev.yfinish;
      if(x > xfinish - 10 && x < xfinish + 10 && y > yfinish - 10 && y < yfinish + 10){
        info[0] = xfinish;
        info[1] = yfinish;
        int[] new_info = {xfinish, yfinish, 10};
        pointsToDisplay.add(new_info);
        currentPrompt++;
        displayedText = tracks[currentTrack - 1] + ": " + instructions[1];  
      }
      else{
        displayedText = "Error: Starting point must be the ending point of the last track you placed";
      }
    }
    else{
      info[0] = x;
      info[1] = y;
      int[] new_info = {x, y, 10};
      pointsToDisplay.add(new_info);
      currentPrompt++;
      displayedText = tracks[currentTrack - 1] + ": " + instructions[1];
    }
    
  }
  else if(currentPrompt == 1){
    if( abs(x - info[0]) >= 2 * abs((y - info[1]) / 3)){
      info[2] = x;
      info[3] = y;
      currentTrack = 0;
      int[] new_info = {x, y, 10};
      pointsToDisplay.add(new_info);
      trackToConfirm = 0;
      trackConfirmed = false;
      currentPrompt = 0;
      displayedText = "Curved track added! Please select another track or click Done";
      currentPrompt++;
      allTracks.add(new Track (info[0], info[2], info[1], info[3], 0, 2));
    }
    else{
      displayedText = "Error: This path is too steep!";
    }
    
  }
}

void buildLoop(int x, int y){
  String[] instructions = tracksDescription[currentTrack - 1];
  if(currentPrompt == 0){
    if(allTracks.size() > 0){
      Track prev = allTracks.get(allTracks.size() - 1);
      int xfinish = prev.xfinish, yfinish = prev.yfinish;
      if(x > xfinish - 10 && x < xfinish + 10 && y > yfinish - 10 && y < yfinish + 10){
        if(prev.type == 2 || prev.type == 3){
          displayedText = "Error: Loop cannot be added onto another loop or a spring!";
        }
        else{
          info[0] = xfinish;
          info[1] = yfinish;
          int[] new_info = {xfinish, yfinish, 10};
          pointsToDisplay.add(new_info);
          currentPrompt++;
          displayedText = tracks[currentTrack - 1] + ": " + instructions[1];
        }
          
      }
      else{
        displayedText = "Error: Starting point must be the ending point of the last track you placed";
      }
    }
    else{
      info[0] = x;
      info[1] = y;
      int[] new_info = {x, y, 10};
      pointsToDisplay.add(new_info);
      currentPrompt++;
      displayedText = tracks[currentTrack - 1] + ": " + instructions[1];
    }
    
  }
  else if(currentPrompt == 1){
    if(y < info[1]){
      info[2] = info[0];
      info[3] = y;
      currentTrack = 0;
      //int[] new_info = {info[0], info[1], 10};
      //pointsToDisplay.add(new_info);
      trackToConfirm = 0;
      trackConfirmed = false;
      currentPrompt = 0;
      displayedText = "Loop added! Please select another track or click Done";
      currentPrompt++;
      allTracks.add(new Track (info[0], info[0], info[1], info[1], info[1] - info[3], 3));
    }
    else{
      displayedText = "Error: center must be above the starting point";
    }
  }
}













void buildSpring(int x, int y){
  String[] instructions = tracksDescription[currentTrack - 1];
  
  if(allTracks.size() > 0 && (allTracks.get(allTracks.size() - 1)).type == 1){
    Track prev = allTracks.get(allTracks.size() - 1);
    int xfinish = prev.xfinish, yfinish = prev.yfinish;
    if(currentPrompt == 0){
      if(x > xfinish - 10 && x < xfinish + 10 && y > yfinish - 10 && y < yfinish + 10){
        info[0] = xfinish;
        info[1] = yfinish;
        int[] new_info = {xfinish, yfinish, 10};
        pointsToDisplay.add(new_info);
        currentPrompt++;
        displayedText = tracks[currentTrack - 1] + ": " + instructions[1];  
      }
      else{
        displayedText = "Error: Starting point must be the ending point of the last track you placed";
      }
    }
    else if(currentPrompt == 1){
      if(abs(xfinish - prev.xstart) > abs(x - info[0])){
        if((xfinish - prev.xstart) * (x - info[0]) < 0){
          if(Math.abs(x - info[0]) > 10){
            info[2] = x;
            info[3] = info[1];
            currentTrack = 0;
            int[] new_info = {info[2], info[3], 10};
            pointsToDisplay.add(new_info);
            trackToConfirm = 0;
            trackConfirmed = false;
            currentPrompt = 0;
            displayedText = "Spring added! Please select another track or click Done";
            currentPrompt++;
            allTracks.add(new Track (info[0], info[2], info[1], info[3], 0, 4));
          }
          else{
            displayedText = "Error: Spring must be more than ten pixels long";
          }
          
        }
        else{
          displayedText = "Error: Spring must be in the same direction as the horizontal track it hovers above";
        }
      }
      else{
        displayedText = "Error: Spring cannot be longer than the horizontal track it hovers above";
      }
    }
  }
  else{
    displayedText = "Error: A spring must be placed above a horizontal track";
  }
}

void displayPoints(){
  fill(0);
  stroke(0);
  for(int i = 0; i < pointsToDisplay.size(); i++){
    int[] info1 = pointsToDisplay.get(i);
    ellipse(info1[0], info1[1], info1[2], info1[2]);
  }
}

void displayTracks(){
  for(int i = 0; i < allTracks.size(); i++){
    Track current = allTracks.get(i);
    display(current);
    //System.out.println(i);
  }
}

void display(Track obj){
  int type = obj.type;
  int xstart = obj.xstart;
  int xfinish = obj.xfinish;
  int ystart = obj.ystart;
  int yfinish = obj.yfinish;
  //System.out.println(type);
  if (type == 1) {
    //System.out.println("making a horizontal track!");
    strokeWeight(4);
    fill(0);
    stroke(0);
    line(xstart, ystart, xfinish, yfinish);
    ellipse(xstart, ystart, 10, 10);
    ellipse(xfinish, yfinish, 10, 10);
  }
  else if (type == 2) {
    displayCurvedTrack(obj);
  }
  else if (type == 3) {
    displayLoop(obj);
  }
  else if (type == 4) {
    int n = Math.abs((obj.xfinish - obj.xstart) / 10);
    displaySpring(obj, n);
  }
  else if(type == 5){
    displayStartingPlatform(obj);
  }
  
}

void displayCurvedTrack(Track obj){
  float x1 = obj.xstart, y1 = obj.ystart, x2 = obj.xfinish, y2 = obj.yfinish;
  noFill();
  stroke(0);
  strokeWeight(4);
  //System.out.println(x1 + "," + y1 + " : " + x2 + " : " + y2);
  if(y1 < y2 && x1 < x2){
    float d = (y2-y1)/3.0, u = y1 + d, v = (3*y1) + (2*d) + y2, w = (y1 + y2)*(y1 + d), j = (3*x1) + x2, k = (x1*x1) + (x1*x2);
    float h = (2*u*u) + (2*d*d) - (u*v) + w - (2*x1*x1) + k, i = (4*u) - v, l = (4*x1) - j;
    float m = (l*l) + (i*i), n = (2*h*l) - (2*i*i*x1), o = (h*h) - (i*i*d*d) + (i*i*x1*x1);
    float a = ((-1 * n) + sqrt((n*n) - (4*m*o)))/(2*m);
    float b = y1 + d - sqrt((d*d) - ((a-x1)*(a-x1)));
    float angle = asin((a-x1)/d);
    //System.out.println(d + " : " + (a - x1));
    arc(x1, y1+d, 2*d, 2*d, PI + HALF_PI, PI + HALF_PI + angle);
    arc(x2, y2-d, 2*d, 2*d, HALF_PI, HALF_PI+angle);
    line(a,b,x2+x1-a, y1+y2-b);
    fill(0);
    stroke(0);
  }
  else if(y1 > y2 && x1 < x2){//bottom left to top right
    //System.out.println("this one");
    float d = (y1-y2)/3.0, u = y1 - d, v = (3*y1) - (2*d) + y2, w = (y1 + y2)*(y1 - d), j = (3*x1) + x2, k = (x1*x1) + (x1*x2);
    float h = (2*u*u) + (2*d*d) - (u*v) + w - (2*x1*x1) + k, i = v - (4*u), l = (4*x1) - j;
    float m = (l*l) + (i*i), n = (2*h*l) - (2*i*i*x1), o = (h*h) - (i*i*d*d) + (i*i*x1*x1);
    float a = ((-1 * n) + sqrt((n*n) - (4*m*o)))/(2*m);
    float b = y1 - d + sqrt((d*d) - ((a-x1)*(a-x1)));
    float angle = asin((a-x1)/d);
        
    //System.out.println(b + " : " + y1);
    
    arc(x1, y1-d, 2* d, 2* d, HALF_PI - angle, HALF_PI);
    arc(x2, y2+d, 2* d, 2* d, PI + HALF_PI - angle, PI + HALF_PI);

    line(a, b, x2+x1-a, y1+y2-b);
    fill(0);
    stroke(0);
  }
  else if(y1 < y2 && x1 > x2){//top right to bottom left
    float tempx = x2, tempy = y2;
    x2 = x1;
    y2 = y1;
    x1 = tempx;
    y1 = tempy;
    float d = (y1-y2)/3.0, u = y1 - d, v = (3*y1) - (2*d) + y2, w = (y1 + y2)*(y1 - d), j = (3*x1) + x2, k = (x1*x1) + (x1*x2);
    float h = (2*u*u) + (2*d*d) - (u*v) + w - (2*x1*x1) + k, i = v - (4*u), l = (4*x1) - j;
    float m = (l*l) + (i*i), n = (2*h*l) - (2*i*i*x1), o = (h*h) - (i*i*d*d) + (i*i*x1*x1);
    float a = ((-1 * n) + sqrt((n*n) - (4*m*o)))/(2*m);
    float b = y1 - d + sqrt((d*d) - ((a-x1)*(a-x1)));
    float angle = asin((a-x1)/d);
        
    //System.out.println(b + " : " + y1);
    
    arc(x1, y1-d, 2* d, 2* d, HALF_PI - angle, HALF_PI);
    arc(x2, y2+d, 2* d, 2* d, PI + HALF_PI - angle, PI + HALF_PI);

    line(a, b, x2+x1-a, y1+y2-b);
    fill(0);
    stroke(0);
  }
  else if(y1 > y2 && x1 > x2){ //WORKS
    float d = (y1-y2)/3.0, u = y2 + d, v = (3*y2) + (2*d) + y1, w = (y2 + y1)*(y2 + d), j = (3*x2) + x1, k = (x2*x2) + (x1*x2);
    float h = (2*u*u) + (2*d*d) - (u*v) + w - (2*x2*x2) + k, i = (4*u) - v, l = (4*x2) - j;
    float m = (l*l) + (i*i), n = (2*h*l) - (2*i*i*x2), o = (h*h) - (i*i*d*d) + (i*i*x2*x2);
    float a = ((-1 * n) + sqrt((n*n) - (4*m*o)))/(2*m);
    float b = y2 + d - sqrt((d*d) - ((a-x2)*(a-x2)));
    float angle = asin((a-x2)/d);
    //System.out.println(d + " : " + (a - x1));
    arc(x2, y2+d, 2*d, 2*d, PI + HALF_PI, PI + HALF_PI + angle);
    arc(x1, y1-d, 2*d, 2*d, HALF_PI, HALF_PI+angle);
    line(a,b,x1+x2-a, y1+y2-b);
    fill(0);
    stroke(0);
    
  }
  
  ellipse(obj.xstart, obj.ystart, 10, 10);
  ellipse(obj.xfinish, obj.yfinish, 10, 10);
}

void displayLoop(Track obj){
  strokeWeight(4);
  float x1 = obj.xstart, y1 = obj.ystart, r = obj.radius;
  noFill();
  ellipse(x1,y1 - r, 2 * r, 2 * r);
  fill(0);
  ellipse(obj.xfinish, obj.yfinish, 10, 10);
}

void displaySpring(Track obj, int n){
  int x1 = obj.xstart, y = obj.ystart, x2 = obj.xfinish;
  int direction = (x2 - x1) / Math.abs(x2 - x1);
  //System.out.println(direction);
  for(int i = 0; i < n; i++){
    //System.out.println(i);
    noFill();
    strokeWeight(4);
    beginShape();
    vertex(x1 + i * (direction * obj.springWidth),y);
    quadraticVertex(x1 + i * (direction * obj.springWidth)+ direction * obj.springWidth/2, y - 100, x1 + i * (direction * obj.springWidth)+ direction * obj.springWidth, y);
    endShape();
  }
  ellipse(obj.xfinish, obj.yfinish, 10, 10);
}

void displayStartingPlatform(Track obj){
  float x1 = obj.xstart, y1 = obj.ystart, x2 = obj.xfinish, y2 = obj.yfinish;
  float a = 0,b = 0;
  noFill();
  stroke(0,256,0);
  strokeWeight(4);
  //System.out.println(x1 + "," + y1 + " : " + x2 + " : " + y2);
  if(y1 < y2 && x1 < x2){
    float d = (y2-y1)/3.0, u = y1 + d, v = (3*y1) + (2*d) + y2, w = (y1 + y2)*(y1 + d), j = (3*x1) + x2, k = (x1*x1) + (x1*x2);
    float h = (2*u*u) + (2*d*d) - (u*v) + w - (2*x1*x1) + k, i = (4*u) - v, l = (4*x1) - j;
    float m = (l*l) + (i*i), n = (2*h*l) - (2*i*i*x1), o = (h*h) - (i*i*d*d) + (i*i*x1*x1);
    a = ((-1 * n) + sqrt((n*n) - (4*m*o)))/(2*m);
    b = y1 + d - sqrt((d*d) - ((a-x1)*(a-x1)));
    float angle = asin((a-x1)/d);
    //System.out.println(d + " : " + (a - x1));
    //arc(x1, y1+d, 2*d, 2*d, PI + HALF_PI, PI + HALF_PI + angle);
    arc(x2, y2-d, 2*d, 2*d, HALF_PI, HALF_PI+angle);
    line(a,b,x2+x1-a, y1+y2-b);
    fill(0);
    stroke(0);
  }
  
  ellipse(a, b, 10, 10);
  ellipse(obj.xfinish, obj.yfinish, 10, 10);
}

float calculateCurvedTrackAngle(Track obj){
  float x1 = obj.xstart, y1 = obj.ystart, x2 = obj.xfinish, y2 = obj.yfinish;
  noFill();
  stroke(0);
  strokeWeight(4);
  //System.out.println(x1 + "," + y1 + " : " + x2 + " : " + y2);
  if(y1 < y2 && x1 < x2){
    float d = (y2-y1)/3.0, u = y1 + d, v = (3*y1) + (2*d) + y2, w = (y1 + y2)*(y1 + d), j = (3*x1) + x2, k = (x1*x1) + (x1*x2);
    float h = (2*u*u) + (2*d*d) - (u*v) + w - (2*x1*x1) + k, i = (4*u) - v, l = (4*x1) - j;
    float m = (l*l) + (i*i), n = (2*h*l) - (2*i*i*x1), o = (h*h) - (i*i*d*d) + (i*i*x1*x1);
    float a = ((-1 * n) + sqrt((n*n) - (4*m*o)))/(2*m);
    float b = y1 + d - sqrt((d*d) - ((a-x1)*(a-x1)));
    float angle = asin((a-x1)/d);
    return atan((x1+x2-2*a)/(y1+y2-2*b));
  }
  else if(y1 > y2 && x1 < x2){//bottom left to top right
    //System.out.println("this one");
    float d = (y1-y2)/3.0, u = y1 - d, v = (3*y1) - (2*d) + y2, w = (y1 + y2)*(y1 - d), j = (3*x1) + x2, k = (x1*x1) + (x1*x2);
    float h = (2*u*u) + (2*d*d) - (u*v) + w - (2*x1*x1) + k, i = v - (4*u), l = (4*x1) - j;
    float m = (l*l) + (i*i), n = (2*h*l) - (2*i*i*x1), o = (h*h) - (i*i*d*d) + (i*i*x1*x1);
    float a = ((-1 * n) + sqrt((n*n) - (4*m*o)))/(2*m);
    float b = y1 - d + sqrt((d*d) - ((a-x1)*(a-x1)));
    float angle = asin((a-x1)/d);
        
    //System.out.println(b + " : " + y1);
    
    return atan((x1+x2-2*a)/(y1+y2-2*b));
  }
  else if(y1 < y2 && x1 > x2){//top right to bottom left
    float tempx = x2, tempy = y2;
    x2 = x1;
    y2 = y1;
    x1 = tempx;
    y1 = tempy;
    float d = (y1-y2)/3.0, u = y1 - d, v = (3*y1) - (2*d) + y2, w = (y1 + y2)*(y1 - d), j = (3*x1) + x2, k = (x1*x1) + (x1*x2);
    float h = (2*u*u) + (2*d*d) - (u*v) + w - (2*x1*x1) + k, i = v - (4*u), l = (4*x1) - j;
    float m = (l*l) + (i*i), n = (2*h*l) - (2*i*i*x1), o = (h*h) - (i*i*d*d) + (i*i*x1*x1);
    float a = ((-1 * n) + sqrt((n*n) - (4*m*o)))/(2*m);
    float b = y1 - d + sqrt((d*d) - ((a-x1)*(a-x1)));
    float angle = asin((a-x1)/d);

    return atan((x1+x2-2*a)/(y1+y2-2*b));
  }
  else if(y1 > y2 && x1 > x2){ //WORKS
    float d = (y1-y2)/3.0, u = y2 + d, v = (3*y2) + (2*d) + y1, w = (y2 + y1)*(y2 + d), j = (3*x2) + x1, k = (x2*x2) + (x1*x2);
    float h = (2*u*u) + (2*d*d) - (u*v) + w - (2*x2*x2) + k, i = (4*u) - v, l = (4*x2) - j;
    float m = (l*l) + (i*i), n = (2*h*l) - (2*i*i*x2), o = (h*h) - (i*i*d*d) + (i*i*x2*x2);
    float a = ((-1 * n) + sqrt((n*n) - (4*m*o)))/(2*m);
    float b = y2 + d - sqrt((d*d) - ((a-x2)*(a-x2)));
    float angle = asin((a-x2)/d);
    
    
    return atan((x1+x2-2*a)/(y1+y2-2*b));
    
    
  }
  else{
   return 0; 
  }
}

//---------------------------SIMULATION FUNCTIONS-------------------------------


void runSimulation(){
  clear();
  colorMode(HSB,360,100,100);
  background(200, 18, 100);
  colorMode(RGB,255,255,255);
  textAlign(CENTER, CENTER);
  fill(0);
  //text("Simulation to come", width/2, height/2);
  
  if(mouseX > gap && mouseX < gap + 300 && mouseY > buttonHeightStart && mouseY < buttonHeightStart + buttonHeight){
    fill(252,143,161);
    stroke(252,143,161);
  }
  else{
    fill(255,182,193);
    stroke(255,182,193); 
  }
  rect(gap, buttonHeightStart, 300, buttonHeight, buttonRadius);
  fill(255);
  textAlign(CENTER, CENTER);
  text("Back", 150 + gap, (buttonHeight + buttonHeightStart + buttonHeightStart)/2);
  generateScreen();
  
  displayCart();
  if(currentTrackSim < allTracks.size()){
    updateCart();
  }
  displayPoints();
  displayTracks();
}

void displayCart(){
  float x = cart.xcor, y = cart.ycor, ang = -1*cart.angle;
  fill(0);
  //rect(width/2,height/2, 50, 50);
  pushMatrix();
  rotate(ang);
  fill(0);
  float newx = x * cos(ang) + y*sin(ang), newy = -x*sin(ang) + y * cos(ang);
  
  rect(newx - 10,newy - 10, 20, 20);
  popMatrix();
  
}

void updateCart(){
  //System.out.println((cart.yvel * cart.yvel) + (cart.xvel * cart.xvel));
  Track currTrack = allTracks.get(currentTrackSim);
  //if(start > 1){
  //  cart.xcor = currTrack.xstart + 1;
   // cart.ycor = currTrack.ystart - 10;
  //}
  int type = currTrack.type;
  float xvel = cart.xvel, yvel = cart.yvel;
  if(type == 1){
    if(currentTrackSim + 1 < allTracks.size() && (allTracks.get(currentTrackSim + 1)).type == 4){
      updateCartHorizontalSpring();
    }
    else{
      updateCartHorizontal();
    }
    
  }
  else if(type == 2 || type == 5){
    updateCartCurved();
  }
  else if(type == 3){
    updateCartLoop();
  }
  else if(type == 4){
    updateCartSpring();
  }
  
  //System.out.println(cart.ycor);
  //float vel = cart.calcVelFromKinetic(cart.ycor);
  
  ////System.out.println(vels[0]);
  //cart.xcor += vel * cos(cart.angle);
  //cart.ycor += vel * sin(cart.angle);
  //System.out.println(cart.xcor + " : "+ cart.ycor);
  
    
}

void updateCartHorizontalSpring(){
  
  Track currTrack = allTracks.get(currentTrackSim);
  Track nextTrack = allTracks.get(currentTrackSim + 1);
  Track prevTrack = allTracks.get(currentTrackSim - 1);
  
  if(prevTrack.type == 3){
    prevTrack = allTracks.get(currentTrackSim - 2);
  }
  
  int direction = Math.abs(prevTrack.xfinish - prevTrack.xstart)/(prevTrack.xfinish - prevTrack.xstart);
  
  //System.out.println(currTrack.type);
  float[] vels = cart.calcVel(cart.ycor);
  float xvel = cart.xvel, yvel = cart.yvel;
  cart.angle = 0;
  cart.yvel = 0;
  if((( cart.xcor + 10 < nextTrack.xfinish && cart.xvel > 0) || ( cart.xcor > nextTrack.xfinish && cart.xvel < 0))){
    System.out.println("calling horizontal spring! " + cart.xvel);
    cart.angle = 0;
  }
  else if ((  cart.xvel > 0 &&   cart.xcor + 10 >= nextTrack.xfinish) || ( cart.xvel < 0 && cart.xcor - 10 <= nextTrack.xfinish        )){
     currentTrackSim++;
  }
  //System.out.println(cart.xvel + " : " + cart.yvel);
  cart.xvel = direction * cos(0) * cart.calcVelFromKinetic(cart.ycor);
  cart.xcor += cart.xvel / 10;
  cart.yvel = 0;
}

void updateCartHorizontal(){
  System.out.println("calling horizontal! " + cart.xvel);
  Track currTrack = allTracks.get(currentTrackSim);
  Track prevTrack = allTracks.get(currentTrackSim - 1);
  
  if(prevTrack.type == 3){
    prevTrack = allTracks.get(currentTrackSim - 2);
  }
  
  int direction = Math.abs(prevTrack.xfinish - prevTrack.xstart)/(prevTrack.xfinish - prevTrack.xstart);
  
  
  //System.out.println(currTrack.type);
  float[] vels = cart.calcVel(cart.ycor);
  float xvel = cart.xvel, yvel = cart.yvel;
  cart.angle = 0;
  cart.yvel = 0;
  if(!(( cart.xcor  < max(currTrack.xfinish, currTrack.xstart) && vels[0] > 0) || ( cart.xcor > min(currTrack.xfinish, currTrack.xstart) && vels[0] < 0))){
    cart.angle = 0;
  }
  if (     (cart.xvel > 0 && cart.xcor >= currTrack.xfinish ) || (cart.xvel < 0 && cart.xcor <= currTrack.xfinish)   ) {
     currentTrackSim++;
  }
  //System.out.println(cart.xvel + " : " + cart.yvel);
  cart.xvel = direction*cos(0) * cart.calcVelFromKinetic(cart.ycor);
  cart.xcor += cart.xvel / 10;
  cart.yvel = 0;
}

void updateCartCurved(){
  //System.out.println("we're here!");
  Track currTrack = allTracks.get(currentTrackSim);
  
  
  float a = 0,b = 0;
  float angle = 0;
  
  float x1 = currTrack.xstart, y1 = currTrack.ystart, x2 = currTrack.xfinish, y2 = currTrack.yfinish;

  //System.out.println(x1 + "," + y1 + " : " + x2 + " : " + y2);
  if(y1 < y2 && x1 < x2){
    float d = (y2-y1)/3.0, u = y1 + d, v = (3*y1) + (2*d) + y2, w = (y1 + y2)*(y1 + d), j = (3*x1) + x2, k = (x1*x1) + (x1*x2);
    float h = (2*u*u) + (2*d*d) - (u*v) + w - (2*x1*x1) + k, i = (4*u) - v, l = (4*x1) - j;
    float m = (l*l) + (i*i), n = (2*h*l) - (2*i*i*x1), o = (h*h) - (i*i*d*d) + (i*i*x1*x1);
    a = ((-1 * n) + sqrt((n*n) - (4*m*o)))/(2*m);
    b = y1 + d - sqrt((d*d) - ((a-x1)*(a-x1)));
    angle = asin((a-x1)/d);
    System.out.println("angle: " + angle);
    float a1 = x1 + x2 - a, b1 = y1 + y2 - b;
    float x = cart.xcor, y = cart.ycor;
    
    if(x > x2){
      if (start <= 1) {
        currentTrackSim = 0;
      }
      else {
        currentTrackSim ++;
      }
      start ++;
      cart.angle = 0;
    }
    else if( x < a ){
      System.out.println("on the left arc!");
      float r = (y2 - y1) / 3;
      angle = -1*(float)Math.atan((cart.xcor-x1) / (y1 + r - cart.ycor));
      System.out.println("angle: " + angle);
      cart.angle = angle;
    }
    else if(y > b1){
      float r = (y2 - y1) / 3;
      angle = -1*atan((x2 - x) / (y - (y2 - ((y2 - y1) / 3))));
      cart.angle = angle;
    }
    else{
      System.out.println("in the middle!");
    }
    float vel = cart.calcVelFromKinetic(cart.ycor);
    cart.xvel = cos(angle) * (vel);
    cart.yvel = Math.abs(sin(angle) * (vel));
    cart.xcor += cart.xvel / 10;
    cart.ycor += cart.yvel / 10;
    //THIS WORKS
  }
  
  
  else if(y1 > y2 && x1 < x2){//bottom left to top right
  //THIS WORKS
    //System.out.println("this one");
    float d = (y1-y2)/3.0, u = y1 - d, v = (3*y1) - (2*d) + y2, w = (y1 + y2)*(y1 - d), j = (3*x1) + x2, k = (x1*x1) + (x1*x2);
    float h = (2*u*u) + (2*d*d) - (u*v) + w - (2*x1*x1) + k, i = v - (4*u), l = (4*x1) - j;
    float m = (l*l) + (i*i), n = (2*h*l) - (2*i*i*x1), o = (h*h) - (i*i*d*d) + (i*i*x1*x1);
    a = ((-1 * n) + sqrt((n*n) - (4*m*o)))/(2*m);
    b = y1 - d + sqrt((d*d) - ((a-x1)*(a-x1)));
    angle = asin((a-x1)/d);
    
    float a1 = x1 + x2 - a, b1 = y1 + y2 - b;
    float x = cart.xcor, y = cart.ycor;
        
        
    if(x > x2){
      if (start <= 1) {
        currentTrackSim = 0;
      }
      else {
        currentTrackSim ++;
      }
      start ++;
      cart.angle = 0;
    }
    else if( x < a + 10 ){
      System.out.println("on the left arc!");
      float r = (y1 - y2) / 3;
      angle = 1*(float)Math.atan((cart.xcor-x1) / (y1 + r - cart.ycor));
      cart.angle = angle;
    }
    else if(y < b1){
      float r = (y1 - y2) / 3;
      angle = -1*atan((x2 - x) / (y - (y2 - ((y2 - y1) / 3))));
      cart.angle = angle;
    }
    else{
      System.out.println("in the middle!");
    }
    
    float vel = cart.calcVelFromKinetic(cart.ycor);
    cart.xvel = cos(angle) * (vel);
    cart.yvel = -1*Math.abs(sin(angle) * (vel));
    cart.xcor += cart.xvel / 10;
    cart.ycor += cart.yvel / 10;
    //THIS WORKS
    
  }
  else if(y1 < y2 && x1 > x2){//top right to bottom left
  
    float tempx = x2, tempy = y2;
    x2 = x1;
    y2 = y1;
    x1 = tempx;
    y1 = tempy;
    float d = (y1-y2)/3.0, u = y1 - d, v = (3*y1) - (2*d) + y2, w = (y1 + y2)*(y1 - d), j = (3*x1) + x2, k = (x1*x1) + (x1*x2);
    float h = (2*u*u) + (2*d*d) - (u*v) + w - (2*x1*x1) + k, i = v - (4*u), l = (4*x1) - j;
    float m = (l*l) + (i*i), n = (2*h*l) - (2*i*i*x1), o = (h*h) - (i*i*d*d) + (i*i*x1*x1);
    a = ((-1 * n) + sqrt((n*n) - (4*m*o)))/(2*m);
    b = y1 - d + sqrt((d*d) - ((a-x1)*(a-x1)));
    angle = asin((a-x1)/d);
    
    float a1 = x1 + x2 - a, b1 = y1 + y2 - b;
    float x = cart.xcor, y = cart.ycor;
    
    if(x < x2){
      if (start <= 1) {
        currentTrackSim = 0;
      }
      else {
        currentTrackSim ++;
      }
      start ++;
      cart.angle = 0;
    }
    else if( x < a1 ){
      System.out.println("on the left arc!");
      float r = (y2 - y1) / 3;
      angle = -1*(float)Math.atan((cart.xcor-x2) / (y - y2 + r));
      cart.angle = angle;
    }
    else if(y < b){
      float r = (y2 - y1) / 3;
      angle = -1*atan((x1 - x) / (y1 + r - y));
      cart.angle = angle;
    }
    else{
      System.out.println("in the middle!");
    }
    
    float vel = cart.calcVelFromKinetic(cart.ycor);
    cart.xvel = -1*cos(angle) * (vel);
    cart.yvel = Math.abs(sin(angle) * (vel));
    cart.xcor += cart.xvel / 10;
    cart.ycor += cart.yvel / 10;
    
  }
  else if(y1 > y2 && x1 > x2){ //WORKS
    float d = (y1-y2)/3.0, u = y2 + d, v = (3*y2) + (2*d) + y1, w = (y2 + y1)*(y2 + d), j = (3*x2) + x1, k = (x2*x2) + (x1*x2);
    float h = (2*u*u) + (2*d*d) - (u*v) + w - (2*x2*x2) + k, i = (4*u) - v, l = (4*x2) - j;
    float m = (l*l) + (i*i), n = (2*h*l) - (2*i*i*x2), o = (h*h) - (i*i*d*d) + (i*i*x2*x2);
    a = ((-1 * n) + sqrt((n*n) - (4*m*o)))/(2*m);
    b = y2 + d - sqrt((d*d) - ((a-x2)*(a-x2)));
    angle = asin((a-x1)/d);
    
    float a1 = x1 + x2 - a, b1 = y1 + y2 - b;
    float x = cart.xcor, y = cart.ycor;
    
    
    if(x < x2){
      if (start <= 1) {
        currentTrackSim = 0;
      }
      else {
        currentTrackSim ++;
      }
      start ++;
      cart.angle = 0;
    }
    else if( x < a1 ){
      System.out.println("on the left arc!");
      float r = (y1 - y2) / 3;
      angle = -1*(float)Math.atan((cart.xcor-x2) / (y - y2 + r));
      cart.angle = angle;
    }
    else if(y > b){
      float r = (y2 - y1) / 3;
      angle = -1*atan((x1 - x) / (y - y1 + r));
      cart.angle = angle;
    }
    else{
      System.out.println("in the middle!");
    }
    
    float vel = cart.calcVelFromKinetic(cart.ycor);
    cart.xvel = -1*cos(angle) * (vel);
    cart.yvel = -1*Math.abs(sin(angle) * (vel));
    cart.xcor += cart.xvel / 10;
    cart.ycor += cart.yvel / 10;
  }
  
  

  
}

void updateCartLoop(){
  Track currTrack = allTracks.get(currentTrackSim);
  float xcenter = currTrack.xstart, ycenter = currTrack.ystart - currTrack.radius;
  float r = currTrack.radius;
  float x = cart.xcor, y = cart.ycor;
  float a = 0, b = 0, angle = 0;
  
  Track prevTrack = allTracks.get(currentTrackSim - 1);
  boolean goingRight = prevTrack.xfinish - prevTrack.xstart > 0;
  System.out.println(xcenter + ", " + ycenter + ", " + x + ", " + y);
  if(goingRight){
    if(!loopCompleted && x >= xcenter && y >= ycenter){
      angle = -1*(float)Math.atan((x-xcenter) / (y - ycenter));
      cart.angle = angle;
      
      
      float vel = cart.calcVelFromKinetic(cart.ycor);
      cart.xvel = cos(angle) * (vel);
      cart.yvel = -1*Math.abs(sin(angle) * (vel));
      cart.xcor += cart.xvel / 10;
      cart.ycor += cart.yvel / 10;
      //System.out.println(cart.angle);
      //System.out.println(x + "," + y);
    }
    else if(x > xcenter && y <= ycenter){
     // System.out.println("we out here!");
      angle = -1*(float)Math.atan((x-xcenter) / (ycenter - y));
      cart.angle = angle;
      
      
      float vel = cart.calcVelFromKinetic(cart.ycor);
      cart.xvel = -1*cos(angle) * (vel);
      cart.yvel = -1*Math.abs(sin(angle) * (vel));
      cart.xcor += cart.xvel / 10;
      cart.ycor += cart.yvel / 10;
      
      
    }
    else if(x < xcenter && y < ycenter){
      angle = -1*(float)Math.atan((xcenter-x) / (ycenter - y));
      cart.angle = angle;
      
      
      float vel = cart.calcVelFromKinetic(cart.ycor);
      cart.xvel = -1*cos(angle) * (vel);
      cart.yvel = 1*Math.abs(sin(angle) * (vel));
      cart.xcor += cart.xvel / 10;
      cart.ycor += cart.yvel / 10;
    }
    
    else if(x < xcenter && y >= ycenter){
      angle = -1*(float)Math.atan((xcenter-x) / (y - ycenter));
      cart.angle = angle;
      
      
      float vel = cart.calcVelFromKinetic(cart.ycor);
      cart.xvel = 1*cos(angle) * (vel);
      cart.yvel = 1*Math.abs(sin(angle) * (vel));
      cart.xcor += cart.xvel / 10;
      cart.ycor += cart.yvel / 10;
      loopCompleted = true;
    }
    else{
      currentTrackSim++;
      loopCompleted = false;
    }
  }
  else{
    if(x <= xcenter && y >= ycenter ){
      angle = -1*(float)Math.atan((xcenter-x) / (y - ycenter));
      cart.angle = angle;
      
      
      float vel = cart.calcVelFromKinetic(cart.ycor);
      cart.xvel = -1*cos(angle) * (vel);
      cart.yvel = -1*Math.abs(sin(angle) * (vel));
      cart.xcor += cart.xvel / 10;
      cart.ycor += cart.yvel / 10;
    }
    else if(x <= xcenter && y < ycenter){
      angle = -1*(float)Math.atan((xcenter-x) / (ycenter - y));
      cart.angle = angle;
      
      
      float vel = cart.calcVelFromKinetic(cart.ycor);
      cart.xvel = 1*cos(angle) * (vel);
      cart.yvel = -1*Math.abs(sin(angle) * (vel));
      cart.xcor += cart.xvel / 10;
      cart.ycor += cart.yvel / 10;
    }
    else if(x > xcenter && y < ycenter){
      angle = -1*(float)Math.atan((x-xcenter) / (ycenter - y));
      cart.angle = angle;
      
      
      float vel = cart.calcVelFromKinetic(cart.ycor);
      cart.xvel = 1*cos(angle) * (vel);
      cart.yvel = 1*Math.abs(sin(angle) * (vel));
      cart.xcor += cart.xvel / 10;
      cart.ycor += cart.yvel / 10;
    }
    else if(x > xcenter && y >= ycenter){
      angle = -1*(float)Math.atan((x-xcenter) / (y - ycenter));
      cart.angle = angle;
      
      
      float vel = cart.calcVelFromKinetic(cart.ycor);
      cart.xvel = -1*cos(angle) * (vel);
      cart.yvel = 1*Math.abs(sin(angle) * (vel));
      cart.xcor += cart.xvel / 10;
      cart.ycor += cart.yvel / 10;
      System.out.println(cart.angle);
      loopCompleted = true;
    }
    else{
      currentTrackSim++;
      loopCompleted = false;
    }
  }
}


void updateCartSpring(){
  //int x1 = obj.xstart, y = obj.ystart, x2 = obj.xfinish;
  //for(int i = min(x1, x2); i < max(x1,x2); i += xwidth ){
  //  //System.out.println(i);
  //  noFill();
  //  strokeWeight(4);
  //  beginShape();
  //  vertex(i,y);
  //  quadraticVertex(i+xwidth/2, y - 100, i+xwidth, y);
  //  endShape();
  //}
  
  float xright = cart.xcor + 10, xleft = cart.xcor - 10;
  Track currTrack = allTracks.get(currentTrackSim);
  float x1 = currTrack.xstart, y = currTrack.ystart, x2 = currTrack.xfinish;
  
  Track prevTrack = allTracks.get(currentTrackSim - 1);
  int direction = prevTrack.xfinish - prevTrack.xstart;
  
  if(direction > 0){
    if(xleft < x2 - 20){
      currentTrackSim++;
      currTrack.springWidth = 10;
    }
    else{
      currTrack.springWidth = 10.0 * (x1 - xright) / (x1-x2);
    
      float xdiff = abs(x2 - xright), force = -.10*xdiff, accel = force/cart.mass;
      
      //System.out.println(accel);
      cart.xvel += accel;
      cart.xcor += cart.xvel / 10;
    }
    
  }
  else{
    if(xright > x2 + 20){
      currentTrackSim++;
      currTrack.springWidth = 10;
    }
    else{
      currTrack.springWidth = 10.0 * (xleft - x1) / (x2 - x1);
      
      float xdiff = abs(x2 - xleft), force = .10*xdiff, accel = force/cart.mass;
      
      cart.xvel += accel;
      cart.xcor += cart.xvel / 10;
    }
  }
   
  
  
  
  
}


float getYFromX(float cart_x, float arc_x, float arc_y_low, float arc_y_high) {
  float r = (arc_y_low - arc_y_high) / 3;
  return (arc_y_low - r + sqrt( (r*r) - ((cart_x - arc_x)*(cart_x - arc_x)) ));
 }


//-------------------------HOW TO PLAY FUNCTIONS------------------------------

void runHowToPlay(){
  clear();
  colorMode(HSB,360,100,100);
  background(200, 18, 100);
  colorMode(RGB,255,255,255);
  textAlign(CENTER, CENTER);
  fill(0);
  text("Instructions to come\nHere they come!!\nSike lol", width/2, height/2);
  
  if(mouseX > gap && mouseX < gap + 300 && mouseY > gap && mouseY < gap + 100){
    fill(252,143,161);
    stroke(252,143,161);
  }
  else{
    fill(255,182,193);
    stroke(255,182,193); 
  }
  rect(gap, gap, 300, 100, buttonRadius);
  fill(255);
  textAlign(CENTER, CENTER);
  text("Back", 150 + gap, 50 + gap);
}


//------------------------------MOUSE FUNCTIONS------------------------------------

void mouseClicked(){
  if(currentPage == 0){
    startPageMouseAction();
  }
  else if(currentPage == 1){
    buildPageMouseAction();
  }
  else if(currentPage == 2){
    simulationPageMouseAction();
  }
  else if(currentPage == 3){
    howToPlayMouseAction();
  }
}

void startPageMouseAction(){
  int x_len = 300;
  int y_len = 100;
  if(mouseX > 700 - (x_len / 2) && mouseX < 700 + (x_len / 2) && mouseY > 450 - (y_len / 2) && mouseY < 450 + (y_len / 2)){
    currentPage = 1;
    currentTrack = 0;
  }
  else if(mouseX > 700 - (x_len / 2) && mouseX < 700 + (x_len / 2) && mouseY > 575 - (y_len / 2) && mouseY < 575 + (y_len / 2)){
    currentPage = 3;
    currentTrack = 0;
  }
}

void buildPageMouseAction(){
  boolean heightIsRight = mouseY > buttonHeightStart && mouseY < buttonHeightStart + buttonHeight;
  int leftBound = (mouseX - gap) / (buttonWidth + gap), rightBound = mouseX / (buttonWidth + gap);

  if(trackConfirmed && mouseY > gap && mouseY < 700 - gap - buttonHeight - 5 - buttonHeight - 5 && mouseX > gap && mouseY < 1400 - gap){
    trackBuildAction(mouseX, mouseY);
  }
  else if(heightIsRight && leftBound == rightBound && leftBound + 1 != trackToConfirm){
    //System.out.println("leftBound: " + leftBound + " currentTrack: " + currentTrack + " trackToConfirm: " + trackToConfirm);
    displayedText = "You have selected a " + tracks[leftBound].toLowerCase() + ". Please click again to confirm your selection";
    currentTrack = leftBound + 1;
    trackToConfirm = leftBound + 1;
    trackConfirmed = false;
    currentPrompt = 0;
    pointsToDisplay = new ArrayList<int[]>();
    //System.out.println("leftBound: " + leftBound + " currentTrack: " + currentTrack + " trackToConfirm: " + trackToConfirm);
    //System.out.println(leftBound + 1 != trackToConfirm);
  }
  else if(heightIsRight && leftBound == rightBound){
    displayedText = tracks[leftBound] + ": ";
    trackToConfirm = 0;
    currentPrompt = 0;
    trackConfirmed = true;
    String[] instructions = tracksDescription[currentTrack - 1];
    displayedText = tracks[currentTrack - 1] + ": " + instructions[0];
    //System.out.println("leftBound: " + leftBound + " currentTrack: " + currentTrack + " trackToConfirm: " + trackToConfirm);
  }
  else if(mouseY > 700 - gap - buttonHeight - 5 - buttonHeight && mouseY < 700 - gap - buttonHeight - 5 && mouseX > 1400 - gap - doneWidth && mouseX < 1400 - gap){
    currentPage = 2;
    currentTrack = 0;
  }
  
}

void updateTextWindow(){
  int x_left = gap, x_right = 1400 - gap - doneWidth - 5, y_top = 700 - gap - buttonHeight - 5 - buttonHeight, y_bottom = 700 - gap - buttonHeight - 5;
  textAlign(CENTER, CENTER);
  fill(255);
  textSize(28);
  text(displayedText, (x_left + x_right) / 2, (y_top + y_bottom) / 2);
}

void simulationPageMouseAction(){ //STILL NEEDS TO RESIZE
  if(mouseX > gap && mouseX < gap + 300 && mouseY > buttonHeightStart && mouseY < buttonHeightStart + buttonHeight){
    currentPage = 1;
    currentTrack = 0;
    trackToConfirm = 0;
    makeCart();
    currentTrackSim = 0;
    start = 0;
  }
}

void howToPlayMouseAction(){
  if(mouseX > gap && mouseX < gap + 300 && mouseY > gap && mouseY < gap + 100){
    currentPage = 0;
    currentTrack = 0;
    trackToConfirm = 0;
  }
}