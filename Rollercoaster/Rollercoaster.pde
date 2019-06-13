import java.util.*;

//CONSTANTS
PFont myFont;
int gap = 20;
int buttonHeight = 50;
int buttonWidth = (1400 - 5 * gap) / 4;
int buttonHeightStart = 700 - gap - buttonHeight;
int buttonRadius = 10;
int doneWidth = 120;
String[] tracks = {"Straight Track", "Curved Track", "Loop", "Spring"};
String[][] tracksDescription = { {"Please select a starting point", "Please select an ending point"},
                                 {"Please select a starting point", "Please select an ending point"},
                                 {"Please select a starting point", "Please select a center" },
                                 {"Please select a starting point", "Please select a direction"}};

//VARYING
String displayedText = "Welcome! Please select a track to begin";
int currentPage; //0 is start menu, 1 is build stage, 2 is simulation, 3 is how to play
int trackToConfirm; //0 is none, 1 straight track, 2 is curved track, 3 is loop, 4 is spring
int currentTrack; //0 is none, 1 straight track, 2 is curved track, 3 is loop, 4 is spring
boolean trackConfirmed = false;
ArrayList<int[]> pointsToDisplay = new ArrayList<int[]>();
int currentPrompt = 0;
ArrayList<Object> allTracks = new ArrayList<Object>(); 
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
  checkMouseOnButton();
  checkMouseOnDone();
  generateScreen();
  generateTextWindow();
  updateTextWindow();
  displayPoints();
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
    buildStraightTrack(x, y);
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

void buildStraightTrack(int x, int y){
  String[] instructions = tracksDescription[currentTrack - 1];
  if(currentPrompt == 0){
    info[0] = x;
    info[1] = y;
    int[] new_info = {x, y, 10};
    pointsToDisplay.add(new_info);
    currentPrompt++;
    displayedText = tracks[currentTrack - 1] + ": " + instructions[1];
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
    displayedText = "Straight track added! Please select another track or click Done";
    currentPrompt++;
    //allTracks.add(new Track (1, ));
  }
  
}

void buildCurvedTrack(int x, int y){
  String[] instructions = tracksDescription[currentTrack - 1];
  if(currentPrompt == 0){
    info[0] = x;
    info[1] = y;
    int[] new_info = {x, y, 10};
    pointsToDisplay.add(new_info);
    currentPrompt++;
    displayedText = tracks[currentTrack - 1] + ": " + instructions[1];
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
    //allTracks.add(new Track(2, ));
  }
}

void buildLoop(int x, int y){
  String[] instructions = tracksDescription[currentTrack - 1];
  if(currentPrompt == 0){
    info[0] = x;
    info[1] = y;
    int[] new_info = {x, y, 10};
    pointsToDisplay.add(new_info);
    currentPrompt++;
    displayedText = tracks[currentTrack - 1] + ": " + instructions[1];
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
    displayedText = "Loop added! Please select another track or click Done";
    currentPrompt++;
    //allTracks.add(new Track(2, ));
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
  text("Instructions to come", width/2, height/2);
  
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