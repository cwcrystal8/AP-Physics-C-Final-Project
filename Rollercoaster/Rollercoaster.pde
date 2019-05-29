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
  fill(255,182,193);
  stroke(255,182,193);
  rect(900 - (x_len / 2), 600 - (y_len / 2), x_len, y_len, 25);
  textAlign(CENTER, CENTER);
  fill(255,255,255);
  textSize(38);
  text("Start Drawing", 903, 600);
}

void runBuildStage(){
}

void runSimulation(){
}