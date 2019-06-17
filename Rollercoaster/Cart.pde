import java.util.*;

public class Cart {
  
  public float ycor, xcor;
  public float xvel, yvel;
  public float xaccel, yaccel;
  public float ht;
  public float angle;
  public int mass;
  public int col;
  public float kinetic;
  public float potential;
  
  public Cart(float x, float y, float ang) {
    xcor = (float)x;
    ycor = (float)y;
    xvel = 0;
    yvel = 0;
    xaccel  = 0;
    yaccel = 9.81 / 10;
    ht = (float)y - 20;
    angle = ang;
    mass = 30;
    col = #FF0808;
  }

  float[] calcVel(float y){
    //angle = anPI / 180);
    //float potential = mass * ht * 9.81;
    //float new_potential = mass * (*1 * (ht-ycor)) * yaccel;
    //System.out.println(ang);
    float velocity = sqrt(2 * yaccel * (y-ht));
    
    //System.out.println(velocity);
    float new_xvel = velocity * sin(angle);
    float new_yvel = velocity * cos(angle);
    //potential = new_potential;
    kinetic = 0.5 * mass * (float)Math.pow(velocity, 2);
    float[] ret_arr = {new_xvel, new_yvel};
    
    return ret_arr;
  }

  void calcKinetic() {
    float vel = (cart.xvel * cart.xvel) + (cart.yvel * cart.yvel);
    kinetic = 0.5 * mass * (vel * vel);
  }

  float calcTangVel(float y){
     //kinetic = mass * yaccel * (y - ht);
    calcKinetic();
    return sqrt(2 * yaccel * (y-ht));
  }
  /*
  void update() {
    fill(col);
    rect(xcor - 100, ycor - 100, xcor + 100, ycor + 100, 14, 100, 14, 14);
    fill(255);
    textSize(15);
    text("Caert", xcor, ycor,xcor + 10, ycor + 10);
    
    calcVel(int(angle), ycor);
  }*/
  
  
  float calcVelFromKinetic(float y) {
    //kinetic = mass * yaccel * (y - ht);
    calcKinetic();
    return sqrt(2 * yaccel * (y-ht));
  }
}
