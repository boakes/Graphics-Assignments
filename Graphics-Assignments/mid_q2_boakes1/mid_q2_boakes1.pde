void setup(){
  background(0);
  size(800,800);
}

void draw(){
  background(0);
  translate(width/2,height/2);
  fracCirc(540);   
}

void fracCirc(float r){
  ellipse(0,0,r,r);
    if(r > 25){
      for(int x=0;x<5;++x){
       rotate(TWO_PI/5);
       pushMatrix();
       translate(2f/9f * r,2f/9f * r);
       fracCirc(r*.37);
       popMatrix();
      }
    }
}