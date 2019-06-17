import processing.serial.*;                                        //include the serial library 
Serial myPort;                                                     //create an instance of type Serial called myPort

public class Graph {
  int width = 800;                                                   //use this variable to controll screen widtt
  int height = 400;                                                  //use this variable to controll screen height 
  
  int[] data1 = new int[width];                                      //data1, data2 and data3 store the graph information, and must be as long has the width of the screen (pixels)
  int[] data2 = new int[width];                    
  int[] data3 = new int[width];
  int newDataPoint1 = 0;                                             //newDataPoint1, newDataPoint2 and newDataPoint3 are esentially buffers for incoming data
  int newDataPoint2 = 0;
  int newDataPoint3 = 0;

  int starting_x;
  int starting_y;
  int w;
  int ht;
  String title, x_var,  y_var;
  float draw_y, draw_x;
  int type; //1 - kinetic energy, 2 - potential enery, 3 - velocity
  float prevY;
  
  public Graph(String t, String x, String y) {
    title = t;
    x_var = x;
    y_var = y;
    starting_x = width - 510;
    starting_y = width - 260;
    w = 500;
    ht = 250;
    type = 1;
    
  }
  
  
  void display() {
    draw();
  }
  
void draw()                                                        //the main routine (runs continuously until the program is ended)
{
  background(255,255,255);                                         //set the background to white. There are RGB color selectors online if you'd like to find a better looking color
  stroke(0,0,0);                                                   //set the stroke (line) color to black
  strokeWeight(2);                                                 //set the stroke width (weight) for the axes
  //line(0,height/2,width,height/2);                                 //draw the x-axis line            
  //line(width/4,0,width/4,height);                                  //draw the y-axis line
  
  
  //****DATA HANDLING****//                                        //the following 3 variables are buffers for incoming informaion, set these variables to the data you would like to display
  //*********************//  
  newDataPoint1 = mouseX;                                          
  newDataPoint2 = mouseY;          
  //*********************//
  //*********************//
  
  for(int i = width - w; i < width-10; i++)                                 //each interation of draw, shift data points one pixel to the left to simulate a continuously moving graph
  {
    data1[i] = data1[i+1];
    data2[i] = data2[i+1];
    data3[i] = data3[i+1];
  }
  
  data1[width-1] = newDataPoint1;                                 //introduce the bufffered data into the rightmost data slot
  data2[width-1] = newDataPoint2;
  data3[width-1] = newDataPoint3;
  
  strokeWeight(2);                                                //set the stroke width (weight) for the actual graph
  
  for(int i = width-1; i > width - w; i--)                                
  {
    stroke(255,0,0);
    line(i,data1[i-1], i+1, data1[i]);
    stroke(0,255,0);
    line(i,data2[i-1], i+1, data2[i]);
    stroke(0,0,255);
    line(i,data3[i-1], i+1, data3[i]); 
  }
  
}
 
void drawStuff() {
  background(0);
  for (int i = width; i <= width - w; i += 50) {
    fill(0, 255, 0);
    text(i/2, i-10, height-15);
    stroke(255);
    line(i, ht, i, 0);
  }
  for (int j = height; j < height - ht; j += 33) {
    fill(0, 255, 0);
    text(6-j/(height/6), 0, j);
    stroke(255);
    line(0, j, w, j);
  }
}
  
  
}
