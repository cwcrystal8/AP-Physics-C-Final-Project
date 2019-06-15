import java.util.*;

public class Track {
  public int xstart, ystart;
  public int xfinish, yfinish;
  public int radius;
  public int orientation; //0 is up, 1 is down
  public double angle;
  public int type;
  
  public Track(int x0, int x1,int  y0,int y1, int r, int t_type) {
    xstart = x0;
    xfinish = x1;
    ystart = y0;
    yfinish = y1;
    type = t_type;
    radius = r;
    //1 - straight, 2- curved, 3- loop, 4-spring
    if (t_type == 1) {
      angle = 0;
      orientation = 1;
      
    }
    else if (t_type == 2) {
    }
    else if (t_type == 3) {
    }
    else if (t_type == 4) {
    }
    if(x1 != x0){
      angle = Math.atan((y1-y0) / (x1-x0));
    }
     
  }
 
  
  
}