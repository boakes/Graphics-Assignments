class Mobius {
  float r, x, y, z;
  PImage img;
  int nSeg;
 
  Mobius(float _r, int _nSeg, PImage _img) {
    r = _r;
    x = 0;
    y = 0;
    z = 0;
    nSeg = _nSeg;
    img = _img;
  }
  
  Mobius(float _x, float _y, float _z, float _r, int _nSeg, PImage _img) {
    r = _r;
    x = _x;
    y = _y;
    z = _z;
    nSeg = _nSeg;
    img = _img;
  }
  
  void display() {
    beginShape(QUADS);
    texture(img);
    noStroke();
    float uStep = TAU/nSeg;
    float vStep = (2*r)/nSeg;
    for(float u=0; u<TAU; u+=uStep) {
      for(float v=-r; v<r; v+=vStep) {              
        createVertex(u,v); 
        createVertex(u+uStep,v);
        createVertex(u+uStep,v+vStep);
        createVertex(u,v+vStep);
      }
    }
    endShape();
  }
  
  
  void createVertex(float u, float v){
    float x = xpos(u,v);
    float y = ypos(u,v);
    float z = zpos(u,v);
    PVector norm = new PVector(x,y,z);
        
    norm.normalize();
    //normal(norm.x,norm.y,norm.z);
    vertex(x,y,z,map(u,0,TAU,0,img.width),map(v,-r,r,0,img.height));
  //  vertex(-x,-y,-z,-1*map(-x,-r*2,r*2,0,img.width),-1*map(-y,-r*2,r*2,0,img.height));
  }
  
  private PVector makeVector(float u, float v) {
    return new PVector(xpos(u,v), ypos(u,v), zpos(u,v));
  }
  
  private float xpos(float u, float v) {
 //   println( x + (r + (v/2) * cos(u/2))*cos(u));
    return x + (r + (v/2) * cos(u/2))*cos(u);

  }
  private float ypos(float u, float v) {
    return y + (r + (v/2) * cos(u/2))*sin(u);
  }
  private float zpos(float u, float v) {
    return z + (v/2)*sin(u/2);
  }
}