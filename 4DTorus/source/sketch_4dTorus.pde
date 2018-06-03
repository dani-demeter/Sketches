int sw = 1000;
int sh = 600;
int Sres = 20;
int Tres = 20;
float maxS = 3.1415;
float maxT = 3.1415;
float minS = -3.1415;
float minT = -3.1415;
float sizeRatio = 50;

float xs[] = new float[Sres*Tres];
float ys[] = new float[Sres*Tres];
float zs[] = new float[Sres*Tres];

float a = -3.1415;
float astep = 0.01;

int r = 0;
int g = 165;
int b = 150;

int lineCounter = 0;
int lineTypes = 2;
void setup(){
  size(1000,600);
  background(28, 29, 33);
  //noLoop();
}
void mouseClicked(){
  lineCounter = (lineCounter + 1)%lineTypes;
}
void draw(){
  clear();
  background(28, 29, 33);
  a += astep;
  for (int s = 0; s < Sres; s++){
    for (int t = 0; t < Tres; t++){
      float cS = ((float)((maxS-minS) * s) / Sres) + minS;
      float cT = ((float)((maxT-minT) * t) / Tres) + minT;
      float x = (1/(sqrt(2)-fv(cS, cT)))*fx(cS, cT);
      float y = (1/(sqrt(2)-fv(cS, cT)))*fy(cS, cT);
      float z = (1/(sqrt(2)-fv(cS, cT)))*fu(cS, cT);
      xs[s*Tres+t] = x;
      ys[s*Tres+t] = y;
      zs[s*Tres+t] = z;
      drawMyPoint(x, y, z);
    }
  }
  for (int s = 0; s < Sres; s++){
    for (int t = 0; t < Tres; t++){
      drawMyLines(s, t);
    }
  }
}
void drawMyLines(int s, int t){
  if(lineCounter==0){
    drawLineBetween(xs[s*Tres+t], ys[s*Tres+t], zs[s*Tres+t], xs[(s*Tres+t+1)%Tres+s*Tres], ys[(s*Tres+t+1)%Tres+s*Tres], zs[(s*Tres+t+1)%Tres+s*Tres]);
    drawLineBetween(xs[s*Tres+t], ys[s*Tres+t], zs[s*Tres+t], xs[((s+1)*Tres+t)%(Tres*Sres)], ys[((s+1)*Tres+t)%(Tres*Sres)], zs[((s+1)*Tres+t)%(Tres*Sres)]);
  }else if(lineCounter==1){
    drawLineBetween(xs[s*Tres+t], ys[s*Tres+t], zs[s*Tres+t], xs[((s*Tres+t+1)%Tres+(s+1)*Tres)%(Sres*Tres)], ys[((s*Tres+t+1)%Tres+(s+1)*Tres)%(Sres*Tres)], zs[((s*Tres+t+1)%Tres+(s+1)*Tres)%(Sres*Tres)]);
  }
}
float fx(float s, float t){
  return cos(s);
}
float fy(float s, float t){
  return cos(a)*sin(s)+sin(a)*sin(t);
}
float fu(float s, float t){
  return cos(t);
}
float fv(float s, float t){
  return -sin(a)*sin(s)+cos(a)*sin(t);
}
void drawLineBetween(float x1, float y1, float z1, float x2, float y2, float z2){
  stroke(r, g, b, getFillValue(-(z1+z2)/2));
  //stroke(255, 255, 255);
  line(x1*sizeRatio + (sw/2), y1*sizeRatio + (sh/2), x2*sizeRatio + (sw/2), y2*sizeRatio + (sh/2));
}
void drawMyPoint(float x, float y, float z){
  fill(r, g, b, getFillValue(-z));
  ellipse(x*sizeRatio + (sw/2), y*sizeRatio +(sh/2), 2, 2);
}
int getFillValue(float z){
  if(z*sizeRatio<-127){
    return 0;
  }else if(z*sizeRatio>127){
    return 255;
  }else{
    return (int)(z*sizeRatio+127);
  }
}
