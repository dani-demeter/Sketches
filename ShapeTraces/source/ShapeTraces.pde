int xcent = 500;
int ycent = 300;
int steps = 1000;
float sizeR = 50;
float tmin = 0;
float tmax = 2*PI;

float r1 = 5;
float r2 = 3;
float p1 = 2;
float p2 = 3;

float cStep = 0;
Button b1 = new Button(50, 50, 50, 50, "hello", 0);
ButtonCircle b2 = new ButtonCircle(50, 150, 50, 50, "hello", 0);

int shape = 1;
void setup(){
  size(1000, 600);
  //noLoop();
  background(28, 29, 32);
  
}
void mousePressed(){
  b1.mousePressed();
  b2.mousePressed();
}
float fx(float t, float r1){
  t %= 2*PI;
  if(shape==1){
    return r1*cos(t);
  }else if(shape==0){
    if(t>(PI/4) && t<=(3*PI/4)){
      return r1*cot(t);
    }else if(t>(3*PI/4) && t<=(5*PI/4)){
      return -r1;
    }else if(t>(5*PI/4) && t<=(7*PI/4)){
      return -cot(t)*r1;
    }else{
      return r1;
    }
  }
  return -1;
}
float fy(float t, float r1){
  t %= 2*PI;
  if(shape==1){
    return r1*sin(t);
  }else if(shape==0){
    if(t>(PI/4) && t<=(3*PI/4)){
      return r1;
    }else if(t>(3*PI/4) && t<=(5*PI/4)){
      return -r1*tan(t);
    }else if(t>(5*PI/4) && t<=(7*PI/4)){
      return -r1;
    }else{
      return tan(t)*r1;
    }
  }
  return -1;
  
}
float cot(float t){
  return 1/tan(t);
}
void drawMyLine(float x1, float y1, float x2, float y2){
  float x1p = toScreenPointX(x1);
  float y1p = toScreenPointY(y1);
  float x2p = toScreenPointX(x2);
  float y2p = toScreenPointY(y2);
  line(x1p, y1p, x2p, y2p);
}
float toScreenPointX(float x){
  return x*sizeR+xcent;
}
float toScreenPointY(float y){
  return y*sizeR + ycent;
}
void draw(){
  stroke(42, 183, 202, 125);
  if(cStep<=steps){
    float t = cStep*(tmax-tmin)/steps + tmin;
    //drawMyLine(fx(t), fy(t), fx2(t), fy2(t));
    drawMyLine(fx(p1*t, r1), fy(p1*t, r1), fx(p2*t, r2), fy(p2*t, r2));
    cStep++;
  }
  b1.checkHover(mouseX, mouseY);
  b1.update();
  b2.checkHover(mouseX, mouseY);
  b2.update();
}


class Button{
  int myX, myY, myW, myH, myType;
  String myText;
  boolean isHovered = false;
  public Button(int x, int y, int w, int h, String text, int type){
    myX = x;
    myY = y;
    myW = w;
    myH = h;
    myText = text;
    myType = type;
  }
  public boolean checkHover(int mX, int mY){
    isHovered = (mX >= myX && mX <= myX+myW && 
      mY >= myY && mY <= myY+myH);
    return isHovered;
  }
  public void update(){
    if(isHovered){
      stroke(255, 255, 255);
    }else{
      stroke(100,100,100);
    }
    
    fill(100, 100, 100);
    rect(myX, myY, myW, myH);
  }
  public void mousePressed(){
    if(isHovered){
      if(shape!=0){
        shape = 0;
        cStep = 0;
        clear();
      }
    }
  }
}
class ButtonCircle{
  int myX, myY, myW, myH, myType;
  String myText;
  boolean isHovered = false;
  public ButtonCircle(int x, int y, int w, int h, String text, int type){
    myX = x;
    myY = y;
    myW = w;
    myH = h;
    myText = text;
    myType = type;
  }
  public boolean checkHover(int mX, int mY){
    float distX = mX - myX;
    float distY = mY - myY;
    isHovered = (sqrt(sq(distX) + sq(distY)) < myW/2);
    return isHovered;
  }
  public void update(){
    if(isHovered){
      stroke(255, 255, 255);
    }else{
      stroke(100,100,100);
    }
    
    fill(100, 100, 100);
    ellipse(myX, myY, myW, myH);
  }
  public void mousePressed(){
    if(isHovered){
      if(shape!=1){
        shape = 1;
        cStep = 0;
        clear();
      }
    }
  }
}
