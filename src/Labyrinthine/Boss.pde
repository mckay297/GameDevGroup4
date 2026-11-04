// David Madden
class Boss{
// Member Variable
import Minotaurinthemaze.gif;
// Note: I don't know how to do animations, so I tryed to do it but it might not work
int x, y, health;
PImage cow1;
cow1 loopingGif;
//Constructor
this.x=width/2;
this.y= height/2;

health=1000
cow1 = loadImage(loopingGif, width/2, height/2);

  loopingGif = new Gif(this, "your_gif_file.gif");
  loopingGif.loop(); // Start playing/looping the GIF

// Member Methods
void display() {}
void engage() {}
void damage() {}
boolean attack() {}

}


