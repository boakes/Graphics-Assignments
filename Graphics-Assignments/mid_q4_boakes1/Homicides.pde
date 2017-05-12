class Homicides{
  String country;
  float[] yValues;
  
  Homicides(String _country,float[] _yValues){
    country = _country;
    yValues = _yValues;
  }
  
  void draw(){
    for(int x=0; x< yValues.length-1;x++){
           float x1 = map(x,-1,9,0,width);
           float x2 = map(x+1,-1,9,0,width);
           float y1 = map(yValues[x],0,80,height-100,0);
           float y2 = map(yValues[x+1],0,80,height-100,0);
           line(x1,y1,x2,y2);
      }
  }
}