class MyTree{
  color[] palette;
  Leaf[] tree;
  int lastInd = 0;
  MyTree(color[] _palette){
    palette = _palette;
    tree = new Leaf[65];  
    tree[0] = (new Leaf(0,0,width,height,palette));
    lastInd++;
  }
  
  void build(){
    boolean split = true;
    
    while(split){
      split = false;
      for(Leaf l : tree){
        if((lastInd+2 < 64) && l.left==null && l.right ==null ){
          if(l.w > 20f || l.h > 20f || noise(randomGaussian()) > .25){
            if(l.split()){
              tree[lastInd] = l.left;
              lastInd++;
              tree[lastInd] = l.right;
              lastInd++;
            }
          }
        }
      }
    }
  }

  
}