void setup(){
  background(0);
  size(800,800);
}
void draw(){
  translate(width/2,height/2);  
  scale(.45);
  rotate(-PI/6);
  int steps = 60;
  color curCol = color(0);
  for(int x=0;x<steps;x++){
      float theta = map(x,0,steps,0,2*PI);
      if(theta <= PI){
        curCol = lerpColor(color(0,0,255),color(255,0,0),map(x,0,steps/2,0f,1f));
      }else{
        curCol = lerpColor(color(255,0,0),color(0,0,255),map(x,steps/2,steps,0f,1f));
      }
      stroke(curCol);
      fill(curCol);
      ellipse(800*cos(theta),400*sin(theta),20,20);    
  }
}