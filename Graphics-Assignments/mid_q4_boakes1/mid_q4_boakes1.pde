Table table;

ArrayList<Homicides> hs;

void setup(){
  table = loadTable("HomicideRates.txt","header, tsv");
  hs = new ArrayList<Homicides>();
   for(TableRow row: table.rows()){
     String country = row.getString("Country");
     float[] vals= new float[9];
      for(int x = 0;x<9;x++){
        Integer newX = (x+2001);
        float hRate = row.getFloat(newX.toString());
        vals[x] = hRate;
      }
      hs.add(new Homicides(country,vals));
  }
  size(1366,768);
}

void draw(){
   background(255);
     for(int x=0;x<9;x++){
     Integer newX = (x+2001);
     float x1 = map(x,-1,9,0,width);
     text(newX.toString(),x1-15,50);
     line(x1,75,x1,height-100);
     }
     for(Integer y=0;y<80;y+=10){
       float y1 = map(y,0,80,height-100,0);
       fill(0);
       text(y.toString(),50,y1);
       //line(0,y1,width,y1);
     }
   for(Homicides h: hs){
     h.draw();
   }
   
   text("Homicide Rates per 100,000 per year",width/2-100,height-50);
   
}