
float xRot = 0;
float yRot = 0;
float zRot = 0;
float zoom = 600;
boolean xUp, xDown, yUp, yDown, zUp, zDown;
int w = 10;

float t = 0;
float inc = 5.0;

float separation = 10;

OpenSimplexNoise noise;

void setup(){
  fullScreen(P3D);
  noise = new OpenSimplexNoise();
}

void draw(){
  background(0);
  fill(255);
  noStroke();
  push();
  translate(width/2,height/2,zoom);
  rotateX(-xRot);
  rotateY(-yRot);
  rotateZ(-zRot);
  
  colorMode(HSB);
  for (int x = 0; x < w; x++){
    for (int y = 0; y < w; y++) {
      for (int z = 0; z < w; z++) {
        push();
        float n = (float)noise.eval(x/inc,y/inc,z/inc,t);
        translate(x*separation-separation*w/2,y*separation-separation*w/2,z*separation-separation*w/2);
        fill(map(n,-.8,.8,0,255),255,255,100);
        sphere(n*10);
        pop();
      }
    }
  }
  t += 0.1;
  
  pop();
  rotateX(xRot);
  rotateY(yRot);
  rotateZ(zRot);
  rot();
}

void rot(){
  if (xUp) xRot += PI/30;
  if (xDown) xRot -= PI/30;
  if (zUp) zRot += PI/30;
  if (zDown) zRot -= PI/30;
  if (yUp) yRot += PI/30;
  if (yDown) yRot -= PI/30;
}

void keyPressed(){
  if(keyCode == RIGHT) yUp = true;
  if(keyCode == LEFT) yDown = true;
  if(keyCode == UP) xUp = true;
  if(keyCode == DOWN) xDown = true;
  if(key == 'p') zUp = true;
  if(key == 'o') zDown = true;
}

void keyReleased(){
  if(keyCode == RIGHT) yUp = false;
  if(keyCode == LEFT) yDown = false;
  if(keyCode == UP) xUp = false;
  if(keyCode == DOWN) xDown = false;
  if(key == 'p') zUp = false;
  if(key == 'o') zDown = false;  
}

void mouseWheel(MouseEvent event){
  zoom -= event.getCount() * 10;
}
