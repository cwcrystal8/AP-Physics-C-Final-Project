import java.util.*;

int currentPage; //0 is start menu, 1 is build stage, 2 is simulation 
int currentTrack; //0 is none, 1 straight track, 2 is curved track, 3 is loop, 4 is spring
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
String displayedText = "Welcome! Please select a track to begin";

void setup(){
  size(1800,900);
  frameRate(120);
  colorMode(HSB,360,100,100);
  background(200, 18, 100);
  colorMode(RGB,255,255,255);
  currentPage = 0;
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
  else{
    runSimulation();
  }
}

void runStartMenu(){
  int x_len = 300;
  int y_len = 100;
  
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
    text("Start Drawing", 900, 600);
  }
}

void runBuildStage(){
  colorMode(HSB,360,100,100);
  background(200, 18, 100);
  colorMode(RGB,255,255,255);
  checkMouseOnButton();
  checkMouseOnDone();
  generateScreen();
  generateTextWindow();
  updateTextWindow();
  if(currentTrack > 0){
    trackBuildAction();
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
    
  }
}

void runSimulation(){
  background(0);
}

void mouseClicked(){
  if(currentPage == 0){
    startPageMouseAction();
  }
  else if(currentPage == 1){
    buildPageMouseAction();
  }
}

void startPageMouseAction(){
  int x_len = 300;
  int y_len = 100;
  if(mouseX > 900 - (x_len / 2) && mouseX < 900 + (x_len / 2) && mouseY > 600 - (y_len / 2) && mouseY < 600 + (y_len / 2)){
    currentPage = 1;
  }
}

void buildPageMouseAction(){
  int mouseOver = 0;
  boolean heightIsRight = mouseY > buttonHeightStart && mouseY < buttonHeightStart + buttonHeight;
  int leftBound = (mouseX - gap) / (buttonWidth + gap), rightBound = mouseX / (buttonWidth + gap);
  if(heightIsRight && leftBound == rightBound){
    displayedText = "You have selected a " + tracks[leftBound].toLowerCase();
    currentTrack = leftBound + 1;
  }
  else if(mouseY > gap + 620 && mouseY < 740 && mouseX > 1620 - gap && mouseX < 1800 - gap){
    currentPage = 2;
  }
}

void updateTextWindow(){
  textAlign(CENTER, CENTER);
  fill(255);
  text(displayedText, width/2 - 100, gap + 665);
}