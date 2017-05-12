MyTree tree;
color[] palette;

void setup(){
  
  palette = new color[6];
  palette[0] = color(255);
  palette[1] = color(101,104,148);
  palette[2] = color(253,113,113);
  palette[3] = color(253,255,0);
  palette[4] = color(110,178,100);
  
  tree = new MyTree(palette);
  tree.build();
  
  
  background(255);
  size(1366,768);
}
void draw(){
  stroke(0);
  strokeWeight(3);
  for(Leaf l:tree.tree){
     if(l != null) l.draw();
  }
}

void keyPressed(){
  randomSeed(millis()); 
  tree = new MyTree(palette);
  tree.build();
}