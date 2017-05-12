class Tree
{
  float treeY;
  float base;
  float x;
  float z;
  float theta = 0.0f;
  ArrayList leafs = new ArrayList();
  PVector initPos;
  float red;
  float green;
  float blue;
  
  Tree(float _treeY, PVector _initPos)
  {
    treeY = _treeY;
    base = _treeY/4;
    initPos = _initPos;
    red = 100;
    green = 100;
    blue = 100;
  }
  
  void render()
  {
    stroke(0);
    for (int t=0; t<treeY; t++){
      float trunkWidth = map(t, 0, treeY, treeY/16, 0.1);
      strokeWeight(trunkWidth);
      line(initPos.x,initPos.y,initPos.z,initPos.x,-t,initPos.z);
    }
    
    for(float i = 0; i < base; i++){
      base -= 1;
      drawBranch(base);
    }
    

    for(int i = 0; i < leafs.size(); i+=2) {
       x = (Float) leafs.get(i);
       z = (Float) leafs.get(i+1);
       float branchW = map(i, 0, leafs.size(), 3, 0.1);
       strokeWeight(branchW);       
       stroke(red,green,blue);
       pushMatrix();
         translate(0, (treeY/2)-6, 0);
         line(initPos.x,(-i/3)-(treeY/2)-2,initPos.z, x,(-i/3)-treeY/2,z);
       popMatrix();
    }
    
  }
 
  void drawBranch (float radius)
  {
    for (int i = 0; i < TWO_PI; i++){
      x = initPos.x + radius * cos(theta);
      z = initPos.z + radius * sin(theta);
      leafs.add(x);
      leafs.add(z);
      theta += 1;
    }
  }
  
  void updateColors(float _red, float _green, float _blue) {
    red = _red;
    green = _green;
    blue = _blue;
  }


}