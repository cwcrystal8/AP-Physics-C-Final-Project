import java.util.*;

public class Cart {
  
  public int ycor, xcor;
  public float xvel, yvel;
  public float xaccel, yaccel;
  public int ht;
  public float angle;
  public int mass;
  public int col;
  public float kinetic;
  public float potential;
  
  public Cart(int x, int y) {
    xcor = x;
    ycor = y;
    xvel =0;
    yvel = 0;
    xaccel  = 0;
    yaccel = 9.81;
    ht = height;
    angle = 0;
    mass = 30;
    col = #FF0808;
  }

  void calcVel(float angle, int ycor){
    angle = angle * (PI / 180);
    //float potential = mass * ht * 9.81;
    float new_potential = mass * (ht-ycor) * 9.81;
    float velocity = sqrt((new_potential) / (0.5 * mass));
    xvel = velocity * cos(angle);
    yvel = velocity * sin(angle);
    potential = new_potential;
    kinetic = calcKinetic();
  }

  void update() {
    fill(col);
    rect(xcor - 100, ycor - 100, xcor + 100, ycor + 100, 14, 100, 14, 14);
    fill(255);
    textSize(15);
    text("Caert", xcor, ycor,xcor + 10, ycor + 10);
    
    calcVel(int(angle), ycor);
  }
  
  float calcKinetic() {
    return((mass * ht * 9.81) - potential);
  }
}
