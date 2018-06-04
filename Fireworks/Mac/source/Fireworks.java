import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Fireworks extends PApplet {

ArrayList<Firework> fireworks = new ArrayList<Firework>();
float prbLaunch = 5;
public void setup(){
  
  background(28, 29, 32);
}
public void draw(){
  colorMode(RGB, 255);
  background(28, 29, 32);
  if(random(100)<prbLaunch){
    fireworks.add(new Firework());
  }
  for(int i=0; i<fireworks.size(); i++){
    if(fireworks.get(i).isFinished()){
      fireworks.remove(i);
    }else{
      fireworks.get(i).update();
    }
  }
}
class Firework{
  float startHeight = 600;
  float maxHeight = 500;
  float minHeight = 200;
  float maxWidth = 1000;
  float explHeight;
  float myX, myY;
  float speed;
  //float maxSpeed = 5;
  //float minSpeed = 1;
  float grav = 0.05f;
  boolean exploded = false;
  int trailLength = 10;
  float trys[] = new float[trailLength];
  int numOfDebree;
  int maxDebree = 15;
  int minDebree = 10;
  Debree[] debree = new Debree[maxDebree];
  int myHue;
  public Firework(){
    myHue = (int)(random(255));
    explHeight = random(minHeight, maxHeight);
    myX = random(maxWidth);
    myY = startHeight;
    //speed = random(minSpeed, maxSpeed);
    speed = explHeight/100;
    for(int i=0; i<trailLength; i++){
      trys[i] = myY;
    }
    numOfDebree = (int) random(minDebree, maxDebree);
  }
  public boolean isFinished(){
    if(exploded){
      for(int i=0; i<numOfDebree; i++){
        if(!debree[i].isFinished()){
          return false;
        }
      }
      return true;
    }else{
      return false;
    }
  }
  public void explode(){
    if(!exploded){
      exploded = true;
      for(int i=0; i<numOfDebree; i++){
        debree[i] = new Debree(myX, myY, myHue);
      }
    }else{
      for(int i=0; i<numOfDebree; i++){
        debree[i].update();
      }
    }
  }
  public void update(){
    if(myY<startHeight-explHeight){
      explode();
    }else{
      if(myY<startHeight-maxHeight+100){
        speed -= grav;
      }
      myY -= speed;
      scoochTrail(myY);
      noStroke();
      drawTrail();
      fill(255, 255, 255);
      ellipse(myX-1, myY-1, 2, 2);
    }
  }
  public void drawTrail(){
    colorMode(RGB, 255);
    fill(125, 125, 125, 125);
    for(int i=0; i<trailLength; i++){
      ellipse(myX-1, trys[i]-1, 2, 2);
    }
  }
  public void scoochTrail(float newY){
    for(int i=trailLength-1; i>0; i--){
      trys[i] = trys[i-1];
    }
    trys[0] = newY;
  }
  class Debree{
    float myX, myY;
    float lifetime = 1;
    float startTime;
    int trailLength = 10;
    float[] trxs = new float[trailLength];
    float[] trys = new float[trailLength];
    float vx, vy;
    float maxVX = 2;
    float minVX = 0;
    float maxVY = 2;
    float minVY = -1;
    float grav = 0.05f;
    int myHue;
    boolean isFinished = false;
    public Debree(float x, float y, int hue){
      startTime = second();
      if(startTime>58){
        startTime-=60;
      }
      for(int i=0; i<trailLength; i++){
        trxs[i] = x;
        trys[i] = y;
      }
      myHue = hue;
      myX = x;
      myY = y;
      vx = random(minVX, maxVX);
      if(random(1)>0.5f){
        vx *= -1;
      }
      vy = -random(minVY, maxVY);
    }
    public boolean isFinished(){
      return isFinished;
    }
    public void update(){
      if(second()>startTime+lifetime){
        scoochTrail();
        drawTrail();
      }else{
        myX += vx;
        vy += grav;
        myY += vy;
        scoochTrail(myX, myY);
        drawTrail();
      }
    }
    public void drawTrail(){
      colorMode(HSB, 255);
      for(int i=0; i<trailLength; i++){
        fill(myHue, 255, (int)((trailLength-i)*255/trailLength));
        ellipse(trxs[i]-2, trys[i]-2, 4, 4);
      }
    }
    public void scoochTrail(float nx, float ny){
      for(int i=trailLength-1; i>0; i--){
        trxs[i] = trxs[i-1];
        trys[i] = trys[i-1];
      }
      trxs[0] = nx;
      trys[0] = ny;
    }
    public void scoochTrail(){
      trxs[0] = -1;
      trys[0] = -1;
      //print("end scooching");
      for(int i=trailLength-1; i>=0; i--){
        if(trxs[i]>0 || trys[i]>0){
          trxs[i] = trxs[i-1];
          trys[i] = trys[i-1];
        }else{
          if(i<trailLength-1){
            trxs[i+1]=-1;
            trys[i+1]=-1;
          }else{
            isFinished = true;
          }
        }
      }
    }
  }
}
  public void settings() {  size(1000, 600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Fireworks" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
