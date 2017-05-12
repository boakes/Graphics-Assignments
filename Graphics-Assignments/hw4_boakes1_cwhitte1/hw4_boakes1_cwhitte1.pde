import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

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

Vec3D up = new Vec3D(-0.0195, 0.2047137, 0.978626);
Vec3D forward = new Vec3D(0.22637334, -0.95233023, 0.20450477);
Vec3D eye = new Vec3D(642, 1377, -167);
Vec3D center = eye.add(forward);
Vec3D right = up.cross(forward);

PImage textureOrb;
PImage textureMob;
Orb orbB;
Mobius mob; 

Set<Character> keys = new HashSet<Character>();

int cols, rows, w, h;
int scale = 15;
float[][] terrain;
float dirX =0;
float dirY =0;

Minim minim;
AudioPlayer song;
FFT fft;
String label;

ArrayList<Tree> trees;

float rotationX, rotationY, velocityX, velocityY = 0;

void setup() {
  size(800, 800, P3D);
  w = width*2;
  h = height*2;

  cols = w/scale;
  rows = h/scale;
  terrain = new float[cols][rows];
  
/*
  float yoff = 0.0;
  for (int y=0; y<rows; y++) {
    float xoff = 0.0;
    for (int x=0; x<cols; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -100, 100);
      xoff+= 0.1;
    }
    yoff += 0.1;
  }
  */
  minim = new Minim(this);
  song = minim.loadFile("420.mp3", 1024);
  AudioMetaData meta = song.getMetaData();
  label = meta.title() + " (" + meta.author() + ")"; 
  
  song.play();
  fft = new FFT(song.bufferSize(), song.sampleRate());
  
  trees = new ArrayList<Tree>();
  for (int i = 0; i < 120; i++) 
  { 
    trees.add( new Tree( random(50, 160), new PVector(random(-600, 800), 0, random(-900, 400)) ) ); 
  } 
  
  textureOrb = loadImage("dolphins.jpg");
  textureMob = loadImage("cup.jpg");
  orbB = new Orb(70,10,textureOrb);
  mob = new Mobius(50,30,textureMob);
  up.normalize();
  forward.normalize();
}


void draw() {
  background(0);

  rotationX += velocityX; 
  rotationY += velocityY; 
  velocityX = 2; 
  velocityY = 2;   
  //translate(width/2,height/2);
  //rotateX(0);
  //translate(-w/2,-h/2);
  
 
  
  fft.forward(song.left);
  float freqRed = min(255, 25*fft.calcAvg(fft.indexToFreq(0), fft.indexToFreq(10)));
  float freqGreen = min(255, 25*fft.calcAvg(fft.indexToFreq(10), fft.indexToFreq(20)));
  float freqBlue = min(255, 25*fft.calcAvg(fft.indexToFreq(20), fft.indexToFreq(30)));
  
  
  pushMatrix();
  translate(600,400,00);
  rotateX(HALF_PI);
  for (int i = 0; i < trees.size(); i++) { 
    Tree tree = (Tree) trees.get(i); 
    tree.updateColors(400-freqRed,300-freqGreen,400-freqBlue); // playing around with color constants
    tree.render(); 
  } 
  popMatrix();
  
  //Mobius Column
  pushMatrix();
  translate(600,400,-100);
  rotateX(HALF_PI);
  fill(255);
  stroke(0);
  strokeWeight(0);
  Column(20,30,200);
  popMatrix();
  
  pushMatrix();
  translate(600,400,-300);
    rotateX(radians(-TWO_PI-rotationX)); 
    rotateY(radians(rotationY)); 
    mob.display();
  popMatrix();
  
  //Sphere Column
  pushMatrix();
  translate(800,800,-100);
  rotateX(HALF_PI);
  fill(255);
  stroke(0);
  strokeWeight(0);
  Column(20,30,200);
  popMatrix();
  
  pushMatrix();
  translate(800,800,-300);
    rotateX(radians(-TWO_PI-rotationX)); 
    rotateY(radians(-rotationY)); 
    orbB.display();
  popMatrix();
  

  stroke(color(199, 116, 232));
  fill(0);
  strokeWeight(1);
  for (int y=0; y<rows-1; y++) {
    beginShape(QUAD);
    for (int x=0; x<cols-1; x++) {
      vertex(x*scale, y*scale, 0);
      vertex((x+1)*scale, y*scale, 0);
      vertex((x+1)*scale, (y+1)*scale, 0);
      vertex(x*scale, (y+1)*scale, 0);
    }
    endShape();
  }

  dirX = mouseX-pmouseX;
  dirY = mouseY-pmouseY;

  if (mousePressed) {
    up.rotateAroundAxis(forward, map(dirX, 0, width, 0, -TWO_PI));
    println(eye);
    println(up);
    println(forward);
  } else {

    forward.rotateAroundAxis(up, map(dirX, 0, width, 0, -TWO_PI));
    forward.normalize();

    up.rotateAroundAxis(right, -dirY/360.0);
    up.normalize();
    forward.rotateAroundAxis(right, -dirY/360.0);
    forward.normalize();
  }
  if (keys.contains('w')) {        
    eye = eye.add(forward.scale(3));
  }
  if (keys.contains('s')) {        
    eye = eye.sub(forward.scale(3));
  }
  if (keys.contains('a')) {        
    eye = eye.add(right.scale(3));
  }
  if (keys.contains('d')) {        
    eye = eye.sub(right.scale(3));
  }


  beginCamera();
  center = eye.add(forward);
  right = up.cross(forward);
  right.normalize();

  camera(eye.x, eye.y, eye.z, center.x, center.y, center.z, up.x, up.y, up.z);
  endCamera();
}

void keyPressed() {
  switch(key) {
  case 'W':
  case 'w':
    keys.add('w');
    break;
  case 'S':
  case 's': 
    keys.add('s');
    break;
  case 'A':
  case 'a':
    keys.add('a');
    break;
  case 'D':
  case 'd':
    keys.add('d');
    break;
  default:
    break;
  }
}

void keyReleased() {
  switch(key) {
  case 'W':
  case 'w':
    keys.remove('w');
    break;
  case 'S':
  case 's': 
    keys.remove('s');
    break;
  case 'A':
  case 'a':
    keys.remove('a');
    break;
  case 'D':
  case 'd':
    keys.remove('d');
    break;
  default:
    break;
  }
}