class ShellObj {
 
  float r, x, y, z;
  PImage img;
  int nSeg;
 
  ShellObj(float _x, float _y, float _z, float _r, int _nSeg, PImage _img) {
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
    float tStep = PI/nSeg;
    float sStep = TAU/nSeg;
    for(float t=0; t<PI; t+=tStep) {
      for(float s=0; s<TAU; s+=sStep) {         
          createVertex(t,s);
          createVertex(t+tStep,s);
          createVertex(t+tStep,s+sStep);
          createVertex(t,s+sStep);
      }
    }
    endShape();
  }

  void createVertex(float u, float v){
    float x = xpos(u,v);
    float y = ypos(u,v);
    float z = zpos(u,v);
    vertex(x,y,z,map(u,0,PI,0,img.width),map(v,0,TAU,0,img.height));
  }
  
  private float xpos(float t, float s) {
    return x + pow((4.0/3.0),s) * (sin(t)*sin(t)) * cos(s);
  }
  private float ypos(float t, float s) {
    return y + pow((4.0/3.0),s) * (sin(t)*sin(t)) * sin(s);
  }
  private float zpos(float t, float s) {
    return z + pow((4.0/3.0),s) * sin(t) * cos(t);
  }
}