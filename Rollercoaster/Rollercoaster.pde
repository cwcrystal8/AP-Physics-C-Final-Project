import java.util.*;

int currentPage; //0 is start menu, 1 is build stage, 2 is simulation 
PFont myFont;

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
    rect(900 - (x_len / 2), 600 - (y_len / 2), x_len, y_len, 25);
    textAlign(CENTER, CENTER);
    fill(255,255,255);
    textSize(38);
    text("Start Drawing", 903, 600);
  }
  else{
    fill(255,182,193);
    stroke(255,182,193);
    rect(900 - (x_len / 2), 600 - (y_len / 2), x_len, y_len, 25);
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
  int buttonHeight = 750, gap = 50;
  int buttonWidth = (1800 - 5 * gap) / 4;
  int mouseOver = 0;
  
  for(int i = gap; i < 1800; i+=buttonWidth + gap){
    if(mouseX > i && mouseX < i + buttonWidth && mouseY > buttonHeight && mouseY < 875){
      mouseOver = i;
    }
  }
  
  if(mouseOver != 0){
    for(int i = gap; i < 1800; i+=buttonWidth + gap){
      if(i == mouseOver){
        fill(173,177,255);
        stroke(173,177,255);
        rect(i, buttonHeight, buttonWidth, 125, 25);
      }
      else{
        fill(202,184,255);
        stroke(202,184,255);
        rect(i, buttonHeight, buttonWidth, 125, 25);
      }
    }
  }
  else{
    for(int i = gap; i < 1800; i+=buttonWidth + gap){
      fill(202,184,255);
      stroke(202,184,255);
      rect(i, buttonHeight, buttonWidth, 125, 25);
    }
  }
}

void runSimulation(){
}

void mouseClicked(){
  if(currentPage == 0){
    startPageMouseAction();
  }
}

void startPageMouseAction(){
  int x_len = 300;
  int y_len = 100;
  if(mouseX > 900 - (x_len / 2) && mouseX < 900 + (x_len / 2) && mouseY > 600 - (y_len / 2) && mouseY < 600 + (y_len / 2)){
    currentPage = 1;
  }
}