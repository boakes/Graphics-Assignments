class Leaf{
  float min = 6;
  color[] palette;
  int c;
  float x,y;
  float w,h;
  Leaf left;
  Leaf right;
  
  Leaf(float _x, float _y,float _w, float _h,color[] _palette){
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    palette = _palette;
    c = (noise(randomGaussian()) > .4 ? 0 : (int) random(_palette.length-1)+1 );
  }

  boolean split(){
      if(left != null || right != null){ return false; }
      boolean splitH = noise(randomGaussian()) > .5;
      if(w > h && w / h >=1.25){
        splitH = false;
      }
      else if(h > w && h / w >= 1.25){
        splitH = true;
      }
      
      float max = (splitH ? h : w) - min;
      if(max <= min){ return false; }
      
      float split = random(min, max);
      if(splitH){
        left = new Leaf(x, y, w, split,palette);
        right = new Leaf(x, y+split, w, h - split,palette);
      }
      else{
        left = new Leaf(x,y,split,h,palette);
        right = new Leaf(x+split,y,w-split,h,palette);
      }
      return true;
  }
  
  void draw(){
    fill(palette[c]);
    rect(x,y,w,h);
  }
  
}