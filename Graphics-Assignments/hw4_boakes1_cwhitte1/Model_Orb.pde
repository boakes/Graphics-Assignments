class Orb {
  int nSegs;
  float r;
  PImage img;
  
  Orb(float radius, int numSegments, PImage texture) {
    nSegs = numSegments;
    r = radius;
    img = texture;
  }
  
  void display() {
    beginShape(QUADS);
    texture(textureOrb);
    float uStep = 2*PI/nSegs;
    float vStep = PI/nSegs;
    for(float u=0; u<2*PI; u+=uStep) {
      for(float v=-PI/2; v<PI/2; v+=vStep) {
        createVertex(u,v);
        createVertex(u+uStep,v);
        createVertex(u+uStep,v+vStep);
        createVertex(u,v+vStep);   
      }
    }
    endShape();
  }
  
  void createVertex(float u, float v) {
    float x = xpos(u,v);
    float y = ypos(u,v);
    float z = zpos(u,v);
    PVector norm = new PVector(x,y,z);
    norm.normalize();
    normal(-norm.x,-norm.y,-norm.z);
    strokeWeight(1);
    stroke(map(u,0,2*PI,0,255),map(v,-PI,PI,0,255),0);
    noStroke();
    //println(textureOrb.width);
    vertex(x,y,z, map(u, 0,2*PI, textureOrb.width,0), map(v, -PI/2,PI/2, 0,textureOrb.height));
  }
  
  float xpos(float u, float v) {
    return r * sin(u) * cos(v);
  }
  float ypos(float u, float v) {
    return r * cos(u) * cos(v);
  }
  float zpos(float u, float v) {
    return r * sin(v);
  }
}