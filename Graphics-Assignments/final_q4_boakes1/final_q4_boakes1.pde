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
import java.util.*;

Vec3D horiz = new Vec3D(1,0,0);
Vec3D vert = new Vec3D(0,1,0);
Vec3D out = new Vec3D(0,0,1);
Vec3D deltX, deltY;
Vec3D mouseV = new Vec3D(0,0,0); 
Vec3D rotAxis = new Vec3D(0,-100,0);

Set<Character> keys = new HashSet<Character>();

float angleQW = 0.0;
float angleAS = 0.0;
float angleTY = 0.0;
float angleGH = 0.0;
float angleOP = 0.0;

void setup(){
  size(800,600,P3D);
  translate(width/2,height/2);
  pushMatrix();
}

void draw(){
  popMatrix();
  background(0);
  noStroke();
  if(!keys.isEmpty()){
     if(keys.contains('q')){
        angleQW += 10.0;
      }
      if(keys.contains('w')){
        angleQW -= 10.0;
      }
      if(keys.contains('a')){
        angleAS += 10.0;
      }
      if(keys.contains('s')){
        angleAS -= 10.0;
      }
      if(keys.contains('t')){
        angleTY += 10.0;
      }
      if(keys.contains('y')){
        angleTY -= 10.0;
      }
      if(keys.contains('g')){
        angleGH += 10.0;
      }
      if(keys.contains('h')){
        angleGH -= 10.0;
      }
      if(keys.contains('o')){
        angleOP += 10.0;
      }
      if(keys.contains('p')){
        angleOP -= 10.0;
      }
      
  }
  
  
  fill(color(0,0,255));
  sphere(20);
  pushMatrix();
  
  rotateZ(angleQW/360.0);
  
  translate(60,0);
  rotateX(angleAS/360.0);
  fill(color(0,255,0));
  box(80.0,10.0,10.0);
  
  translate(60,0);
  rotateZ(angleTY/360.0);
  fill(color(0,0,255));
  sphere(20);
  
  translate(60,0);
  rotateX(angleGH/360.0);
  fill(color(0,255,0));
  box(80.0,10.0,10.0);
  
  translate(60,0);
  rotateZ(angleOP/360.0);
  fill(color(0,0,255));
  sphere(20);
  
  
  translate(20,0);
  fill(color(0,255,0));
  box(40.0,10.0,10.0);

  popMatrix();
  pushMatrix();
}

void keyPressed(){
  switch (key){
    case 'q': 
       keys.add('q');
       break;
    case 'w': 
       keys.add('w');
       break;
    case 'a': 
       keys.add('a');
       break;
    case 's':
       keys.add('s');
       break;
    case 't':
       keys.add('t');
       break;
    case 'y':
       keys.add('y');
       break;
    case 'g':
       keys.add('g');
       break;
    case 'h':
       keys.add('h');
       break;
    case 'o':
       keys.add('o');
       break;
    case 'p':
       keys.add('p');
       break;
    default: 
       break;
  }  
}

void keyReleased(){
  switch (key){
    case 'q': 
       keys.remove('q');
       break;
    case 'w': 
       keys.remove('w');
       break;
    case 'a': 
       keys.remove('a');
       break;
    case 's':
       keys.remove('s');
       break;
    case 'g':
       keys.remove('g');
       break;
    case 'h':
       keys.remove('h');
       break;
    case 't':
       keys.remove('t');
       break;
    case 'y':
       keys.remove('y');
       break;
    case 'o':
       keys.remove('o');
       break;
    case 'p':
       keys.remove('p');
       break;
    default: 
       break;
  }  
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