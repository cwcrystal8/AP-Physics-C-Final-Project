import java.util.*;

//CONSTANTS
PFont myFont;
int gap = 40;
int buttonHeightStart = 750;
int buttonHeight = 125;
int buttonWidth = (1800 - 5 * gap) / 4;
int buttonRadius = 10;
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
Object[] allTracks = ;

//-------------------------------------MAIN FUNCTIONS-----------------------

void setup(){
  size(1800,900);
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
  
  if(mouseX > 900 - (x_len / 2) && mouseX < 900 + (x_len / 2) && mouseY > 600 - (y_len / 2) && mouseY < 600 + (y_len / 2)){
    fill(252,143,161);
    stroke(252,143,161);
    rect(900 - (x_len / 2), 600 - (y_len / 2), x_len, y_len, buttonRadius);
    textAlign(CENTER, CENTER);
    fill(255,255,255);
    textSize(38);
    text("Start Drawing", 903, 600);
  }
  else{
    fill(255,182,193);
    stroke(255,182,193);
    rect(900 - (x_len / 2), 600 - (y_len / 2), x_len, y_len, buttonRadius);
    textAlign(CENTER, CENTER);
    fill(255,255,255);
    textSize(38);
    text("Start Drawing", 903, 600);
  }
  
  if(mouseX > 900 - (x_len / 2) && mouseX < 900 + (x_len / 2) && mouseY > 720 - (y_len / 2) && mouseY < 720 + (y_len / 2)){
    fill(252,143,161);
    stroke(252,143,161);
    rect(900 - (x_len / 2), 720 - (y_len / 2), x_len, y_len, buttonRadius);
    textAlign(CENTER, CENTER);
    fill(255,255,255);
    textSize(38);
    text("How to Play", 903, 720);
  }
  else{
    fill(255,182,193);
    stroke(255,182,193);
    rect(900 - (x_len / 2), 720 - (y_len / 2), x_len, y_len, buttonRadius);
    textAlign(CENTER, CENTER);
    fill(255,255,255);
    textSize(38);
    text("How to Play", 903, 720);
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
  if(currentTrack > 0 && !trackConfirmed){

    trackBuildAction();
    trackConfirmed = false;
    currentTrack = 0;
    trackToConfirm = 0;
  }
}

void checkMouseOnButton(){
  int mouseOver = 0;
  
  for(int i = gap; i < 1800; i+=buttonWidth + gap){
    if(mouseX > i && mouseX < i + buttonWidth && mouseY > buttonHeightStart && mouseY < 875){
      mouseOver = i;
    }
  }
  textAlign(CENTER, TOP);
  if(mouseOver != 0){
    for(int i = gap; i < 1800; i+=buttonWidth + gap){
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
    for(int i = gap; i < 1800; i+=buttonWidth + gap){
      fill(202,184,255);
      stroke(202,184,255);
      rect(i, buttonHeightStart, buttonWidth, buttonHeight, buttonRadius);
      fill(255,255,255);
      text(tracks[ (i - gap) / (buttonWidth + gap) ], i + (buttonWidth/2), buttonHeightStart);
      
    }
  }
}

void checkMouseOnDone(){ 
  if(mouseY > gap + 620 && mouseY < 740 && mouseX > 1620 - gap && mouseX < 1800 - gap){
    fill(255,108,224);
    stroke(255,108,224);
  }
  else{
    fill(255,178,238);
    stroke(255,178,238);
  }
  rect(1620 - gap, gap + 640, 180, 100 - gap, buttonRadius);
  fill(255);
  textAlign(CENTER, CENTER);
  text("Done", 1710 - gap, 625 + gap + (120 - gap) / 2);
}

void generateScreen(){
  fill(255);
  stroke(255);
  rect(gap, gap, 1800 - gap * 2, 630, buttonRadius); 
}

void generateTextWindow(){
  fill(255,178,238);
  stroke(255,178,238);
  rect(gap, gap + 640, 1600 - gap * 2, 100 - gap, buttonRadius);
}

void trackBuildAction(){
  int track = currentTrack - 1;
  if(track == 0){
    buildStraightTrack();
  }
  currentTrack = 0;
}

void buildStraightTrack(){
  String[] instructions = tracksDescription[currentTrack - 1];
}

void buildCurvedTrack(){
  String[] instructions = tracksDescription[currentTrack - 1];
}

void buildLoop(){
  String[] instructions = tracksDescription[currentTrack - 1];
}

void buildSpring(){
  String[] instructions = tracksDescription[currentTrack - 1];
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
  if(mouseX > 900 - (x_len / 2) && mouseX < 900 + (x_len / 2) && mouseY > 600 - (y_len / 2) && mouseY < 600 + (y_len / 2)){
    currentPage = 1;
    currentTrack = 0;
  }
  else if(mouseX > 900 - (x_len / 2) && mouseX < 900 + (x_len / 2) && mouseY > 720 - (y_len / 2) && mouseY < 720 + (y_len / 2)){
    currentPage = 3;
    currentTrack = 0;
  }
}

void buildPageMouseAction(){
  boolean heightIsRight = mouseY > buttonHeightStart && mouseY < buttonHeightStart + buttonHeight;
  int leftBound = (mouseX - gap) / (buttonWidth + gap), rightBound = mouseX / (buttonWidth + gap);

  if(heightIsRight && leftBound == rightBound && leftBound + 1 != trackToConfirm){
    displayedText = "You have selected a " + tracks[leftBound].toLowerCase() + ". Please click again to confirm your selection";
    currentTrack = leftBound + 1;
    trackToConfirm = leftBound + 1;
    trackConfirmed = false;
  }
  else if(heightIsRight && leftBound == rightBound){
    displayedText = tracks[leftBound] + ": ";
    trackToConfirm = 0;
    trackConfirmed = true;
    //System.out.println("leftBound: " + leftBound + " currentTrack: " + currentTrack);
  }
  else if(mouseY > gap + 620 && mouseY < 740 && mouseX > 1620 - gap && mouseX < 1800 - gap){
    currentPage = 2;
    currentTrack = 0;
  }
}

void updateTextWindow(){
  textAlign(CENTER, CENTER);
  fill(255);
  text(displayedText, width/2 - 100, gap + 665);
}

void simulationPageMouseAction(){
  if(mouseX > gap && mouseX < gap + 300 && mouseY > gap && mouseY < gap + 100){
    currentPage = 1;
    currentTrack = 0;
  }
}

void howToPlayMouseAction(){
  if(mouseX > gap && mouseX < gap + 300 && mouseY > gap && mouseY < gap + 100){
    currentPage = 0;
    currentTrack = 0;
  }
}
