import java.util.*;

void setup(){
  size(1800,900);
  frameRate(120);
  
  
}

void draw(){
}

class Cart{
  int x_pos, y_pos;
  int x_vel, y_vel;
  int x_accel, y_accel;
  int angle, mass;
  
  Cart(){
  }
  
}

class StraightTrack{
  int start, end, y_pos;
  
  StraightTrack(){
  }
  
}

class CurvedTrack{
  int x_start, y_start;
  int x_end, y_end;
  
  CurvedTrack(){
  }
  
}

class Loop{
  int center, radius;
  
  Loop(){
  }
  
}

class Spring{
  int k; //Spring constant
  
  Spring(){
  }
  
}