import processing.serial.*;                                        //include the serial library 
Serial myPort;                                                     //create an instance of type Serial called myPort

public class Graph {
  int[] data1 = new int[width];                                      //data1, data2 and data3 store the graph information, and must be as long has the width of the screen (pixels)
  int[] data2 = new int[width];                    
  int[] data3 = new int[width];
  int newDataPoint1 = 0;                                             //newDataPoint1, newDataPoint2 and newDataPoint3 are esentially buffers for incoming data
  int newDataPoint2 = 0;
  int newDataPoint3 = 0;

  float starting_x;
  float starting_y;
  float w= 500;
  float ht = 230;
  String title, x_var,  y_var;
  float draw_y, draw_x;
  int type; //1 - kinetic energy, 2 - potential enery, 3 - velocity
  float prevY;
  
  ArrayList<float[]> data = new ArrayList<float[]>();
  
  public Graph(String t, String x, String y) {
    title = t;
    x_var = x;
    y_var = y;
    starting_x = 1400 - w - 20;
    starting_y = 850 - ht - 20;
    //w = 500;
    //ht = 250;
    type = 1;
    draw_x = starting_x + 20;
    draw_y = 850 - 50;
  }
  
  void drawGraph() {
    fill(255);
    stroke(255,182,193);
    rect(starting_x, starting_y, w, ht, 10);
    float[] vars = new float[data.size()];
    for (int i = 0; i < data.size(); i ++) {
      vars[i] = (data.get(i)[1]);
    }
    float max_var = max(vars); //used to get highest ycor for graph
    float y_height = draw_y - (starting_y + 30);
    float height_constant = y_height / max_var;
    float x_width = (1400 - 20) - draw_x;
    float width_constant = x_width / data.size(); //update x on graph by adding xcor*width_constant
    
    for (int i = 0; i < data.size() - 1; i ++) {
      float x1 = draw_x + (i * width_constant);
      float y1 = draw_y - (data.get(i)[1]* height_constant);
      float x2 = draw_x + ((i + 1) * width_constant);
      float y2 = draw_y - (data.get(i+1)[1] * height_constant);
      //System.out.println(data.get(i)[1] + " : " + x1);
      stroke(0);
      //fill(0);
      line(x1, y1, x2, y2);
    }
    
    textSize(20);
    fill(0);
    //stroke(255);
    text(title, starting_x + ((1400 - starting_x) / 2), starting_y - 10);
    textSize(10);
    String s = (int)max_var + "";
    text(s, starting_x - 15, draw_y - (max_var * height_constant));
    textSize(28);
  }
  
  void update(float x, float k) {
    float[] temp = {x, k};
    data.add(temp);
    drawGraph();
    //System.out.println(data.size());
  }
  
  
  
}
