void Column( int sides, float r1, float h)
{
    float angle = 360 / sides;
    float midPoint = h / 2;
    
    float r2 = r1;
    
    pushMatrix();
    translate(0,midPoint,0);
    beginShape(QUADS);
    box(r1 * 3,r1 * 2,r1 * 3);
    popMatrix();
    pushMatrix();
    translate(0,-midPoint,0);
    box(r1 * 3,r1 * 2,r1 * 3);
    popMatrix();
    
    // top
    beginShape();
    for (int i = 0; i < sides; i++) {
        float x = cos( radians( i * angle ) ) * r1;
        float y = sin( radians( i * angle ) ) * r1;
        vertex( x, -midPoint, y);
    }
    endShape(CLOSE);
    // bottom
    beginShape();
    for (int i = 0; i < sides; i++) {
        float x = cos( radians( i * angle ) ) * r2;
        float y = sin( radians( i * angle ) ) * r2;
        vertex( x, -midPoint, y);
    }
    endShape(CLOSE);
    // draw body
    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i < sides + 1; i++) {
        float x1 = cos( radians( i * angle ) ) * r1;
        float y1 = sin( radians( i * angle ) ) * r1;
        float x2 = cos( radians( i * angle ) ) * r2;
        float y2 = sin( radians( i * angle ) ) * r2;
        vertex( x1, -midPoint, y1,0,100);
        vertex( x2, midPoint, y2,0,100);
        
    }
    endShape(CLOSE);
}