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
String[][] tracksDescription = { {"Please select a starting point", "Please select an ending point"},
                                 {"Please select a starting point", "Please select an ending point"},
                                 {"Please select a starting point", "Please select a center" },
                                 {"Please select a starting point", "Please select a direction"}};

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

//-------------------------------------MAIN FUNCTIONS-----------------------

void setup(){
  size(1400,700);
  frameRate(120);
  currentPage = 0;
  currentTrack = 0;
  myFont = createFont("Century", 32);
  textFont(myFont);
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
}

void checkMouseOnButton(){
  int mouseOver = 0;
  
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
  rect(x_left, y_top, x_right - x_left, y_bottom - y_top, buttonRadius);
  fill(255);
  textAlign(CENTER, CENTER);
  text("Done", (x_left + x_right) / 2, (y_top + y_bottom) / 2);
}

void checkMouseOnTrack(){
  int x = mouseX, y = mouseY;
  if(allTracks.size() > 0){
    Track prev = allTracks.get(allTracks.size() - 1);
    int xfinish = prev.xfinish, yfinish = prev.yfinish;
    if(x > xfinish - 10 && x < xfinish + 10 && y > yfinish - 10 && y < yfinish + 10){
      fill(0,256,0);
      stroke(0,256,0);
      ellipse(xfinish, yfinish, 10, 10);
    }
  }
}

void generateScreen(){
  int x_left = gap, x_right = 1400 - gap, y_top = gap, y_bottom = 700 - gap - buttonHeight - 5 - buttonHeight - 5;
  fill(255);
  stroke(255);
  rect(x_left, y_top, 1400 - gap * 2, y_bottom - y_top, buttonRadius); 
}

void generateTextWindow(){
  int x_left = gap, x_right = 1400 - gap - doneWidth - 5, y_top = 700 - gap - buttonHeight - 5 - buttonHeight, y_bottom = 700 - gap - buttonHeight - 5;
  fill(255,178,238);
  stroke(255,178,238);
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
    allTracks.add(new Track (info[0], info[2], info[1], info[1], 1));
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
    allTracks.add(new Track (info[0], info[2], info[1], info[3], 2));
  }
}

void buildLoop(int x, int y){
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
    info[3] = y;
    currentTrack = 0;
    int[] new_info = {x, y, 10};
    pointsToDisplay.add(new_info);
    trackToConfirm = 0;
    trackConfirmed = false;
    currentPrompt = 0;
    displayedText = "Loop track added! Please select another track or click Done";
    currentPrompt++;
    allTracks.add(new Track (info[0], info[2], info[1], info[3], 3));
  }
}

void buildSpring(int x, int y){
  String[] instructions = tracksDescription[currentTrack - 1];
  for(int i = 0; i < instructions.length; i++){
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
  }
  else if (type == 4) {
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

//---------------------------SIMULATION FUNCTIONS-------------------------------


void runSimulation(){
  clear();
  colorMode(HSB,360,100,100);
  background(200, 18, 100);
  colorMode(RGB,255,255,255);
  textAlign(CENTER, CENTER);
  fill(0);
  text("Simulation to come", width/2, height/2);
  
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
  if(mouseX > gap && mouseX < gap + 300 && mouseY > gap && mouseY < gap + 100){
    currentPage = 1;
    currentTrack = 0;
    trackToConfirm = 0;
  }
}

void howToPlayMouseAction(){
  if(mouseX > gap && mouseX < gap + 300 && mouseY > gap && mouseY < gap + 100){
    currentPage = 0;
    currentTrack = 0;
    trackToConfirm = 0;
  }
}