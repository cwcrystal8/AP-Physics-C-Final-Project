import java.util.*;

public class Track {
  public int xstart, ystart;
  public int xfinish, yfinish;
  public int radius;
  public int orientation; //0 is up, 1 is down
  public double angle;
  
  public Track(int x0, int x1,int  y0,int y1, int rad, int or) {
    xstart = x0;
    xfinish = x1;
    ystart = y0;
    yfinish = y1;
    if (rad != 0) {
      radius = rad;
    }
    
    angle = Math.atan((y1-y0) / (x1-x0)); 
    orientation = or;
    
  }
  
  
  
}
