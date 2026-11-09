// Made by McKay Essig, David Madden, Marz Meyer, Connor Deweerd
import gifAnimation.*; 
Player p1;
int px,py;
float speed,stamina;
boolean upPressed,downPressed,leftPressed,rightPressed,sprinting,isStarted;
PImage startScreen;
void setup(){
  isStarted = false;
size(1080,720);
frameRate(30);
speed = 3;
stamina = 100;
startScreen = loadImage("Labyrinthine.png");
p1 = new Player(width/2,height/2);
}

void draw(){
  imageMode(CENTER);
background(120,120,120);
p1.display();
//UI
fill(0,256,0);
rect(20,60,stamina,30);
fill(256,0,0);
rect(20,20,p1.health,30);
// Sprint System
if(sprinting == true){
speed = 8;
stamina -= .8;
}else {if(stamina <100){
  stamina += .5;}
speed = 3;
}
if(stamina<0){
stamina = 0;
speed = 3;
}
//Movement management
 if (upPressed)    p1.y -= speed;
  if (downPressed)  p1.y += speed;
  if (leftPressed)  p1.x -= speed;
  if (rightPressed) p1.x += speed;
  //Startscreen
  if(isStarted == false){
image(startScreen,width/2,height/2);
}
}
//Keybinds
void keyPressed() {
  if (key == 'w' || key == 'W') {
    upPressed = true;
  } else if (key == 's' || key == 'S') {
    downPressed = true;
  } else if (key == 'a' || key == 'A') {
    leftPressed = true;
  } else if (key == 'd' || key == 'D') {
    rightPressed = true;
  }
  if (key == CODED) {
    if (keyCode == SHIFT) {
     sprinting = true;
    }
  }
}

void keyReleased() {
  if (key == 'w' || key == 'W') {
    upPressed = false;
  } else if (key == 's' || key == 'S') {
    downPressed = false;
  } else if (key == 'a' || key == 'A') {
    leftPressed = false;
  } else if (key == 'd' || key == 'D') {
    rightPressed = false;
  }
  if (key == CODED) {
    if (keyCode == SHIFT) {
     sprinting = false;
    }
  }
}
void mousePressed(){
println("mouseX," + mouseX + "mouseY," + mouseY);
if(mouseX > 200 && mouseY > 207 && mouseX <525 && mouseY <333){
  if (isStarted == false){
isStarted = true;}
}
}
