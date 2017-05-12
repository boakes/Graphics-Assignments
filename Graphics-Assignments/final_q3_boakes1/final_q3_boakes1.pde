import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

PShader pointShade;
PImage img;
PImage img1;
ParticleSystem ps;
ParticleSystem ps1;
ArrayList<PVector> pts;

float weight = 100;
float rot = 0;

Minim minim;
AudioPlayer song;

void setup() {
  size(500,500,P3D);
  //img = loadImage("tree1.png");
  //img = loadImage("cloud1.png");
  //img = loadImage("billboard.jpg");
 
  minim = new Minim(this);
  song = minim.loadFile("420.mp3");
 
  //img = loadImage("vapor.png");
  img = loadImage("bustmac.gif");
  
  ps = new ParticleSystem(0,new PVector(width/2,height/2,-150));
  ps1 = new ParticleSystem(5,new PVector(width/2,height/2,-50));
  
  pts = new ArrayList<PVector>();
  //pointShade = loadShader("ptfrag.glsl","ptvert.glsl");
  pointShade = loadShader("ptfragbb.glsl","ptvertbb.glsl");
  //pointShade = loadShader("ptcircfrag.glsl","ptcircvert.glsl");
  //pointShade = loadShader("ptspherefrag.glsl","ptspherevert.glsl");
  pointShade.set("weight", weight);
  pointShade.set("sprite", img);
  song.play();
}

void draw() {
  background(color(255,105,180));
  shader(pointShade, POINTS);
  float dx = map(mouseX,0,width,-0.2,0.2);
  PVector ap = new PVector(dx,0,0);
  pointShade.set("litPos",new PVector((mouseX-width/2)*3,(mouseY-height/2)*3,600));
  
  translate(width/2,height/2);
  rotateX(rot);
  translate(-width/2,-height/2);
  
  strokeWeight(weight);
  strokeCap(SQUARE);
  stroke(255);
  
 
  ps.applyForce(ap);
  ps.run();
  if(ps.thisSize() < 50){
    ps.addParticle();
  }
  
  
  ps1.run();
  if(ps1.thisSize() < 100){
  ps1.addParticle();
  }
  

  if(mousePressed && mouseButton == LEFT) {
    if(keyPressed) {
      pts.add(new PVector(mouseX,mouseY, -200));
    } else {
      pts.add(new PVector(mouseX,mouseY,0));
    }
  } 
  //for(PVector pt : pts) { point(pt.x,pt.y,pt.z); }
}

void mouseDragged() {
  if(mouseButton == RIGHT) {
    rot += float(mouseY - pmouseY)/width;
  }
}