import toxi.audio.*;
import toxi.color.*;
import toxi.color.theory.*;
import toxi.data.csv.*;
import toxi.data.feeds.*;
import toxi.data.feeds.util.*;
import toxi.doap.*;
import toxi.geom.*;
import toxi.geom.mesh.*;
import toxi.geom.mesh.subdiv.*;
import toxi.geom.mesh2d.*;
import toxi.geom.nurbs.*;
import toxi.image.util.*;
import toxi.math.*;
import toxi.math.conversion.*;
import toxi.math.noise.*;
import toxi.math.waves.*;
import toxi.music.*;
import toxi.music.scale.*;
import toxi.net.*;
import toxi.newmesh.*;
import toxi.nio.*;
import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.physics2d.constraints.*;
import toxi.physics3d.*;
import toxi.physics3d.behaviors.*;
import toxi.physics3d.constraints.*;
import toxi.processing.*;
import toxi.sim.automata.*;
import toxi.sim.dla.*;
import toxi.sim.erosion.*;
import toxi.sim.fluids.*;
import toxi.sim.grayscott.*;
import toxi.util.*;
import toxi.util.datatypes.*;
import toxi.util.events.*;
import toxi.volume.*;

float angle = 0;


Vec3D horiz = new Vec3D(1,0,0);
Vec3D vert = new Vec3D(0,1,0);
Vec3D out = new Vec3D(0,0,1);
Vec3D deltX, deltY;

Vec3D mouseV = new Vec3D(0,0,0); 
Vec3D rotAxis = new Vec3D(0,-100,0);

PImage img;
int imgNum = 0;

ArrayList<Mobius> mps;
Mobius mp1;
Mobius mp2;

void setup(){
  
  size(800,800,P3D);
  mps = new ArrayList<Mobius>();
 // isect = sp1.tree.intersection(bp1.tree);
 // union = sp1.tree.union(bp1.tree);
 // diff = sp1.tree.difference(bp1.tree);
  
  switch(imgNum){
    case 0: img = loadImage("jupiter.jpg");
    break;
    case 1: img = loadImage("earth.jpg");
    break;
    case 2: img = loadImage("grid.png");
    break;
  }
  
  
  mouseV= new Vec3D(0,0,0);
  rotAxis = new Vec3D(0,-100,0);
 // rp1 = new RomanBSP(0,0,0,15,20,img);

  mp1 = new Mobius(0,0,0,75,40,img);
  mp2 = new Mobius(75,0,0,100,40,img);
  mps.add(mp1);
  mps.add(mp2);
  translate(width/2,height/2);
  pushMatrix();
}

void draw(){
  popMatrix();
  ambientLight(50,50,50);
  pointLight(255,255,255, mouseX*2-mouseX,mouseY*2-mouseY,width);

  background(0);
  
  
  
  //rotateAroundAxis(rotAxis,m.magnitude());
  stroke(255);
  strokeWeight(5);
  line(0,0,0,rotAxis.x,rotAxis.y,rotAxis.z);
  //println(m.magnitude());
  //
    
if(!keyPressed) {
   // buildPrism();
 // buildMobius(200);
 
  pushMatrix();
  int rot=0;
  for(Mobius a: mps){
    
    rotateX(HALF_PI*rot);
    a.display();
    rot+=1;
    
  }
  popMatrix();
      //rp1.display();
    //sp3.display();
   // sp1.display();
  } 
   
  
 // rotateAroundAxis(rotAxis,m.magnitude());
  stroke(255,0,0);
  line(-horiz.x*width,-horiz.y,-horiz.z,horiz.x*width,horiz.y,horiz.z);
  stroke(0,255,0);
  line(-horiz.x,-horiz.y*height,-horiz.z,horiz.x,horiz.y*height,horiz.z);
  stroke(0,0,255);
  line(-out.x,-out.y,-out.z*width,out.x,out.y,out.z*width);
  
  //box(50);
  pushMatrix();
 
}

void mouseDragged(){
  popMatrix();
  
  mouseV = horiz.scale((mouseX-pmouseX)).add(vert.scale((mouseY-pmouseY)));
  if(mouseButton == LEFT){rotAxis = (mouseV.cross(out)).normalize();}
  if(mouseButton == RIGHT){rotAxis = (mouseV.cross(vert)).normalize();}
  //println(rotAxis.x);
  //probably a better way to check to see if rot is the zero vec or not
  if(rotAxis.magnitude() != 0){
  rotateAroundAxis(rotAxis,mouseV.magnitude()/180);
  horiz.rotateAroundAxis(rotAxis,-mouseV.magnitude()/180);
  vert.rotateAroundAxis(rotAxis,-mouseV.magnitude()/180);
  out.rotateAroundAxis(rotAxis,-mouseV.magnitude()/180);
  }
  pushMatrix();
}



void rotateAroundAxis(Vec3D axis, float theta) {
  Vec3D w = axis.copy();
  w.normalize();
  Vec3D t = w.copy();
  
  if (abs(w.x) == min(abs(w.x), abs(w.y), abs(w.z))) {
    t.x = 1;
  } else if (abs(w.y) == min(abs(w.x), abs(w.y), abs(w.z))) {
    t.y = 1;
  } else if (abs(w.z) == min(abs(w.x), abs(w.y), abs(w.z))) {
    t.z = 1;
  }
  Vec3D u = w.cross(t);
  u.normalize();
  Vec3D v = w.cross(u);
  applyMatrix(u.x, v.x, w.x, 0, 
  u.y, v.y, w.y, 0, 
  u.z, v.z, w.z, 0, 
  0.0, 0.0, 0.0, 1);
  rotateZ(theta);
  applyMatrix(u.x, u.y, u.z, 0, 
  v.x, v.y, v.z, 0, 
  w.x, w.y, w.z, 0, 
  0.0, 0.0, 0.0, 1);
}

void buildPrism(){
  createShape();//TRIANGLE_STRIP);
  beginShape(TRIANGLES);
  for(float u=0;u<200;u+=100){
    for(float v=0;v<200;v+=100){
      vertex(u,v,0);  
      vertex(u+100,v,0);
      vertex(u+100,v+100,0);
      
      vertex(u,v,0);
      vertex(u+100,v+100,0);
      vertex(u,v+100,0);
    }
  }
  endShape();

}

/*
void buildMobius(float sc){
  createShape();
  beginShape(POINTS);
  float nsegs = 20; 
  float ustep = TWO_PI/nsegs;
  float vstep = (2*sc)/nsegs;
  for(float u=0;u<TWO_PI;u+=ustep){
    for(float v=-1*sc;v<=1*sc;v+=vstep){
     Vec3D a = createVec3D(u,v);
     Vec3D b = createVec3D(u+ustep,v);
     Vec3D c = createVec3D(u+ustep,v+vstep);
     Vec3D d = createVec3D(u,v+vstep);
    
     vertex(a.x,a.y,a.z);
     vertex(b.x,b.y,b.z);
     vertex(c.x,c.y,c.z);
     
     
      vertex(a.x,a.y,a.z);
      vertex(c.x,c.y,c.z);
      vertex(d.x,d.y,d.z);
     // vertex((1 + v/2 * cos((u+ustep)/2))*cos(u+ustep),(1 + v/2 * cos((u+ustep)/2))*sin(u+ustep),(v/2)*sin((u+ustep)/2));

    }
  }
  endShape();
  
  
  
}

Vec3D createVec3D(float u,float v){
      float x = (1 + (v/2) * cos(u/2))*cos(u);
      float y = (1 + (v/2) * cos(u/2))*sin(u);
      float z = (v/2)*sin(u/2);

      return new Vec3D(x,y,z);
}
*/