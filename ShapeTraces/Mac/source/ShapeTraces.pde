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
ArrayList<Button> sqButtons = new ArrayList<Button>();
int shape = 0;
void setup(){
  size(1000, 600);
  //noLoop();
  background(28, 29, 32);
  
  Button b1 = new Button(25, 25, 30, 30, 0, 0, 0);
  Button b2 = new Button(40, 80, 30, 30, 0, 1, 0);
  sqButtons.add(b1);
  sqButtons.add(b2);
  for(int i=1; i<6; i++){
    for(int j=1; j<6; j++){
      Button tmp = new Button(i*15 + 25, j*15+500, 10, 10, 1, i, j);
      sqButtons.add(tmp);
    }
  }
}
void mousePressed(){
  for(int i=0; i<sqButtons.size(); i++){
    sqButtons.get(i).mousePressed();
  }
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
  for(int i=0; i<sqButtons.size(); i++){
    sqButtons.get(i).checkHover(mouseX, mouseY);
    sqButtons.get(i).update();
  }
}


class Button{
  int myX, myY, myW, myH, myType, myValue1, myValue2;
  boolean isHovered = false;
  public Button(int x, int y, int w, int h, int type, int value1, int value2){
    myX = x;
    myY = y;
    myW = w;
    myH = h;
    myValue1 = value1;
    myValue2 = value2;
    myType = type;
  }
  public boolean checkHover(int mX, int mY){
    if(myType==0 && myValue1 == 1){
      float distX = mX - myX;
      float distY = mY - myY;
      isHovered = (sqrt(sq(distX) + sq(distY)) < myW/2);
    }else{
      isHovered = (mX >= myX && mX <= myX+myW && mY >= myY && mY <= myY+myH);
    }
    return isHovered;
  }
  public void update(){
    if(isHovered){
      stroke(255, 255, 255);
    }else{
      stroke(100,100,100);
    }
    fill(100, 100, 100);
    if(myType==0 && myValue1 == 1){
      ellipse(myX, myY, myW, myH);
    }else{
      rect(myX, myY, myW, myH);
    }
  }
  public void mousePressed(){
    if(isHovered){
      if(myType==0){
        if(shape!=myValue1){
          shape = myValue1;
          cStep = 0;
          clear();
          background(28, 29, 32);
        }
      }else if(myType == 1){
        p1 = myValue1;
        p2 = myValue2;
        cStep = 0;
        clear();
        background(28, 29, 32);
      }
    }
    
  }
}
