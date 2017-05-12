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

ShellObj shell;
PImage img;

Vec3D horiz = new Vec3D(1,0,0);
Vec3D vert = new Vec3D(0,1,0);
Vec3D out = new Vec3D(0,0,1);
Vec3D deltX, deltY;
Vec3D mouseV = new Vec3D(0,0,0); 
Vec3D rotAxis = new Vec3D(0,-100,0);

void setup(){
  size(800,800,P3D);
  img = loadImage("shellTex.jpg");
  
  shell = new ShellObj(0,0,0,25,40,img);
  translate(width/2,height/2);
  scale(50);
  pushMatrix();
  
}

void draw(){
  popMatrix();
  background(0);
  ambientLight(255,255,255);

  shell.display();
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